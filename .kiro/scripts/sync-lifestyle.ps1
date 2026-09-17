[CmdletBinding()]
param(
    [switch]$ValidateOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ExpectedRemote = 'https://github.com/branticonecoco-ui/diet.git'
$ExpectedBranch = 'docs/dieta-semanal'
$ExpectedAccount = 'branticonecoco-ui'
$CommitName = 'Kiro Lifestyle Sync'
$CommitEmail = '244629292+kiro-agent@users.noreply.github.com'
$LockTimeoutMinutes = 10
$MaximumFileSizeBytes = 50MB

function Write-SyncMessage {
    param([Parameter(Mandatory)][string]$Message)
    Write-Output "[lifestyle-sync] $Message"
}

function Invoke-GitCommand {
    param(
        [Parameter(Mandatory)][string[]]$Arguments,
        [switch]$Authenticated,
        [int[]]$AllowedExitCodes = @(0)
    )

    $prefix = @()
    if ($Authenticated) {
        # Reset the globally configured GitHub CLI helper for this command only.
        # This keeps repositories using roxcult untouched while this workspace
        # always selects the branticonecoco-ui credential in Git Credential Manager.
        $prefix = @(
            '-c', 'credential.helper=',
            '-c', 'credential.helper=manager',
            '-c', "credential.username=$ExpectedAccount"
        )
    }

    $allArguments = @($prefix + $Arguments)
    $previousErrorActionPreference = $ErrorActionPreference
    try {
        # Windows PowerShell convierte stderr nativo en ErrorRecord. Git escribe
        # mensajes normales como "Everything up-to-date" en stderr, por lo que
        # se captura con Continue y se decide el resultado solo por el exit code.
        $ErrorActionPreference = 'Continue'
        $output = @(& git @allArguments 2>&1)
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }

    if ($AllowedExitCodes -notcontains $exitCode) {
        $details = ($output | ForEach-Object { "$_" }) -join [Environment]::NewLine
        if ([string]::IsNullOrWhiteSpace($details)) {
            $details = 'Git no devolvió detalles adicionales.'
        }
        throw "Error de Git ($exitCode): git $($Arguments -join ' ')$([Environment]::NewLine)$details"
    }

    return $output | ForEach-Object { "$_" }
}

function Get-FirstGitLine {
    param([Parameter(Mandatory)][string[]]$Arguments)

    $line = Invoke-GitCommand -Arguments $Arguments | Select-Object -First 1
    if ($null -eq $line) {
        throw "Git no devolvió el valor esperado: git $($Arguments -join ' ')"
    }
    return "$line".Trim()
}

function Get-ChangedPaths {
    $paths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $sources = @(
        @(Invoke-GitCommand -Arguments @('diff', '--name-only', 'HEAD', '--')),
        @(Invoke-GitCommand -Arguments @('ls-files', '--others', '--exclude-standard', '--'))
    )

    foreach ($source in $sources) {
        foreach ($path in $source) {
            if (-not [string]::IsNullOrWhiteSpace($path)) {
                [void]$paths.Add("$path")
            }
        }
    }

    return @($paths | Sort-Object)
}

function Test-SensitivePath {
    param([Parameter(Mandatory)][string]$Path)

    $normalized = $Path.Replace('\', '/')
    $leaf = [System.IO.Path]::GetFileName($normalized)

    if ($normalized -match '(?i)(^|/)(\.ssh|\.aws)(/|$)') { return $true }
    if ($leaf -match '(?i)^\.env(?:\..+)?$') { return $true }
    if ($leaf -match '(?i)^\.git-credentials$') { return $true }
    if ($leaf -match '(?i)^\.(npmrc|pypirc)$') { return $true }
    if ($leaf -match '(?i)^(id_rsa|id_dsa|id_ecdsa|id_ed25519)(?:\..+)?$') { return $true }
    if ($leaf -match '(?i)\.(pem|key|p12|pfx|jks|keystore|kdbx)$') { return $true }
    if ($leaf -match '(?i)^(credentials|secrets?|service-account[^/]*)\.json$') { return $true }

    return $false
}

function Assert-ChangedPathsAreSafe {
    param(
        [Parameter(Mandatory)][string[]]$Paths,
        [Parameter(Mandatory)][string]$RepositoryRoot
    )

    $sensitive = @($Paths | Where-Object { Test-SensitivePath -Path $_ })
    if ($sensitive.Count -gt 0) {
        throw "Sincronización bloqueada: hay archivos potencialmente sensibles:$([Environment]::NewLine)- $($sensitive -join "$([Environment]::NewLine)- ")"
    }

    $oversized = [System.Collections.Generic.List[string]]::new()
    foreach ($path in $Paths) {
        $fullPath = Join-Path $RepositoryRoot $path
        if ((Test-Path -LiteralPath $fullPath -PathType Leaf) -and
            (Get-Item -LiteralPath $fullPath).Length -gt $MaximumFileSizeBytes) {
            $oversized.Add($path)
        }
    }

    if ($oversized.Count -gt 0) {
        throw "Sincronización bloqueada: hay archivos nuevos o modificados de más de 50 MB:$([Environment]::NewLine)- $($oversized -join "$([Environment]::NewLine)- ")"
    }
}

function Assert-NoGitOperationInProgress {
    param([Parameter(Mandatory)][string]$GitDirectory)

    $markers = @(
        'MERGE_HEAD',
        'CHERRY_PICK_HEAD',
        'REVERT_HEAD',
        'BISECT_LOG',
        'rebase-apply',
        'rebase-merge'
    )

    $active = @($markers | Where-Object { Test-Path -LiteralPath (Join-Path $GitDirectory $_) })
    if ($active.Count -gt 0) {
        throw "Sincronización bloqueada: hay una operación Git sin terminar ($($active -join ', '))."
    }
}

function Update-RemoteTrackingReference {
    Invoke-GitCommand -Authenticated -Arguments @(
        'fetch',
        '--quiet',
        'origin',
        "+refs/heads/$ExpectedBranch`:refs/remotes/origin/$ExpectedBranch"
    ) | Out-Null
}

function Assert-RemoteIsNotAhead {
    $remoteReference = "refs/remotes/origin/$ExpectedBranch"
    $behindCount = [int](Get-FirstGitLine -Arguments @('rev-list', '--count', "HEAD..$remoteReference"))

    if ($behindCount -gt 0) {
        throw "Sincronización bloqueada: origin/$ExpectedBranch contiene $behindCount commit(s) que no están en la copia local. Revisa e integra esos cambios manualmente."
    }
}

$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..')).TrimEnd('\', '/')
Push-Location $repositoryRoot

$lockPath = $null
try {
    $actualRoot = [System.IO.Path]::GetFullPath(
        (Get-FirstGitLine -Arguments @('rev-parse', '--show-toplevel'))
    ).TrimEnd('\', '/')

    if (-not [string]::Equals($actualRoot, $repositoryRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Sincronización bloqueada: el script no se está ejecutando en su repositorio esperado."
    }

    $actualRemote = (Get-FirstGitLine -Arguments @('remote', 'get-url', 'origin')).TrimEnd('/')
    if (-not [string]::Equals($actualRemote, $ExpectedRemote.TrimEnd('/'), [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Sincronización bloqueada: origin es '$actualRemote' y se esperaba '$ExpectedRemote'."
    }

    $actualBranch = Get-FirstGitLine -Arguments @('branch', '--show-current')
    if ($actualBranch -ne $ExpectedBranch) {
        throw "Sincronización bloqueada: la rama activa es '$actualBranch' y se esperaba '$ExpectedBranch'."
    }

    $gitDirectoryValue = Get-FirstGitLine -Arguments @('rev-parse', '--git-dir')
    $gitDirectory = if ([System.IO.Path]::IsPathRooted($gitDirectoryValue)) {
        [System.IO.Path]::GetFullPath($gitDirectoryValue)
    } else {
        [System.IO.Path]::GetFullPath((Join-Path $repositoryRoot $gitDirectoryValue))
    }

    Assert-NoGitOperationInProgress -GitDirectory $gitDirectory

    $lockPath = Join-Path $gitDirectory 'kiro-lifestyle-sync.lock'
    if (Test-Path -LiteralPath $lockPath) {
        $lockAge = (Get-Date) - (Get-Item -LiteralPath $lockPath).LastWriteTime
        if ($lockAge.TotalMinutes -lt $LockTimeoutMinutes) {
            Write-SyncMessage 'Ya hay otra sincronización en curso; esta ejecución termina sin hacer cambios.'
            return
        }
        Remove-Item -LiteralPath $lockPath -Force
    }

    Set-Content -LiteralPath $lockPath -Value "PID=$PID`nStarted=$([DateTime]::UtcNow.ToString('o'))" -Encoding UTF8

    $changedPaths = @(Get-ChangedPaths)
    Assert-ChangedPathsAreSafe -Paths $changedPaths -RepositoryRoot $repositoryRoot

    $remoteReference = "refs/remotes/origin/$ExpectedBranch"
    $localAheadBeforeFetch = 0
    try {
        $localAheadBeforeFetch = [int](Get-FirstGitLine -Arguments @('rev-list', '--count', "$remoteReference..HEAD"))
    } catch {
        # A missing remote-tracking reference is repaired by the authenticated fetch below.
        $localAheadBeforeFetch = 0
    }

    if (-not $ValidateOnly -and $changedPaths.Count -eq 0 -and $localAheadBeforeFetch -eq 0) {
        Write-SyncMessage 'No hay cambios locales que sincronizar.'
        return
    }

    Update-RemoteTrackingReference
    Assert-RemoteIsNotAhead

    if ($ValidateOnly) {
        Invoke-GitCommand -Authenticated -Arguments @(
            'push',
            '--dry-run',
            'origin',
            "HEAD`:refs/heads/$ExpectedBranch"
        ) | Out-Null
        Write-SyncMessage "Validación correcta: repositorio, rama, cuenta '$ExpectedAccount', permisos y protecciones operativos."
        return
    }

    if ($changedPaths.Count -gt 0) {
        $addArguments = @('add', '--all', '--') + $changedPaths
        Invoke-GitCommand -Arguments $addArguments | Out-Null

        $stagedPaths = @(Invoke-GitCommand -Arguments @('diff', '--cached', '--name-only', '--'))
        if ($stagedPaths.Count -gt 0) {
            $timestamp = [DateTime]::UtcNow.ToString('yyyy-MM-dd HH:mm:ss')
            $message = "chore(sync): update lifestyle $timestamp UTC"
            Invoke-GitCommand -Arguments @(
                '-c', "user.name=$CommitName",
                '-c', "user.email=$CommitEmail",
                'commit',
                '--message', $message
            ) | Out-Null
            Write-SyncMessage "Commit creado con $($stagedPaths.Count) archivo(s): $message"
        }
    }

    # Fetch again after committing to narrow the race window. A normal push still
    # rejects any concurrent remote update; force-push is intentionally impossible.
    Update-RemoteTrackingReference
    Assert-RemoteIsNotAhead

    $aheadCount = [int](Get-FirstGitLine -Arguments @('rev-list', '--count', "$remoteReference..HEAD"))
    if ($aheadCount -eq 0) {
        Write-SyncMessage 'No hay commits pendientes de publicar.'
        return
    }

    Invoke-GitCommand -Authenticated -Arguments @(
        'push',
        'origin',
        "HEAD`:refs/heads/$ExpectedBranch"
    ) | Out-Null

    Write-SyncMessage "Sincronización completada: $aheadCount commit(s) publicado(s) en $ExpectedAccount/diet ($ExpectedBranch)."
} catch {
    Write-Error "[lifestyle-sync] $($_.Exception.Message)"
    exit 1
} finally {
    if ($null -ne $lockPath -and (Test-Path -LiteralPath $lockPath)) {
        Remove-Item -LiteralPath $lockPath -Force -ErrorAction SilentlyContinue
    }
    Pop-Location
}
