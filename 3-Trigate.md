
# Trigate: Relacion de razonamiento.


## Abstract

Presentamos una nueva versión del **Trigate**, concebido como una evolución de la puerta lógica dinámica. El Trigate supera el modelo clásico de puerta orientada únicamente al cálculo de una salida, ya que permite operar de forma reversible sobre dominios ternarios y utilizar una misma relación para aprendizaje, inferencia y deducción básica.

En esta versión, el Trigate funciona también como núcleo mínimo de un sistema CSP ternario capaz de detectar contradicciones locales, conservarlas como información estructural y activar mecanismos de recuperación mediante redundancia contextual. De este modo, el error deja de ser un fallo terminal y se convierte en una señal operativa para buscar coherencia dentro del grafo.

Además, el Trigate puede interpretarse como una **hiperarista orientable**: una relación entre varios nodos cuya dirección de resolución cambia según la variable de control `C`. Esta propiedad permite que la información circule en distintas direcciones sin romper la coherencia formal del sistema, convirtiendo al Trigate en una unidad mínima de resolución distribuida dentro de Transcender.

El Trigate está diseñado para funcionar mediante **suscripción a eventos de sus nodos**. De esta forma, permite que el sistema opere de manera asíncrona, sin necesidad de un control centralizado. El propio sistema puede ir autogestionando su evolución a medida que aparecen nuevos contextos, nuevas restricciones y nuevas contradicciones locales.

---

## 1. Definición

Un **Trigate** es la unidad mínima de resolución ternaria del sistema Transcender.

No debe entenderse como una puerta lógica clásica. Una puerta lógica clásica calcula una salida a partir de unas entradas. El Trigate, en cambio, opera como una **restricción reversible** entre cuatro variables:

- **A**: primera entrada.
- **B**: segunda entrada.
- **M**: modo lógico aplicado.
- **R**: resultado observado o inferido.

Además, el Trigate utiliza tres elementos de control y estado:

- **C**: variable de control que indica qué relación se está resolviendo.
- **E**: estado de coherencia local de la resolución.
- **F**: evolución local de la coherencia tras la operación.

La función principal del Trigate no es asignar valores cerrados, sino **reducir dominios posibles**. Su operación consiste en leer los dominios actuales de sus variables, calcular qué combinaciones siguen siendo compatibles y restringir el dominio de la variable objetivo.

Forma general:

```text
Trigate(A, B, M, R, C) → dominio restringido, E, F

La misma estructura puede utilizarse para tres operaciones distintas:

aprender qué modo lógico explica una relación observada;
inferir un resultado a partir de entradas y modo;
deducir una entrada posible a partir de una entrada, el modo y el resultado.

Esta reversibilidad convierte al Trigate en una pieza adecuada para redes CSP ternarias, grafos de propagación y sistemas de resolución distribuida.

2. Dominio ternario

El Trigate trabaja sobre el dominio ternario:

T = {0, 1, 2}

Interpretación operacional:

Valor	Nombre	Significado
0	LOW	valor bajo, falso o inactivo
1	HIGH	valor alto, verdadero o activo
2	UNKNOWN	valor no cerrado, abierto o no resuelto

El valor 2 no debe interpretarse como un tercer valor lógico ordinario equivalente a 0 o 1. Su función principal es representar apertura de dominio, incertidumbre o falta de cierre.

Cada variable del Trigate posee un dominio propio:

D(A), D(B), D(M), D(R), D(C) ⊆ {0, 1, 2}

Dominios posibles:

Dominio	Interpretación
{}	no existe ningún valor compatible
{0}	la variable queda cerrada en 0
{1}	la variable queda cerrada en 1
{2}	la variable queda explícitamente desconocida
{0,1}	la variable puede ser 0 o 1
{0,2}	la variable puede ser 0 o desconocido
{1,2}	la variable puede ser 1 o desconocido
{0,1,2}	la variable está completamente abierta

Debe distinguirse siempre entre:

D = {2}

y:

D = {}

D = {2} significa que el valor compatible es desconocido o abierto.
D = {} significa que no hay ningún valor compatible con las restricciones actuales.

3. Valor operativo del nodo

Los nodos del sistema operan internamente como dominios ternarios, pero pueden exponer un valor operativo.

Regla de valor operativo:

Dominio interno	Valor operativo	Estado
{0}	0	E = 1
{1}	1	E = 1
{2}	2	E = 0
dominio con más de un elemento	2	E = 0
{}	2	E = 2

Forma compacta:

Dominio unitario cerrado → valor del único elemento, E = 1
Dominio múltiple        → valor operativo 2, E = 0
Dominio vacío           → valor operativo 2, E = 2

Esta regla permite propagar valores simples sin perder la información formal del dominio interno.

4. Estado de coherencia E

El estado E describe la coherencia local de la resolución realizada por el Trigate.

E ∈ {0, 1, 2}
E	Nombre	Significado
0	ambiguo	la resolución sigue abierta
1	coherente	la resolución queda cerrada de forma consistente
2	contradictorio	no existe solución local compatible

Regla normativa:

D = {}      → E = 2
|D| = 1     → E = 1
|D| > 1     → E = 0

Para el caso especial D = {2}:

D = {2} → E = 0

porque 2 representa apertura o desconocimiento, no contradicción.

La contradicción la indica E = 2, no el valor 2 por sí mismo.

5. Diferencia entre desconocido y contradicción

La distinción más importante del Trigate es:

R = 2, E = 0

frente a:

R = 2, E = 2
Caso	Interpretación
R = 2, E = 0	el resultado es desconocido, pero no hay contradicción
R = 2, E = 2	existe contradicción local y la salida visible queda degradada

Regla estructural:

El valor 2 indica apertura.
El estado E indica coherencia.

Cuando aparece una contradicción local, el Trigate puede exportar un valor visible 2 para permitir que la red siga operando. Sin embargo, internamente debe conservarse:

D_interno = {}
valor_visible = 2
E = 2

Esta separación permite que la red use la contradicción como una solicitud de redundancia, en lugar de tratarla como un fallo terminal.

6. Modos lógicos M

La variable M indica qué operación lógica ternaria relaciona A, B y R.

M ∈ {0, 1, 2}
M	Nombre	Criterio principal
0	OR3	el valor 1 domina
1	AND3	el valor 0 domina
2	CONSENSUS3	solo cierra si hay acuerdo
6.1. M = 0 — OR3

El modo OR3 representa una disyunción ternaria.

Principio:

Si alguna entrada cerrada vale 1, el resultado tiende a 1.

Cuando no hay información suficiente para cerrar el resultado, el dominio permanece abierto.

6.2. M = 1 — AND3

El modo AND3 representa una conjunción ternaria.

Principio:

Si alguna entrada cerrada vale 0, el resultado tiende a 0.

Cuando no hay información suficiente para cerrar el resultado, el dominio permanece abierto.

6.3. M = 2 — CONSENSUS3

El modo CONSENSUS3 representa una relación de acuerdo.

Principio:

El resultado solo se cierra cuando las entradas ofrecen una señal compatible común.

Si las entradas no permiten establecer consenso, el resultado queda abierto o se marca contradicción, según el caso.

7. Variable de control C

La variable C determina qué parte de la relación queda abierta para ser resuelta.

C ∈ {0, 1, 2}
C	Nombre	Relación utilizada	Variable objetivo
0	aprendizaje	A, B, R → M	D(M)
1	inferencia	A, B, M → R	D(R)
2	deducción	A, M, R → B	D(B)

La variable C no cambia las reglas lógicas internas. Solo cambia qué variable se considera objetivo de resolución.

7.1. C = 0 — Aprendizaje
A, B, R → D(M)

Pregunta:

¿Qué modo lógico podría explicar esta relación observada?
7.2. C = 1 — Inferencia
A, B, M → D(R)

Pregunta:

¿Qué resultado es compatible con estas entradas y este modo lógico?
7.3. C = 2 — Deducción
A, M, R → D(B)

Pregunta:

¿Qué valor de B haría compatible la relación?

La deducción simétrica sobre A también es posible conceptualmente:

B, M, R → D(A)

Sin embargo, esta especificación define como forma normativa principal la deducción sobre B, para mantener una versión mínima.

7.4. C abierto

Si D(C) contiene varios modos posibles, el Trigate calcula las restricciones compatibles para todos los modos de control permitidos y aplica solo las reducciones comunes seguras.

D(C) múltiple → aplicar solo reducciones comunes seguras

Esto evita cerrar prematuramente una variable cuando todavía existe ambigüedad estructural.

8. Operación general

El Trigate opera siempre como una restricción sobre dominios.

No asigna directamente un valor a la variable objetivo. Calcula el conjunto de valores compatibles y lo intersecta con el dominio actual de esa variable.

Regla general:

D_objetivo' = D_objetivo ∩ D_compatible

Donde:

D_objetivo es el dominio actual de la variable objetivo.
D_compatible es el dominio permitido por la relación del Trigate.
D_objetivo' es el nuevo dominio restringido.

Principio estricto:

Un Trigate reduce dominios. No los amplía durante operación normal.

Una ampliación solo puede producirse mediante un mecanismo externo explícito, como:

reinicio de ventana de resolución;
relajación controlada;
intervención de una capa superior;
entrada redundante que reabra formalmente el problema.
9. Contradicción local y redundancia

Una contradicción local aparece cuando el dominio objetivo queda vacío:

D_objetivo = {}
E = 2

En el Trigate, una contradicción local no debe interpretarse como fallo terminal del sistema.

Debe interpretarse como una señal estructural:

E = 2 → solicitud de redundancia

La contradicción puede indicar:

una observación incompatible con los modos actuales;
una entrada mal cerrada;
falta de información contextual;
reducción prematura del dominio;
necesidad de una ruta alternativa de propagación.

La recuperación de una contradicción no ocurre porque el Trigate amplíe espontáneamente su propio dominio. La recuperación ocurre cuando el grafo aporta nueva información mediante:

otro Trigate conectado;
una ruta alternativa de propagación;
una capa superior de resolución;
una ventana de recomputación;
una política explícita de relajación.

Regla de diseño:

La contradicción se resuelve por contexto, no por olvido.

Si se transforma D = {} en D = {2} sin conservar E = 2, el sistema olvida que hubo contradicción.

10. Modelo de eventos

El Trigate funciona dentro de un grafo de propagación.

Cada Trigate se conecta a nodos que representan sus variables:

A, B, M, R, C

Cada nodo mantiene un dominio actual:

D(A), D(B), D(M), D(R), D(C)

El Trigate se suscribe a los cambios de esos nodos:

A.changed
B.changed
M.changed
R.changed
C.changed

Cuando recibe un evento, recalcula las restricciones correspondientes según C.

10.1. Evento mínimo
Event {
  node_id,
  old_domain,
  new_domain,
  source_trigate_id,
  clock
}
10.2. Eventos según C
C	Modo	Eventos relevantes principales	Objetivo
0	aprendizaje	A.changed, B.changed, R.changed	M
1	inferencia	A.changed, B.changed, M.changed	R
2	deducción	A.changed, M.changed, R.changed	B

Los cambios en C siempre son relevantes:

C.changed → recalcular modo operativo
10.3. Regla anti-bucle

Para evitar propagación infinita:

Si el evento no reduce dominio, no se emite un nuevo evento de dominio.

Regla adicional:

Si source_trigate_id == este Trigate
y el dominio no cambió desde la última operación,
entonces ignorar el evento.
10.4. Evento de estado E

El estado E también puede emitir eventos:

E.changed

Esto ocurre cuando:

E_nuevo ≠ E_anterior

En particular:

E = 2

puede activar mecanismos de redundancia, revisión o intervención de capas superiores.

11. Métrica local F

La métrica F describe la evolución local de coherencia de un Trigate tras una operación.

F ∈ {0, 1, 2}
F	Nombre	Significado
0	neutro	la operación mantiene la coherencia local
1	corrector	la operación mejora la coherencia local
2	contraproducente	la operación empeora la coherencia local

Diferencia entre E y F:

Variable	Qué mide
E	estado actual de coherencia
F	cambio entre dos estados

Forma compacta:

E = estado
F = evolución
11.1. Orden de calidad de E

Para calcular F, se define un orden de calidad entre estados:

E = 2 < E = 0 < E = 1
E	Calidad
2	contradicción
0	ambigüedad
1	coherencia cerrada
11.2. Tabla de transición
E anterior	E nuevo	F	Interpretación
2	1	1	corrección fuerte
2	0	1	reducción de contradicción a ambigüedad
0	1	1	cierre coherente
1	1	0	estabilidad coherente
0	0	0	ambigüedad estable
2	2	0	contradicción persistente
1	0	2	pérdida de cierre
1	2	2	caída a contradicción
0	2	2	ambigüedad convertida en contradicción
11.3. Uso arquitectónico de F

F sirve para que capas superiores puedan:

detectar rutas correctoras;
identificar zonas inestables del grafo;
priorizar redundancia;
medir convergencia local;
activar revisión cuando una operación empeora el estado.

F no garantiza convergencia global. Solo informa de la dirección local del cambio.

12. Pseudocódigo operativo
onNodeChanged(event):

  leer D(A), D(B), D(M), D(R), D(C)

  E_anterior = E

  determinar modos C compatibles

  para cada modo C compatible:

      calcular variable objetivo X

      calcular D_compatible(X)

  combinar restricciones seguras sobre X

  D_nuevo(X) = D_actual(X) ∩ D_compatible(X)

  E_nuevo = estado(D_nuevo(X))

  F = calcularF(E_anterior, E_nuevo)

  si D_nuevo(X) ⊂ D_actual(X):

      actualizar D(X)

      emitir X.changed

  si E_nuevo ≠ E_anterior:

      actualizar E

      emitir E.changed

  si F indica cambio relevante:

      emitir métrica F

Funciones auxiliares:

estado(D):

  si D = {}:
      devolver 2

  si |D| = 1:
      devolver 1

  si |D| > 1:
      devolver 0
calcularF(E_anterior, E_nuevo):

  calidad(2) = 0
  calidad(0) = 1
  calidad(1) = 2

  si calidad(E_nuevo) > calidad(E_anterior):
      devolver 1

  si calidad(E_nuevo) = calidad(E_anterior):
      devolver 0

  si calidad(E_nuevo) < calidad(E_anterior):
      devolver 2
13. Tablas normativas

Las tablas normativas definen el comportamiento mínimo esperado del Trigate.

No son ejemplos. Son el contrato operativo que debe respetar cualquier implementación compatible.

13.1. Convenciones
Símbolo	Significado
0	LOW
1	HIGH
2	desconocido / no resuelto
E = 0	ambiguo
E = 1	coherente
E = 2	contradicción

Modos lógicos:

M	Modo
0	OR3
1	AND3
2	CONSENSUS3

Regla general:

D = {}          → E = 2
D = {0} o {1}  → E = 1
D múltiple     → E = 0
D = {2}        → E = 0
13.2. C = 0 — Aprendizaje

En modo aprendizaje:

A, B, R → D(M), E
A	B	R	D(M)	E
0	0	0	{OR, AND, CONS}	0
0	0	1	{}	2
0	0	2	{OR, AND, CONS}	0
0	1	0	{AND}	1
0	1	1	{OR}	1
0	1	2	{OR, AND, CONS}	0
0	2	0	{OR, AND, CONS}	0
0	2	1	{OR}	1
0	2	2	{OR, AND, CONS}	0
1	0	0	{AND}	1
1	0	1	{OR}	1
1	0	2	{OR, AND, CONS}	0
1	1	0	{}	2
1	1	1	{OR, AND, CONS}	0
1	1	2	{OR, AND, CONS}	0
1	2	0	{AND}	1
1	2	1	{OR, AND, CONS}	0
1	2	2	{OR, AND, CONS}	0
2	0	0	{OR, AND, CONS}	0
2	0	1	{OR}	1
2	0	2	{OR, AND, CONS}	0
2	1	0	{AND}	1
2	1	1	{OR, AND, CONS}	0
2	1	2	{OR, AND, CONS}	0
2	2	0	{OR, AND, CONS}	0
2	2	1	{OR, AND, CONS}	0
2	2	2	{OR, AND, CONS}	0

Lectura normativa:

Aprender = reducir D(M)

Si ningún modo explica la observación:

D(M) = {}
E = 2

Si un único modo explica la observación:

|D(M)| = 1
E = 1

Si varios modos explican la observación:

|D(M)| > 1
E = 0
13.3. C = 1 — Inferencia

En modo inferencia:

A, B, M → D(R), E
M = OR3
A	B	D(R)	E
0	0	{0}	1
0	1	{1}	1
0	2	{2}	0
1	0	{1}	1
1	1	{1}	1
1	2	{1}	1
2	0	{2}	0
2	1	{1}	1
2	2	{2}	0
M = AND3
A	B	D(R)	E
0	0	{0}	1
0	1	{0}	1
0	2	{0}	1
1	0	{0}	1
1	1	{1}	1
1	2	{2}	0
2	0	{0}	1
2	1	{2}	0
2	2	{2}	0
M = CONSENSUS3
A	B	D(R)	E
0	0	{0}	1
0	1	{2}	0
0	2	{2}	0
1	0	{2}	0
1	1	{1}	1
1	2	{2}	0
2	0	{2}	0
2	1	{2}	0
2	2	{2}	0
13.4. C = 2 — Deducción de B

En modo deducción:

A, M, R → D(B), E
M = OR3
A	R	D(B)	E
0	0	{0}	1
0	1	{1}	1
0	2	{0,1}	0
1	0	{}	2
1	1	{0,1}	0
1	2	{0,1}	0
2	0	{0}	1
2	1	{0,1}	0
2	2	{0,1}	0
M = AND3
A	R	D(B)	E
0	0	{0,1}	0
0	1	{}	2
0	2	{0,1}	0
1	0	{0}	1
1	1	{1}	1
1	2	{0,1}	0
2	0	{0,1}	0
2	1	{1}	1
2	2	{0,1}	0
M = CONSENSUS3
A	R	D(B)	E
0	0	{0}	1
0	1	{}	2
0	2	{0,1}	0
1	0	{}	2
1	1	{1}	1
1	2	{0,1}	0
2	0	{0}	1
2	1	{1}	1
2	2	{0,1}	0
14. Observación sobre las tablas de deducción

En las tablas de deducción, los dominios resultantes suelen expresarse sobre {0,1} y no sobre {0,1,2}.

Esto significa que, al deducir una entrada, el valor 2 se trata como falta de información, no como candidato ordinario equivalente a 0 o 1.

Regla recomendada:

2 no es un tercer valor lógico ordinario.
2 representa apertura o falta de cierre.

Si en una futura versión se quisiera permitir 2 como candidato interno pleno en deducción, habría que generar una variante explícita de estas tablas.

15. Invariantes finales
15.1. Dominio ternario

Toda variable del Trigate opera sobre:

T = {0, 1, 2}

Todo dominio interno debe cumplir:

D(X) ⊆ T

para:

X ∈ {A, B, M, R, C}
15.2. Reducción

Durante operación normal, el Trigate solo puede reducir dominios:

D_nuevo(X) ⊆ D_anterior(X)

No puede ampliarlos por sí mismo.

15.3. Intersección

Toda restricción se aplica por intersección:

D_nuevo(X) = D_actual(X) ∩ D_compatible(X)
15.4. No asignación directa

El Trigate no asigna valores directamente.

Reduce dominios.

Un valor queda cerrado solo cuando el dominio resultante es unitario y coherente:

|D(X)| = 1
E = 1
15.5. Separación entre valor 2 y contradicción

El valor 2 no significa contradicción por sí mismo.

2 ≠ error

La contradicción la indica:

E = 2

Por tanto:

D = {2}, E = 0

significa apertura o desconocimiento.

Mientras que:

D = {}, E = 2

significa contradicción formal.

15.6. Contradicción conservada

Cuando aparece una contradicción local, el sistema no debe ocultarla convirtiéndola sin más en desconocimiento.

Forma correcta:

D_interno = {}
E = 2

Aunque hacia otras capas pueda exportarse:

valor_visible = 2

Regla:

La contradicción se resuelve por contexto, no por olvido.
15.7. Control C

La variable C no modifica la lógica interna del Trigate.

Solo determina qué variable queda como objetivo de resolución.

C	Objetivo
0	M
1	R
2	B

La relación estructural sigue siendo siempre:

A, B, M, R

Lo que cambia es la dirección de propagación de la restricción.

15.8. Estado E

El estado E se calcula a partir del dominio resultante de la variable objetivo.

D = {}      → E = 2
|D| = 1     → E = 1
|D| > 1     → E = 0
15.9. Eventos

Un Trigate solo debe emitir eventos cuando haya información nueva.

Esto ocurre si:

D_nuevo(X) ⊂ D_anterior(X)

o si:

E_nuevo ≠ E_anterior

Si no hay reducción de dominio ni cambio de estado, no debe emitirse evento.

15.10. Anti-bucle

Regla mínima:

Si el evento no reduce ningún dominio, no se emiten nuevos eventos de dominio.

Regla adicional:

Si source_trigate_id == este Trigate
y el dominio no cambió desde la última operación,
entonces ignorar el evento.
15.11. Redundancia

E = 2 debe activar revisión, redundancia o intervención contextual.

E = 2 → solicitar contexto

La contradicción local debe tratarse como una señal de resolución distribuida.

15.12. F

La métrica F se calcula comparando el estado anterior y el estado nuevo:

F = evolución(E_anterior, E_nuevo)

Con orden de calidad:

E = 2 < E = 0 < E = 1

F no describe el estado actual. Describe la dirección del cambio.

E = estado
F = evolución
15.13. Alcance local

Ni E ni F deben interpretarse como garantía de convergencia global.

Ambos son indicadores locales.

La coherencia global surge de la convergencia entre múltiples restricciones locales, no de una única operación del Trigate.

16. Cierre normativo

La especificación mínima del Trigate puede resumirse así:

Un Trigate es una restricción reversible ternaria.
Opera sobre dominios.
Reduce por intersección.
No amplía durante operación normal.
Distingue apertura de contradicción.
Usa C para cambiar la dirección de resolución.
Usa E para expresar coherencia local.
Usa F para expresar evolución local.
Convierte la contradicción en solicitud de redundancia.