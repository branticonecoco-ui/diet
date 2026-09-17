# Plan semanal de alimentación y recetario de cremas

Este repositorio documenta un plan alimentario personal, práctico y reproducible. Su objetivo es combinar **alta densidad nutricional, diversidad vegetal, seguridad alimentaria y preparación por lotes** sin convertir el menú en una prescripción clínica ni en una rutina rígida.

> **Punto de entrada para personas e IAs:** lee primero este README y después consulta la fuente correspondiente en la tabla siguiente. No deduzcas cantidades, equivalencias nutricionales ni estado operativo a partir de los PDF.

## Orientación rápida

| Necesidad | Fuente que debe consultarse |
|---|---|
| Entender objetivos, prioridades y decisiones nutricionales | [`.kiro/steering/contexto-dieta.md`](.kiro/steering/contexto-dieta.md) |
| Comparar y seguir AOVEs de alta carga fenólica | [`aceites-oliva-alto-fenolicos.md`](aceites-oliva-alto-fenolicos.md) |
| Saber qué se come y cuánto cada día | [`plan-semanal.md`](plan-semanal.md) |
| Preparar desayunos, comidas y acompañamientos | [`recetario-comidas.md`](recetario-comidas.md) |
| Preparar, enfriar, triturar, congelar y servir las cremas | [`recetario-cremas.md`](recetario-cremas.md) |
| Comprar ingredientes de los lotes de cremas | [`lista-compra-cremas.md`](lista-compra-cremas.md) |
| Imprimir el recetario y la compra de las cremas | [`recetario-cremas-imprimible.pdf`](recetario-cremas-imprimible.pdf) |
| Imprimir desayunos y comidas | [`recetario-comidas-imprimible.pdf`](recetario-comidas-imprimible.pdf) |

Las fuentes HTML de los imprimibles son [`recetario-cremas-imprimible.html`](recetario-cremas-imprimible.html) y [`recetario-comidas-imprimible.html`](recetario-comidas-imprimible.html).

## Objetivo del plan

El objetivo principal es **comer de la forma más saludable y nutritiva posible**, con un enfoque omnívoro, *food-first* y compatible con una vida cotidiana normal.

Prioridades:

- Mantener aproximadamente el peso y la energía disponible; no se busca adelgazar ni ganar peso deliberadamente.
- Aumentar la diversidad vegetal y la presencia de legumbres, crucíferas, hojas, setas, alliums, semillas, frutos secos y distintos pigmentos.
- Distribuir suficiente proteína y energía a lo largo de tres comidas.
- Combinar alimentos vegetales con fuentes fiables de nutrientes como B12, EPA/DHA, calcio, colina, hierro, zinc, selenio y, cuando la etiqueta lo permita, vitamina D.
- Favorecer una preparación repetible, congelación segura y baja dependencia de ultraprocesados.
- Ajustar volumen, energía y fibra según hambre, digestión, peso y actividad reales.

No es objetivo del proyecto:

- Maximizar proteína, fibra o número de ingredientes sin considerar tolerancia y energía total.
- Copiar protocolos de longevidad, suplementos o fármacos de terceros.
- Declarar que un nutriente está cubierto sin revisar cantidades, etiquetas y contexto completo.
- Sustituir valoración médica, analíticas o consejo profesional individualizado.

El domingo es un día familiar sin menú planificado. No debe utilizarse para garantizar nutrientes concretos ni compensarse con ayuno o restricción el lunes.

## Arquitectura semanal

El plan organiza tres comidas de lunes a sábado:

1. **Desayunos:** concentran lácteos o alternativas enriquecidas, cereales integrales, frutos rojos, semillas, frutos secos y una tostada con proteína variable.
2. **Comidas:** aportan la principal rotación de pescado, marisco, carne, cereales o patata, verduras y fruta.
3. **Cenas:** tienen como núcleo una crema distinta, sus complementos frescos y un acompañamiento específico de pan, skyr, huevo o fruta.

Los horarios del plan son orientativos. Si cambia la hora de levantarse o de entrenar, deben desplazarse manteniendo separaciones razonables, no seguirse al minuto.

## Función de las cremas

Las cremas no son un entrante accesorio: son el **núcleo estructural de las seis cenas**.

Cada crema combina verduras con una base de legumbre, edamame o tofu. La rotación busca diversidad de familias, colores y técnicas en lugar de depender de una única receta supuestamente perfecta:

- Lunes: crucíferas verde-moradas y alubia blanca.
- Martes: tomate, pimiento, zanahoria y garbanzo.
- Miércoles: crema verde hiperproteica con edamame y tofu.
- Jueves: raíces naranjas, lenteja y setas.
- Viernes: coliflor, alliums, setas y cannellini.
- Sábado: vegetales púrpura-rojos y alubia negra.

Cada receta produce **cinco raciones iguales por peso**. Se consume una y se congelan cuatro. Los seis lotes completos producen 30 cenas, equivalentes a cinco semanas de lunes a sábado.

Reglas del sistema:

- No diluir una crema solo para alcanzar 2,5 litros: se pesa el resultado real y se divide entre cinco.
- Los complementos frescos, cítricos, hierbas, AOVE, semillas y frutos secos se añaden después del recalentado; no se congelan dentro de la base.
- Las cremas no garantizan por sí solas B12, yodo, vitamina D, EPA/DHA ni toda la energía y proteína necesarias. El resto del menú completa esas funciones.
- Antes de producir los seis lotes debe hacerse la fase piloto descrita en el recetario.

## Jerarquía de fuentes

Este orden evita que una lista o un PDF accidentalmente desactualizado modifique el plan.

> **Excepción de seguridad:** el manual de la unidad concreta y las instrucciones de seguridad o preparación del envase prevalecen siempre sobre los rangos y procedimientos orientativos de este repositorio. La jerarquía siguiente solo se aplica cuando no contradice esas instrucciones.

1. **Intención, contexto y criterios de decisión:** `.kiro/steering/contexto-dieta.md`.
2. **Menú y cantidades diarias:** `plan-semanal.md`.
3. **Preparación, equipos y seguridad:** `recetario-comidas.md` y `recetario-cremas.md`.
4. **Compra derivada:** `lista-compra-cremas.md`.
5. **Imprimibles derivados:** archivos HTML y PDF.

Si existe un conflicto:

- Para decidir **por qué** se hace algo, prevalece el contexto.
- Para decidir **qué y cuánto** se come, prevalece el plan semanal.
- Para decidir **cómo cocinarlo o conservarlo**, prevalece el recetario correspondiente, salvo que el manual de la unidad concreta o el envase establezcan una instrucción más restrictiva.
- Si una lista o imprimible difiere de los Markdown, no debe corregirse únicamente el PDF: se actualiza primero la fuente autoritativa y después todos los derivados afectados.
- Si la documentación no permite resolver el conflicto, hay que preguntar; no inventar.

## Convenciones de cantidades

- Avena, arroz, pasta, quinoa y bulgur se pesan en seco.
- Carne y pescado se pesan crudos y listos para cocinar, salvo que se indique conserva.
- Conservas, mejillones sin concha y remolacha en conserva se pesan escurridos.
- En las cremas, legumbres, lentejas, guisantes y edamame se indican cocidos y escurridos.
- El tofu se pesa escurrido. Solo debe atribuirse calcio si la etiqueta acredita una sal de calcio.
- Las verduras de los lotes se expresan como peso útil, limpio y listo para cocinar. Al comprar piezas enteras puede ser necesario añadir aproximadamente un 5–15 %.
- Las setas se pesan limpias. Solo debe contabilizarse vitamina D si la etiqueta acredita exposición UV o contenido de vitamina D.
- “Skyr” puede sustituirse por yogur natural alto en proteína con una composición comparable. Deben compararse por 100 g al menos proteína, energía, calcio, azúcares y sodio; aportar aproximadamente 9–11 g de proteína es necesario, pero no demuestra por sí solo equivalencia nutricional.
- Agua y caldo no son intercambiables con líquidos salados sin revisar el sodio total.

## Reglas para sustituciones

Las recetas originales se conservan. Las alternativas deben documentarse en un bloque separado y sincronizarse en plan, recetario, lista e imprimible cuando afecten a esos documentos.

Sustituciones actualmente verificadas en los Markdown:

- Kale por nabizas, manteniendo el mismo peso útil.
- Berros por rúcula en el servicio del miércoles.
- Cáñamo por nueces, con la advertencia de que **no son equivalentes nutricionalmente** y las nueces aportan menos proteína.

Principios obligatorios:

- La flexibilidad estacional se aplica a los espacios que el plan deja abiertos —“1 fruta”, “ensalada variada”, “otras verduras” o “verduras al vapor”—, manteniendo el peso total indicado cuando exista. No autoriza a reemplazar ingredientes nombrados o estratégicos sin documentarlo.
- Original y alternativa no se suman salvo que sus pesos combinados mantengan la cantidad prescrita.
- Una equivalencia culinaria no debe presentarse automáticamente como equivalencia nutricional.
- No sustituir ingredientes estratégicos —por ejemplo sardina con espina, tofu con calcio o setas UV— sin revisar qué función se pierde.
- Los cambios deben evaluarse en el día y la semana completos, no solo en la receta aislada.
- No añadir suplementos o fármacos como solución automática.

## Seguridad y equipos

Las instrucciones completas están en los recetarios. Este resumen no las sustituye:

- **Kenwood FS620:** depósito únicamente con agua fría entre `MIN` y `MAX`. Los tiempos empiezan con vapor estable. Las cestas superiores pueden necesitar más tiempo.
- **Braun PowerBlend 9:** no introducir alimentos hirviendo ni usar `Hot Soup` para cocinar. Triturar manualmente tras enfriado activo y sin superar aproximadamente 1,25 litros por tanda.
- Enfriar los componentes en recipientes bajos sin dejarlos durante horas sobre la encimera. El tiempo acumulado fuera del frío debe mantenerse dentro de dos horas, o una si el ambiente supera 32 °C.
- Frigorífico a 4 °C o menos y congelador a −18 °C o menos.
- Descongelar en nevera o microondas, no sobre la encimera.
- Recalentar una sola vez, removiendo, hasta 74 °C en toda la ración.
- Las cuatro porciones congeladas se etiquetan con nombre, fecha y peso. El recetario utiliza cuatro semanas como límite conservador de calidad.
- Seguir siempre el tiempo superior o la precaución específica del envase cuando difiera del rango orientativo del recetario.

## Fase piloto y seguimiento

Antes de cocinar los seis lotes completos:

1. Preparar una o dos recetas a media escala.
2. Dividir aun así el resultado entre cinco medias porciones.
3. Registrar tiempos reales, líquido utilizado, peso final, peso por ración y capacidad de los equipos.
4. Comprobar textura después de congelar y recalentar.
5. Observar tolerancia a legumbres, crucíferas, alliums y volumen de fibra.
6. Si una ración próxima a 500 ml resulta excesiva, empezar con 300–400 ml y ajustar el resto de la cena.

Durante las primeras semanas deben observarse tendencia de peso, hambre, energía, digestión y actividad. Las cifras energéticas y nutricionales del contexto son hipótesis de diseño, no resultados medidos ni una auditoría reproducible. Hasta que exista un cálculo versionado por día con fuentes de composición, etiquetas y pesos reales, no deben utilizarse para afirmar suficiencia exacta.

## Estado operativo que debe confirmarse

El repositorio describe el diseño, pero no mantiene todavía un diario fiable del estado cotidiano. Antes de hacer una compra grande, producir todos los lotes, recalcular nutrientes o modificar el menú, una persona o IA debe confirmar:

- Si la fase piloto ya se realizó y con qué resultados.
- Semana o ciclo actual y raciones que quedan congeladas.
- Sustituciones que se están utilizando realmente.
- Si todavía queda jamón cocido de la transición temporal.
- Marcas y etiquetas reales de bebida vegetal, tofu, conservas, pan, caldo y setas.
- Tolerancia digestiva y volumen real de cada ración.
- Frecuencia y horario actuales de natación u otra actividad.
- Capacidad disponible de congelador y recipientes.
- Comida familiar habitual del domingo, si se necesita evaluar la semana completa.

La ausencia de estos datos no debe rellenarse con suposiciones.

## Instrucciones para una IA o colaborador nuevo

Antes de responder o modificar el repositorio:

1. Lee este README.
2. Lee `.kiro/steering/contexto-dieta.md` para entender intención y límites.
3. Consulta el plan y el recetario relevantes; no propongas cambios sobre archivos que no hayas revisado.
4. Pregunta por etiquetas o estado operativo cuando sean necesarios para una conclusión precisa.
5. Conserva las recetas originales y añade alternativas por separado.
6. Revisa el impacto del cambio en energía, proteína, fibra, calcio, hierro, zinc, B12, yodo, vitamina D, sodio y omega-3 cuando corresponda.
7. Sincroniza todos los documentos derivados afectados.
8. Verifica cantidades, estados de pesado, enlaces, maquetación de imprimibles y coherencia semanal antes de publicar.

## Actualización de documentos e imprimibles

Flujo recomendado para cualquier cambio:

1. Modificar primero el Markdown autoritativo.
2. Actualizar el plan, recetario o lista relacionados si el cambio los afecta.
3. Actualizar el HTML imprimible correspondiente.
4. Regenerar el PDF desde el HTML, sin editar manualmente el PDF.
5. Comprobar impresión en blanco y negro, formato A4 y ausencia de recortes.
6. Revisar enlaces y ejecutar `git diff --check` antes de confirmar el cambio.

Formato esperado de los imprimibles actuales:

- Cremas: una página A4, seis tarjetas.
- Desayunos y comidas: dos páginas A4, doce tarjetas.

En el imprimible de comidas, la frase “CENA SIN CREMA” significa **acompañamiento de la cena sin contar la crema**, no una cena que deba omitirla.

## Deuda documental conocida

Estas divergencias deben resolverse en las fuentes autoritativas. Mientras tanto, se aplican la jerarquía y las reglas conservadoras de este README:

- El contexto menciona “tres archivos de trabajo”, pero enumera cuatro: plan, dos recetarios y lista de compra. Deben revisarse los cuatro cuando el cambio atraviese esos dominios.
- `recetario-comidas.md` menciona cebada en las convenciones, aunque no aparece programada en `plan-semanal.md`. No debe introducirse sin documentar día, sustitución y cantidad.
- La autorización genérica para cambiar frutas y verduras por producto de temporada se interpreta únicamente para los espacios que el plan deja abiertos; no permite sustituir ingredientes nombrados o estratégicos.
- Los intervalos de energía, proteína, fibra y otros nutrientes del contexto no tienen todavía un cálculo diario versionado y reproducible. Son hipótesis, no prueba de cobertura.
- El criterio de proteína del sustituto del skyr es insuficiente por sí solo; también deben compararse energía, calcio, azúcares y sodio.
- La expresión “CENA SIN CREMA” del imprimible de comidas significa acompañamiento de la cena sin contar la crema, no una cena que deba omitirla.

Además, estas alternativas aparecen únicamente en el imprimible de cremas y no deben tratarse como reglas canónicas sin verificación adicional:

- Jengibre fresco por jengibre molido en la crema del jueves.
- Apionabo por apio más coliflor adicional en la crema del viernes.
- Cannellini por otra alubia blanca en la crema del viernes.

Ante cualquiera de estas divergencias, debe consultarse la fuente Markdown, confirmarse la decisión y sincronizar después todos los documentos afectados.

## Sincronización automática de este workspace

El hook de workspace `.kiro/hooks/lifestyle-github-sync.json` ejecuta `.kiro/scripts/sync-lifestyle.ps1` al finalizar cada ejecución de Kiro. Si existen cambios, el script crea un commit y lo publica exclusivamente en `https://github.com/branticonecoco-ui/diet.git`, rama `docs/dieta-semanal`.

La autenticación se selecciona por comando mediante Git Credential Manager y la cuenta `branticonecoco-ui`. No modifica la configuración Git global ni la autenticación de `roxcult` utilizada por otros repositorios.

Protecciones incorporadas:

- comprueba la raíz, el remoto y la rama exactos antes de actuar;
- bloquea archivos de credenciales, claves y otros secretos comunes, así como archivos modificados de más de 50 MB;
- no actúa durante merges, rebases u otras operaciones Git incompletas;
- se detiene si la rama remota contiene commits ausentes localmente;
- nunca hace `pull`, rebase automático ni `force push`;
- utiliza un bloqueo temporal para evitar dos sincronizaciones simultáneas;
- si un commit local no puede publicarse, lo conserva para reintentarlo o revisarlo manualmente.

Validación manual sin crear commits ni modificar GitHub:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".kiro/scripts/sync-lifestyle.ps1" -ValidateOnly
```

El hook puede consultarse o desactivarse desde la sección **Agent Hooks** de Kiro.

## Alcance

Este repositorio es una herramienta de organización y documentación alimentaria. Las decisiones clínicas, suplementación, interpretación de analíticas y tratamiento de enfermedades quedan fuera de su alcance y requieren profesionales cualificados.
