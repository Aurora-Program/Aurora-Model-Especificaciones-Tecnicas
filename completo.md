# Documento Completo

---

## 1-nodo.md

Especificación técnica: Nodo
1. Definición
Un Nodo es un dominio de restricción formado por un conjunto de posibles elementos pertenecientes al conjunto base:
{0, 1, 2}
Por tanto, cada nodo mantiene internamente un dominio, que puede contener entre 0 y 3 elementos.
Ejemplos válidos de dominio:
{}
{0}
{1}
{2}
{0, 1}
{0, 2}
{1, 2}
{0, 1, 2}

2. Propiedades del Nodo
2.1. Propiedad dominio
La propiedad dominio representa el conjunto actual de valores posibles del nodo.
dominio ⊆ {0, 1, 2}
El dominio puede tener:
0, 1, 2 o 3 elementos

2.2. Propiedad calculada E
La propiedad E representa el estado de determinación del nodo.
Se calcula en función del número de elementos del dominio:
Si |dominio| >= 2  → E = 0
Si |dominio| = 1   → E = 1
Si |dominio| = 0   → E = 0
Por tanto:
E = 1 únicamente cuando el dominio contiene un solo elemento.
E = 0 cuando el dominio está vacío o contiene más de un elemento.

2.3. Propiedad calculada V
La propiedad V representa el valor actual del nodo.
Se calcula a partir de E:
Si E = 1  → V = único elemento del dominio
Si E ≠ 1  → V = 2
Por tanto:
V toma el valor determinado del nodo cuando el dominio tiene un único elemento.
V toma el valor 2 cuando el nodo no está determinado.

3. Método evaluar
El nodo expone un método:
evaluar(restriccion)
Donde restriccion es un dominio restrictivo, es decir, un subconjunto de:
{0, 1, 2}
El método evaluar restringe el dominio actual del nodo mediante una operación de intersección entre:
dominio actual
restriccion
El nuevo dominio será:
dominio = dominio ∩ restriccion
Si no existe ningún elemento común, el dominio resultante será vacío:
dominio = {}

4. Evento de cambio de dominio
El nodo debe desencadenar un evento siempre que su dominio cambie.
El evento se dispara cuando:
dominio_anterior ≠ dominio_nuevo
No se dispara evento si la evaluación no modifica el dominio.

5. Relación con Hiperaristas
Los nodos son compartidos por las Hiperaristas, que operan sobre ellos como referencias o punteros.
Una Hiperarista no copia el nodo, sino que mantiene una referencia al mismo.
Las Hiperaristas se suscribiren a los eventos de cambio de dominio de los nodos que unen.
Cuando un nodo modifica su dominio, notifica a las Hiperaristas suscritas para que estas puedan reevaluar sus propias restricciones.

Resumen compacto
Nodo:
  dominio ⊆ {0, 1, 2}
Propiedad calculada E:
  E = 1 si |dominio| = 1
  E = 0 si |dominio| = 0 o |dominio| >= 2
Propiedad calculada V:
  V = único elemento del dominio si E = 1
  V = 2 si E ≠ 1
Método evaluar(restriccion):
  dominio_nuevo = dominio_actual ∩ restriccion
  si dominio_nuevo ≠ dominio_actual:
    actualizar dominio
    emitir evento de cambio
Hiperaristas:
  comparten nodos por referencia
  se suscriben a los eventos de cambio de dominio
  reaccionan cuando un nodo modifica su dominio






---

## 2-funcion-ordenadora.md

Función Ordenadora — Especificación compacta
1. Definición

Una Función Ordenadora es una hiperarista estructural orientable que relaciona:

N[0], N[1], N[2], OD, GC, C, E, F

donde:

N[0], N[1], N[2]

son las tres dimensiones de entrada.

OD

es el nodo ordenador.

GC

es el dominio de grupos de coordenadas posibles.

C

es el operador de control.

E

es el estado de coherencia local.

F

es la evolución local de coherencia.

La Función Ordenadora no calcula valores lógicos. Calcula interpretaciones estructurales posibles sobre tres nodos de entrada.

2. Dominio base

Todos los nodos operan sobre el dominio ternario:

T = {0,1,2}

Cada nodo mantiene un dominio:

D(N[i]) ⊆ {0,1,2}
D(OD)   ⊆ {0,1,2}
D(C)    ⊆ {0,1,2}

Cada valor del dominio representa un índice de entrada:

0 → N[0]
1 → N[1]
2 → N[2]
3. Grupo de coordenadas

Un grupo de coordenadas está formado por:

GC = (ES, FN, FO)

donde:

ES = nodo estructural principal
FN = nodo funcional asociado
FO = nodo restante

Debe distinguirse entre:

Resolución de orden:
(ES_index, FN_index, FO_index)

y:

Grupo materializado:
(
  ES = N[ES_index],
  FN = N[FN_index],
  FO = N[FO_index]
)

Ejemplo:

Resolución de orden:
(1,0,2)

significa:

ES = N[1]
FN = N[0]
FO = N[2]
4. Regla básica de ordenación

El dominio de OD determina qué índices pueden ocupar ES.

es ∈ D(OD)

Para cada es:

ES_index = es

Después se consulta el dominio del nodo elegido como ES:

D(N[ES_index])

Ese dominio determina los posibles índices de FN.

Antes de aceptar esos valores, se elimina la autorreferencia:

D_FN = D(N[ES_index]) - {ES_index}

Si:

D_FN = {}

la resolución se descarta como incoherente.

Para cada:

fn ∈ D_FN

se define:

FN_index = fn

y FO se calcula por exclusión:

FO_index = {0,1,2} - {ES_index,FN_index}

Cada combinación válida genera un grupo:

GC = (
  ES = N[ES_index],
  FN = N[FN_index],
  FO = N[FO_index]
)
5. Dominio de grupos de coordenadas

La salida natural de la Función Ordenadora es un dominio de grupos posibles:

D(GC) = {GC1, GC2, ..., GCn}

Puede haber varios grupos posibles por dos razones:

1. D(OD) contiene varios posibles ES.
2. D(N[ES_index]) contiene varios posibles FN.

Por tanto, incluso con un único ES, puede haber varios grupos si el nodo ES admite varios FN.

Ejemplo:

D(OD) = {1}
D(N[1]) = {0,2}

produce:

(ES=N[1], FN=N[0], FO=N[2])
(ES=N[1], FN=N[2], FO=N[0])
6. Operador de control C

El operador C determina qué parte de la relación debe concretarse.

C ∈ {0,1,2}
C	Modo	Objetivo
0	concretar ordenador	OD
1	concretar grupo de coordenadas	GC
2	concretar dimensiones de entrada	N[0], N[1], N[2]

La relación estructural siempre es la misma:

N[0], N[1], N[2], OD, GC

Lo que cambia es la dirección de concreción.

C = 0 → GC/contexto → OD
C = 1 → OD + N[0..2] → GC
C = 2 → OD/GC/contexto → N[0..2]

C no modifica la regla de ordenación. Solo determina qué dominio se intenta reducir.

7. C = 0 — Concretar OD

Cuando:

C = 0

la función intenta concretar el nodo ordenador OD.

Si existe un grupo seleccionado:

GC = (
  ES = N[es],
  FN = N[fn],
  FO = N[fo]
)

entonces:

D_compatible(OD) = {es}

y se aplica:

D(OD)' = D(OD) ∩ {es}
8. C = 1 — Concretar GC

Cuando:

C = 1

la función genera o reduce el dominio de grupos de coordenadas.

Operación:

OD + N[0..2] → D(GC)

Regla:

para cada es ∈ D(OD):

    D_FN = D(N[es]) - {es}

    para cada fn ∈ D_FN:

        fo = {0,1,2} - {es,fn}

        añadir:
        (
          ES = N[es],
          FN = N[fn],
          FO = N[fo]
        )
        a D(GC)
9. C = 2 — Concretar entradas

Cuando:

C = 2

la función intenta restringir los dominios de entrada.

Si existe un grupo seleccionado:

GC = (
  ES = N[es],
  FN = N[fn],
  FO = N[fo]
)

entonces debe cumplirse:

fn ∈ D(N[es])

Por tanto, la restricción principal es:

D(N[es])' = D(N[es]) ∩ {fn}

Los demás nodos no se restringen directamente por la regla mínima, salvo que otra restricción externa lo determine.

10. Estado E

E mide el estado de coherencia de la concreción activa.

E ∈ {0,1,2}
E	Nombre	Significado
0	ambiguo	existe más de una posibilidad
1	coherente	existe una única posibilidad
2	incoherente	no existe posibilidad compatible

C determina sobre qué dominio se calcula E.

C = 0 → E se calcula sobre D(OD)
C = 1 → E se calcula sobre D(GC)
C = 2 → E se calcula sobre los dominios de entrada afectados

Regla simple:

D_objetivo = {}      → E = 2
|D_objetivo| = 1     → E = 1
|D_objetivo| > 1     → E = 0

Para C = 2, como puede haber varios dominios afectados:

si algún dominio afectado queda vacío:
    E = 2

si todos los dominios afectados quedan unitarios:
    E = 1

si ninguno queda vacío pero alguno queda múltiple:
    E = 0
11. Métrica F

F mide la evolución local de E después de una operación dirigida por C.

F ∈ {0,1,2}
F	Nombre	Significado
0	neutro	mantiene la coherencia
1	corrector	mejora la coherencia
2	contraproducente	empeora la coherencia

F puede entenderse como una derivada discreta de E respecto a una operación orientada por C:

F ≈ ΔE / ΔC_operativo

No significa que C sea continuo. Significa que F mide si la operación realizada en la dirección indicada por C mejora, mantiene o empeora el estado de coherencia.

Orden de calidad de E:

E = 2 < E = 0 < E = 1

Tabla:

E anterior	E nuevo	F
2	1	1
2	0	1
0	1	1
1	1	0
0	0	0
2	2	0
1	0	2
1	2	2
0	2	2
12. Operación general

La Función Ordenadora reduce dominios por intersección. No asigna arbitrariamente.

D_objetivo' = D_objetivo ∩ D_compatible

El objetivo depende de C.

C = 0 → objetivo = OD
C = 1 → objetivo = GC
C = 2 → objetivo = N[0], N[1], N[2]
13. Pseudocódigo compacto
evaluarOrdenador(N[0], N[1], N[2], OD, GC, C):

    E_anterior = E

    si C = 0:

        D_OD_compatible = {}

        para cada gc en D(GC):
            es = indice(gc.ES)
            añadir es a D_OD_compatible

        D(OD)' = D(OD) ∩ D_OD_compatible

        E_nuevo = estado(D(OD)')

    si C = 1:

        D_GC_compatible = {}

        para cada es en D(OD):

            D_FN = D(N[es]) - {es}

            para cada fn en D_FN:

                FO_set = {0,1,2} - {es,fn}

                si |FO_set| = 1:

                    fo = único elemento de FO_set

                    añadir (
                        ES = N[es],
                        FN = N[fn],
                        FO = N[fo]
                    ) a D_GC_compatible

        D(GC)' = D(GC) ∩ D_GC_compatible

        E_nuevo = estado(D(GC)')

    si C = 2:

        para cada gc en D(GC):

            es = indice(gc.ES)
            fn = indice(gc.FN)

            registrar fn como compatible para N[es]

        para cada i afectado:

            D(N[i])' = D(N[i]) ∩ D_compatible(N[i])

        E_nuevo = estadoCompuesto(dominios_afectados)

    F = calcularF(E_anterior, E_nuevo)

    E = E_nuevo

    devolver dominios actualizados, E, F

Funciones auxiliares:

estado(D):

    si D = {}:
        devolver 2

    si |D| = 1:
        devolver 1

    si |D| > 1:
        devolver 0
estadoCompuesto(dominios):

    si algún dominio afectado está vacío:
        devolver 2

    si todos los dominios afectados son unitarios:
        devolver 1

    en otro caso:
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
14. Modelo de eventos

La Función Ordenadora se suscribe a:

N[0].changed
N[1].changed
N[2].changed
OD.changed
GC.changed
C.changed

Cuando recibe un evento, reevalúa la dirección activa indicada por C.

Debe emitir evento si:

D_objetivo_nuevo ≠ D_objetivo_anterior

o si:

E_nuevo ≠ E_anterior

o si:

F indica cambio relevante de evolución

Evento sugerido:

OrderEvent {
  C,
  objetivo,
  old_domain,
  new_domain,
  E_anterior,
  E_nuevo,
  F,
  source_id,
  clock
}
15. Invariantes
1. Todos los dominios operan sobre {0,1,2}.
2. OD determina los posibles ES.
3. El nodo elegido como ES determina los posibles FN.
4. La autorreferencia ES → ES se elimina siempre.
5. Si al eliminar la autorreferencia no queda FN posible, esa resolución es incoherente.
6. FO se determina siempre por exclusión.
7. Cada grupo válido usa los tres nodos una sola vez.
8. La función no elige arbitrariamente entre varios grupos posibles.
9. C determina la dirección de concreción.
10. E se calcula sobre el dominio objetivo determinado por C.
11. F mide la evolución de E tras operar en la dirección indicada por C.
12. La función reduce dominios; no los amplía durante operación normal.
16. Cierre normativo
Una Función Ordenadora es una hiperarista estructural orientable.

Relaciona tres nodos de entrada, un nodo ordenador y un dominio de grupos de coordenadas.

OD determina qué nodo puede actuar como ES.

El nodo que actúa como ES determina qué nodo puede actuar como FN.

FO queda determinado por exclusión.

C determina qué se intenta concretar:
OD, GC o las dimensiones de entrada.

E mide si esa concreción queda cerrada, ambigua o incoherente.

F mide si la operación mejora, mantiene o empeora la coherencia.

La Función Ordenadora no calcula valores:
genera y reduce interpretaciones estructurales posibles.

Frase final compacta:

C orienta la concreción, E mide su estado y F mide su evolución.
ecto.

---

## 3-Trigate.md


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




---

## 4-Destilador.md

# Destilador — Especificación técnica compacta
1. Definición

El Destilador es una función avanzada de composición estructural que recibe como entrada grupos de coordenadas generados por tres Funciones Ordenadoras y produce como salida un conjunto de Dimensiones Destiladas atraves de su razonamiento operado por pares de trigates.

Su objetivo es integrar tres interpretaciones estructurales distintas y obtener de ellas una representación condensada:

Destilador(coord[0], coord[1], coord[2]) → DD

donde:

coord[0], coord[1], coord[2]

son grupos de coordenadas procedentes de tres Funciones Ordenadoras.

Cada grupo de coordenadas contiene tres componentes:

coord[n].ES
coord[n].FN
coord[n].FO

donde:

ES es la dimensión estructural principal.
FN es la dimensión funcional asociada.
FO es la dimensión restante u opuesta.
n ∈ {0,1,2} indica el índice del grupo de coordenadas usado como entrada.

La salida del Destilador es:

DD = (DD.ES, DD.FN, DD.FO)

donde cada dimensión destilada conserva el mismo tipo estructural:

DD.ES
DD.FN
DD.FO
2. Entrada del Destilador

El Destilador recibe tres grupos de coordenadas:

coord[0]
coord[1]
coord[2]

Cada grupo tiene la forma:

coord[n] = (
  coord[n].ES,
  coord[n].FN,
  coord[n].FO
)

Por tanto, la entrada completa puede expresarse como:

coord[0] = (coord[0].ES, coord[0].FN, coord[0].FO)
coord[1] = (coord[1].ES, coord[1].FN, coord[1].FO)
coord[2] = (coord[2].ES, coord[2].FN, coord[2].FO)
3. Salida del Destilador

La salida del Destilador es un conjunto de Dimensiones Destiladas:

DD = (
  DD.ES,
  DD.FN,
  DD.FO
)

Cada dimensión puede entenderse como una destilación de las relaciones estructurales contenidas en los tres grupos de coordenadas de entrada.

La dimensión estructural principal se obtiene de forma directa:

DD.ES = (
  coord[0].ES,
  coord[1].ES,
  coord[2].ES
)

Es decir:

DD.ES[0] = coord[0].ES
DD.ES[1] = coord[1].ES
DD.ES[2] = coord[2].ES

Las dimensiones DD.FN y DD.FO se obtienen mediante un proceso de destilación basado en tres pares de Trigate.

4. Pares de Trigate

El Destilador contiene tres pares de Trigate:

TP[0]
TP[1]
TP[2]

Cada par está formado por dos Trigate:

TP[n].FN
TP[n].FO

donde:

TP[n].FN destila la relación funcional.
TP[n].FO destila la relación opuesta o restante.

Cada Trigate conserva la estructura habitual:

Trigate(A, B, M, R)

Por tanto, sus entradas se nombran como:

TP[n].FN.A
TP[n].FN.B
TP[n].FN.M
TP[n].FN.R

TP[n].FO.A
TP[n].FO.B
TP[n].FO.M
TP[n].FO.R
5. Regla general de destilación

Cada par de Trigate compara dos grupos de coordenadas consecutivos de forma circular:

TP[0] compara coord[0] con coord[1]
TP[1] compara coord[1] con coord[2]
TP[2] compara coord[2] con coord[0]

La estructura circular permite que las tres coordenadas participen simétricamente en la destilación.

6. Definición de TP[0]

TP[0] destila la relación entre coord[0] y coord[1].

6.1. Entradas FN
coord[0].FN ↔ TP[0].FN.A
coord[1].FN ↔ TP[0].FN.B
6.2. Entradas FO
coord[0].FO ↔ TP[0].FO.A
coord[1].FO ↔ TP[0].FO.B
6.3. Acoplamiento interno

El resultado del Trigate funcional determina el modo del Trigate opuesto:

TP[0].FN.R ↔ TP[0].FO.M
6.4. Salidas destiladas
TP[0].FN.M ↔ DD.FN[0]
TP[0].FO.R ↔ DD.FO[0]

Por tanto:

DD.FN[0] = TP[0].FN.M
DD.FO[0] = TP[0].FO.R
7. Definición de TP[1]

TP[1] destila la relación entre coord[1] y coord[2].

7.1. Entradas FN
coord[1].FN ↔ TP[1].FN.A
coord[2].FN ↔ TP[1].FN.B
7.2. Entradas FO
coord[1].FO ↔ TP[1].FO.A
coord[2].FO ↔ TP[1].FO.B
7.3. Acoplamiento interno
TP[1].FN.R ↔ TP[1].FO.M
7.4. Salidas destiladas
TP[1].FN.M ↔ DD.FN[1]
TP[1].FO.R ↔ DD.FO[1]

Por tanto:

DD.FN[1] = TP[1].FN.M
DD.FO[1] = TP[1].FO.R
8. Definición de TP[2]

TP[2] destila la relación entre coord[2] y coord[0].

8.1. Entradas FN
coord[2].FN ↔ TP[2].FN.A
coord[0].FN ↔ TP[2].FN.B
8.2. Entradas FO
coord[2].FO ↔ TP[2].FO.A
coord[0].FO ↔ TP[2].FO.B
8.3. Acoplamiento interno
TP[2].FN.R ↔ TP[2].FO.M
8.4. Salidas destiladas
TP[2].FN.M ↔ DD.FN[2]
TP[2].FO.R ↔ DD.FO[2]

Por tanto:

DD.FN[2] = TP[2].FN.M
DD.FO[2] = TP[2].FO.R
9. Resumen operacional

La operación completa del Destilador puede expresarse así:

DD.ES = (
  coord[0].ES,
  coord[1].ES,
  coord[2].ES
)
DD.FN = (
  TP[0].FN.M,
  TP[1].FN.M,
  TP[2].FN.M
)
DD.FO = (
  TP[0].FO.R,
  TP[1].FO.R,
  TP[2].FO.R
)

donde cada TP[n] opera sobre un par circular de coordenadas:

TP[0] = coord[0] ↔ coord[1]
TP[1] = coord[1] ↔ coord[2]
TP[2] = coord[2] ↔ coord[0]
10. Interpretación estructural

El Destilador no calcula simplemente una salida lógica.

Su función es condensar tres perspectivas estructurales en una nueva dimensión compuesta.

La Función Ordenadora produce grupos de coordenadas:

ES, FN, FO

El Destilador toma tres de esos grupos y construye una nueva dimensión destilada:

DD.ES, DD.FN, DD.FO

De este modo, el Destilador actúa como una capa superior de integración:

Funciones Ordenadoras → Grupos de Coordenadas → Destilador → Dimensiones Destiladas
11. Forma compacta final
Destilador(
  coord[0],
  coord[1],
  coord[2]
)
→
DD

donde:

coord[n] = (
  coord[n].ES,
  coord[n].FN,
  coord[n].FO
)

y:

DD = (
  DD.ES,
  DD.FN,
  DD.FO
)

con:

DD.ES[i] = coord[i].ES

y:

DD.FN[i] = TP[i].FN.M
DD.FO[i] = TP[i].FO.R

siendo:

TP[0] = coord[0] ↔ coord[1]
TP[1] = coord[1] ↔ coord[2]
TP[2] = coord[2] ↔ coord[0]
12. Nota de nomenclatura

Para mantener coherencia técnica, conviene escribir siempre:

DD.FO

y no:

DD.F0

porque FO significa Función Opuesta o dimensión opuesta/restante, mientras que F0 podría confundirse con un índice numérico.

También conviene normalizar:

coord

en minúscula para la variable, y reservar mayúsculas para tipos o estructuras:

coord[n].ES
coord[n].FN
coord[n].FO

DD.ES
DD.FN
DD.FO

TP[n].FN
TP[n].FO
13. Definición esencial

El Destilador es una función de integración que transforma tres grupos de coordenadas procedentes de Funciones Ordenadoras en una nueva dimensión destilada.

La parte ES se transfiere directamente.

Las partes FN y FO se obtienen mediante tres pares circulares de Trigate, donde cada par compara dos coordenadas y genera una salida destilada funcional y opuesta.

En forma mínima:

Destilador = integración circular de tres grupos de coordenadas mediante pares de Trigate.


Desde una perspectiva geometrica podriamos entender las coordenada de entrada como vectores puros, y el conjut diemsnion destiladas como una represenacion de un traingulo donde los nodos de la dimension destilada FO representaria sus lados
los nodos de sus dimension destilad FN: sus anguleos y los nodo de su dimension destialda  ES: su ordenacion. 



---

## 5-Funcion-Emergencia.md

# Función de Emergencia — Funcion de sintizacion.
# Función de Emergencia — Especificación técnica refactorizada

## 1. Definición

Una **Función de Emergencia** es una hiperarista de consolidación estructural que recibe una dimensión destilada y determina dos cosas inseparables:

1. **El espacio operativo** donde los vectores pueden ser interpretados.
2. **La desviación de cierre** respecto al triángulo equilátero ideal de ese espacio.

Forma general:

```text
FE_Rol(DD.Rol, S.Rol, C) → DS.Rol, E.Rol, F.Rol
```

donde:

```text
DD.Rol = dimensión destilada de entrada del rol activo
Rol    = ES, FN o FO
S.Rol  = selector de espacio / combinación vectorial
C      = operador de control
DS.Rol = sector o dimensión superior emergente del rol activo
E.Rol  = desviación local respecto al cierre equilátero
F.Rol  = evolución local de la desviación/coherencia
```

La función ya no debe entenderse como una función que simplemente elige un `SCE(DKC)`.

La salida principal es la pareja:

```text
DS.Rol + E.Rol
```

`DS.Rol` indica **en qué espacio operan los vectores**.

`E.Rol` indica **si esos vectores cierran o no cierran** dentro de ese espacio.

Forma compacta:

```text
DS define el espacio.
E mide la desviación respecto al cierre equilátero.
```

Si la desviación global es:

```text
E = 0-0-0
```

entonces los tres vectores han cerrado como triángulo equilátero operativo y la relación puede darse por comprendida en ese nivel.

Si no se alcanza:

```text
E ≠ 0-0-0
```

la relación sigue siendo incoherente, incompleta o abierta, y el sistema debe solicitar más dimensión, más contexto o una operación de nivel superior.

---

## 2. Dominio base

La función opera sobre el dominio ternario:

```text
T = {0,1,2}
```

Interpretación general:

| Valor | Sentido operativo |
|---|---|
| 0 | cierre / desviación nula / coincidencia local |
| 1 | desviación media / transición / cierre parcial |
| 2 | apertura superior / desviación máxima / no cierre |

Regla estructural:

```text
2 ≠ error
```

El valor `2` representa apertura, no cierre o falta de determinación.

La contradicción formal sigue siendo una propiedad del dominio:

```text
D = {} → contradicción
```

Por tanto, la Función de Emergencia distingue tres planos:

| Plano | Qué expresa |
|---|---|
| DS | espacio donde operan los vectores |
| E | desviación respecto al cierre equilátero |
| estado(D) | coherencia formal del dominio calculado |

---

## 3. Entrada DD

La entrada de la función es una dimensión destilada:

```text
DD = (X0, X1, X2)
```

Cada componente representa un vector local procedente del Destilador.

Para `FN` y `FO`, la dimensión puede normalizarse como multiconjunto:

```text
DDⁿ = ordenar(DD)
```

Ejemplo:

```text
DD = (2,0,1)
DDⁿ = (0,1,2)
```

Para `ES`, el orden puede tener significado estructural y no debe eliminarse automáticamente:

```text
FN / FO → DD como multiconjunto
ES      → DD posiblemente ordenada
```

---

## 4. Interpretación geométrica-operativa

La Función de Emergencia interpreta cada `DD.Rol` como una triada vectorial.

La triada puede estar:

1. **cerrada**, si forma un triángulo equilátero operativo en el espacio indicado por `DS.Rol`;
2. **parcialmente desviada**, si todavía conserva dirección estructural pero no cierra;
3. **abierta o incompleta**, si requiere más dimensión para poder cerrarse.

El cierre ideal se expresa como:

```text
E.Rol = 0
```

La Cara completa integra los tres roles:

```text
E = (E.ES, E.FN, E.FO)
```

El cierre completo de la Cara se alcanza cuando:

```text
E = (0,0,0)
```

Este vector representa el equivalente operativo del triángulo equilátero completo.

---

## 5. Selector S

`S` deja de interpretarse como el resultado importante de la emergencia.

`S` pasa a ser el **selector de combinación vectorial**.

```text
S ∈ {0,1,2}
```

| S | Nombre | Criterio |
|---|---|---|
| 0 | conservador | intenta cerrar por el extremo inferior |
| 1 | balanceado | intenta cerrar por equilibrio central |
| 2 | expansivo | intenta cerrar por apertura superior |

Forma compacta:

```text
S selecciona cómo se combinan los vectores.
E mide cuánto se desvían del cierre ideal.
```

Por tanto, `S` define la forma de probar el espacio, pero la decisión importante la da `E`.

---

## 6. Selector por rol

En una Cara completa, la Función de Emergencia se instancia tres veces:

```text
FE.ES(DD.ES, S.ES, C)
FE.FN(DD.FN, S.FN, C)
FE.FO(DD.FO, S.FO, C)
```

La forma completa de `S` es:

```text
S = (S.ES, S.FN, S.FO)
```

Se permite `S_global` cuando el mismo selector se aplica a los tres roles:

```text
S_global = s ⇔ S.ES = S.FN = S.FO = s
```

---

## 7. Dimensión superior DS

La salida espacial de cada función se denomina `DS.Rol`.

`DS.Rol` representa el sector o espacio superior donde la triada destilada puede operar.

Puede conservar internamente la estructura anterior `DKC` como representación técnica:

```text
DS.Rol = DKC = (K1, K2, K3)
```

con:

| Componente | Nombre | Función |
|---|---|---|
| K1 | sector principal | indica el espacio dominante |
| K2 | desarrollo | indica concentración, transición o apertura |
| K3 | orientación | indica orientación inferior, central o superior |

Pero normativamente la lectura pasa a ser:

```text
DKC no es el objetivo final.
DKC es la codificación interna de DS.Rol.
```

---

## 8. Desviación E

`E` mide la desviación respecto al cierre equilátero dentro del espacio `DS`.

```text
E.Rol ∈ {0,1,2}
```

| E.Rol | Significado geométrico-operativo |
|---|---|
| 0 | cierre local: la triada cierra en ese rol |
| 1 | desviación parcial: falta ajuste o contexto |
| 2 | no cierre fuerte: requiere más dimensión o revisión |

La Cara completa usa:

```text
E = (E.ES, E.FN, E.FO)
```

Interpretación superior:

| E global | Significado |
|---|---|
| 0-0-0 | triángulo cerrado; comprensión local suficiente |
| contiene 1 | cierre parcial; requiere ajuste o contexto adicional |
| contiene 2 | no cierre fuerte; requiere redundancia, recombinación o salto superior |

Frase normativa:

```text
E no es solo estado de dominio; en la Función de Emergencia refactorizada E es desviación de cierre.
```

Para mantener compatibilidad con el resto del sistema, puede derivarse un estado formal `CE`:

```text
si E = 0-0-0      → CE = 1
si algún E = 2    → CE = 2
en otro caso      → CE = 0
```

Donde `CE` conserva la semántica clásica:

```text
CE = 1 → coherente
CE = 0 → ambiguo
CE = 2 → contradictorio / no resoluble localmente
```

---

## 9. Operador de control C

`C` determina qué parte de la relación debe resolverse.

```text
C ∈ {0,1,2}
```

| C | Modo | Pregunta | Objetivo |
|---|---|---|---|
| 0 | aprendizaje | ¿qué selector S explica este cierre o desviación? | D(S) |
| 1 | emergencia | ¿qué DS y qué E emergen de esta DD con este S? | DS + E |
| 2 | reconstrucción | ¿qué DD serían compatibles con este DS y esta desviación? | D(DD) |

Forma compacta:

```text
C = 0 → DD + DS/E → D(S)
C = 1 → DD + S    → DS + E
C = 2 → S + DS/E  → D(DD)
```

`C` no cambia la relación estructural.

Solo cambia la dirección de resolución.

---

## 10. C = 1 — Modo emergencia

En modo emergencia, la función calcula:

```text
DDⁿ + S.Rol → DS.Rol, E.Rol
```

La tabla anterior puede seguir funcionando como tabla de sector `DS`, pero ahora `E` debe calcularse como desviación respecto al patrón de cierre ideal.

Tabla base para `FN` y `FO`:

| DDⁿ | K2 | K3 | S=0 → K1 | S=1 → K1 | S=2 → K1 |
|---|---:|---:|---|---|---|
| (0,0,0) | 0 | 0 | 0 | 0 | 0 |
| (0,0,1) | 0 | 0 | 0 | 0 | 1 |
| (0,0,2) | 1 | 0 | 0 | {0,1} | 1 |
| (0,1,1) | 1 | 1 | 0 | {0,1} | 1 |
| (0,1,2) | 1 | 1 | 0 | 1 | 2 |
| (0,2,2) | 2 | 2 | 1 | {1,2} | 2 |
| (1,1,1) | 0 | 1 | 1 | 1 | 1 |
| (1,1,2) | 1 | 1 | 1 | {1,2} | 2 |
| (1,2,2) | 1 | 2 | 1 | 2 | 2 |
| (2,2,2) | 2 | 2 | 2 | 2 | 2 |

Donde:

```text
DS.Rol = (K1,K2,K3)
```

Si `K1` es múltiple, el espacio queda abierto, pero no necesariamente contradictorio.

Ejemplo:

```text
DDⁿ = (0,0,2)
S = 1

K1 = {0,1}
K2 = 1
K3 = 0

DS = ({0,1},1,0)
```

En la versión anterior esto se interpretaba principalmente como sector abierto.

En la versión refactorizada se interpreta así:

```text
El espacio DS existe, pero el cierre no está completamente determinado.
La decisión depende de E, no solo de K1.
```

---



## 11.bis. Cálculo geométrico de E — desviación equilátera por curvatura
La sección 11 define E como desviación respecto al cierre, pero deja la
operación en "distancia ternaria discreta". Esta sección fija la mecánica exacta.
Toda ella ha sido verificada ejecutando el núcleo (Nodo, Trigate, Ordenadora,
Destilador, Emergencia con descenso fractal real).
11.bis.1. Los tres roles destilados como geometría
Las tres dimensiones destiladas no son simétricas: cada una aporta una parte
distinta del triángulo, tal como adelanta el Destilador.
textDD.ES → ordenación: qué vector ocupa qué papel
DD.FN → ángulos: y a la vez la curvatura del espacio
DD.FO → lados: la longitud de cada arista
DD.FN cumple un doble papel: además de aportar los ángulos del triángulo
obtenido, su valor define la curvatura del espacio en el que ese triángulo
debe cerrar.
textDD.FN = 0 → espacio cerrado/esférico    (los ángulos ideales suman menos)
DD.FN = 1 → espacio plano/euclídeo      (suma intermedia)
DD.FN = 2 → espacio abierto/hiperbólico (los ángulos ideales suman más)
11.bis.2. El equilátero de referencia depende de la zona
No existe un único triángulo equilátero ideal. Cada espacio tiene el suyo:
el equilátero ideal de una zona es el vector constante de su propio valor de
curvatura.
textequilátero_ideal(espacio k) = (k, k, k)

espacio 0 → equilátero ideal = 0-0-0
espacio 1 → equilátero ideal = 1-1-1
espacio 2 → equilátero ideal = 2-2-2
Un triángulo es equilátero cuando sus tres ángulos son iguales; el valor en el
que son iguales es precisamente el que marca la curvatura de la zona. Por eso
E = 0-0-0 no significa "ángulos nulos", sino "el triángulo obtenido coincide
con el equilátero de esta zona, sea cual sea".
11.bis.3. E como distancia Manhattan al equilátero de la zona
E es el error del triángulo obtenido respecto al equilátero ideal de su
espacio, medido componente a componente con distancia Manhattan —la misma
métrica que usa el coste transcendente (DM(V,I) = Σ|Vi−Ii|). Un sistema,
una métrica.
textE = | triángulo_obtenido − equilátero_ideal_de_la_zona |
con equilátero_ideal = (k,k,k),  k = DD.FN del espacio activo
E.componente = | obtenido.componente − k |
El cierre completo se da cuando no hay error en ningún eje:
textE = 0-0-0 → el triángulo obtenido ES el equilátero de su zona → cierre.
11.bis.4. El espacio se hereda, no se deriva
Punto crítico verificado en ejecución: la curvatura k NO la calcula la
triada a partir de sus propios valores. El espacio c.ds se hereda de la
Cara superior (coherente con la sección 2 de Cara.md: "c.ds actúa como espacio
superior de referencia"). La triada no elige su zona; la recibe, y su trabajo
es cerrar o no dentro de ella.
Consecuencia operativa importante: el mismo triángulo cierra o cruza según
el espacio heredado. La triada 2-1-0 es defecto inofensivo si hereda zona 2
(ideal 2-2-2), pero cruza irreparablemente si hereda zona 0 (ideal 0-0-0).
No hay propiedad intrínseca de "esta triada cruza": el cruce es una relación
entre la triada y el espacio que le tocó.
En la cima de la cascada hay un c.ds que no está determinado. Ahí arranca
como dominio abierto {0,1,2} (equivalente a 2-2-2, desconocido) y se
restringe por intersección con todas las aristas que lo tocan, como cualquier
nodo. La arista de conocimiento lo restringe en modo inferencia. No hay regla
externa que fije el espacio raíz: emerge de la intersección de restricciones.
11.bis.5. Dos modos de no cierre: defecto recuperable y cruce irrecuperable
La magnitud de E (Manhattan) dice cuánto se desvía, pero no basta por sí
sola para decidir qué hacer. La decisión depende del signo de la desviación
antes de tomar valor absoluto:
textdesviación_con_signo = triángulo_obtenido − equilátero_ideal
Defecto (recuperable). El triángulo se queda corto: los ángulos no llegan
a lo que el espacio exige. No cierra, pero no es imposible —está incompleto.
Falta dimensión.
textobtenido < ideal en los ejes desviados
→ no cierre por defecto → E ≠ 0-0-0 recuperable
→ emitir Carry(E) y solicitar más dimensión/contexto
Ejemplo (verificado): espacio 2 (ideal 2-2-2), ángulos 0,1,1.
textE = |0-2|,|1-2|,|1-2| = 2-1-1   signo: −2,−1,−1 (defecto) → Carry(2-1-1)
Exceso fuerte / cruce (irrecuperable). El triángulo se pasa del techo de
la curvatura: los lados se autointersecan, la figura no puede existir en esa
zona. No es incompletitud, es contradicción geométrica.
textobtenido excede el techo del espacio con claridad
→ cruce → relación imposible en esta curvatura
→ NO se emite carry; abandono. No es salvable con más contexto.
Ejemplo (verificado): herencia de zona 0 (ideal 0-0-0) sobre 2,1,0. El 2
da desviación +2 → exceso fuerte → cruce → la cima decide ABANDONAR, sin carry.
11.bis.6. La frontera defecto/cruce es ambigua por diseño, y se resuelve descendiendo
Entre el defecto claro y el cruce claro hay una franja ambigua, y esto es
deliberado, no un hueco de la especificación. Un exceso fuerte (p.ej. 2-2-1
en zona 0) cruza sin duda. Un exceso leve (p.ej. 1-1-2 en zona 1, ideal
1-1-1) no es decidible localmente: podría ser un triángulo válido
ligeramente abierto, o el principio de un cruce.
La resolución no es un umbral numérico. La ambigüedad se empuja hacia
abajo: el eje ambiguo desciende a su subfractal —la Semilla Operativa
inferior cuya DS es ese eje (encaje fractal de Pipeline.md:
SO.superior.N[i] = SO.inferior[i].DS)— y se reevalúa allí, con la curvatura
del subnivel. Como el subfractal aporta estructura real y distinta (no una
copia del problema), a suficiente resolución la ambigüedad se rompe.
texteje ambiguo:
   si hay subfractal → DESCENDER y reevaluar en la zona del subnivel
        si el subfractal CRUZA          → el eje superior CRUZA (irrecuperable)
        si deja de ser ambiguo          → el eje superior es VÁLIDO (cierra)
        si sigue ambiguo                → descender otro nivel
11.bis.7. Condiciones de parada del descenso
El descenso para cuando ocurre lo primero de:
text(1) deja de ser ambiguo      → la subtriada cierra o cruza claramente.
                               veredicto heredado por GEOMETRÍA.
(2) se concreta en lo conocido → la subtriada cierra (E=0-0-0) contra un
                               tensor ya cristalizado del diccionario.
                               veredicto heredado por MEMORIA (atajo).
"Concretarse en lo conocido" no usa umbral de parecido: un tensor conocido
resuelve el descenso si hace cerrar la subtriada (E = 0-0-0 contra él), no
si se le parece. La coherencia sigue siendo el único criterio.
Implicación de eficiencia (verificada): con diccionario rico, el descenso choca
con conocimiento pronto y para arriba — barato. Con diccionario vacío (bootstrap)
el descenso llega hasta las hojas (tokens simples sin más fractal) y fuerza el
cierre. Por eso el bootstrap es caro y el sistema maduro es rápido: el coste de
resolución cae a medida que el diccionario aprende. El conocimiento consolidado
ahorra profundidad de descenso.
Cuando el descenso se agota sin romper la ambigüedad (hoja, sin más fractal), el
sistema no se bloquea ni abandona: encaja la solución hacia el tensor
conocido más coherente. El diccionario desempata. Es un sesgo conservador
—mantiene el statu quo y da estabilidad— pero no por frecuencia: el cierre
forzado se registra contra el tensor del que dependió, y queda sujeto a la misma
revalidación que todo lo demás.
11.bis.8. Conexión con la contradicción del Trigate
Esta distinción es la versión geométrica de la distinción fundamental del
Trigate entre apertura y contradicción:
textTrigate (CSP):       D = {2}  apertura, recuperable, E = 0
                     D = {}   contradicción formal, E = 2

Emergencia (geom.):  defecto  apertura geométrica, recuperable → Carry
                     cruce    contradicción geométrica, irrecuperable → abandono
El cruce es el D = {} de la geometría: no falta información, es que ninguna
información puede arreglarlo. Por tanto, E puede contener un 2 con semántica
de contradicción dura cuando proviene de cruce, no de defecto:
textE.componente = 2 por defecto → desviación fuerte recuperable (Carry)
E.componente = 2 por cruce   → contradicción geométrica (sin carry)
Estado formal derivado CE:
textsi E = 0-0-0                      → CE = 1  (cierre)
si E ≠ 0-0-0 solo por defecto     → CE = 0  (ambiguo, recuperable, Carry)
si algún eje cruza (exceso fatal) → CE = 2  (contradicción, abandono)
11.bis.9. Lados: forma y tamaño
DD.FO aporta los lados, con doble lectura.
Forma (cualitativa, independiente del cierre):
textaaa → equilátero    aab → isósceles    abc → escaleno
Tamaño (suma de lados): comportamiento análogo a la suma de ángulos. El espacio
impone un techo también a la longitud total; los lados deben reconectar la
figura dentro de la zona. Lados que se pasan del techo → cruce; que se quedan
cortos → defecto recuperable.
La emergencia es por tanto una doble comprobación: ángulos (DD.FN)
realizables en la curvatura y lados (DD.FO) que reconecten. Ambas deben
pasar para E = 0-0-0. Cualquier cruce —en ángulos o en lados— es abandono.
11.bis.10. Forma compacta
textk = DD.FN heredado                 (curvatura del espacio, NO derivada de la triada)
ideal = (k,k,k)                    (equilátero de la zona)

E = |obtenido − ideal|             (Manhattan, por eje)

signo(obtenido − ideal):
   negativo (defecto)      → recuperable → Carry(E)
   exceso fuerte (cruce)   → irrecuperable → abandono
   exceso leve (ambiguo)   → DESCENDER al subfractal:
                                rompe por geometría, o por atajo al diccionario,
                                o encaje conservador si se agota el fractal

E = 0-0-0 → cierre; consolidar DS y ascender de nivel.
Frase compacta:
textDD.FN define la curvatura; el equilátero de la zona es (k,k,k).
E es la distancia Manhattan a ese equilátero.
El signo separa defecto (carry) de cruce (abandono).
La franja ambigua entre ambos no se decide por umbral: se desciende al fractal
hasta que la estructura inferior la rompe o el diccionario la concreta

## 12. C = 0 — Modo aprendizaje

En modo aprendizaje, la función intenta inferir qué selector `S` explica una emergencia observada.

```text
DD + DS/E → D(S)
```

La tabla inversa de `K1` puede conservarse como base, pero ahora la selección debe validar también la desviación `E`.

Regla:

```text
Un selector S es compatible si produce un DS compatible y una E compatible.
```

Forma compacta:

```text
D(S)' = D(S) ∩ S_compatibles(DD, DS_observado, E_observado)
```

Estado formal derivado:

```text
D(S)' = {}      → CE = 2
|D(S)'| = 1     → CE = 1
|D(S)'| > 1     → CE = 0
```

---

## 13. C = 2 — Modo reconstrucción

En modo reconstrucción, la función intenta determinar qué dimensiones destiladas serían compatibles con un selector, un espacio y una desviación observada.

```text
S + DS/E → D(DD)
```

Regla:

```text
Una DD es compatible si, al operar con S, produce un DS compatible y una E compatible.
```

Forma compacta:

```text
D(DD)' = D(DD) ∩ DD_compatibles(S, DS_observado, E_observado)
```

Estado formal derivado:

```text
D(DD)' = {}      → CE = 2
|D(DD)'| = 1     → CE = 1
|D(DD)'| > 1     → CE = 0
```

---

## 14. Métrica F

`F` mide la evolución local tras una operación.

En esta refactorización, `F` puede leerse como evolución de la desviación:

```text
F ≈ ΔE / ΔC_operativo
```

```text
F ∈ {0,1,2}
```

| F | Nombre | Significado |
|---|---|---|
| 0 | neutro | mantiene la desviación/coherencia |
| 1 | corrector | reduce la desviación y acerca al cierre |
| 2 | contraproducente | aumenta la desviación o rompe el cierre |

Orden de calidad para la desviación:

```text
E = 2 < E = 1 < E = 0
```

Tabla:

| E anterior | E nuevo | F |
|---:|---:|---:|
| 2 | 0 | 1 |
| 2 | 1 | 1 |
| 1 | 0 | 1 |
| 0 | 0 | 0 |
| 1 | 1 | 0 |
| 2 | 2 | 0 |
| 0 | 1 | 2 |
| 0 | 2 | 2 |
| 1 | 2 | 2 |

---

## 15. Operación general

La Función de Emergencia no elige arbitrariamente entre cierres posibles.

Reduce dominios, conserva ambigüedad y solicita más estructura cuando no puede cerrar.

Reglas:

```text
La función no fuerza E = 0.
La función conserva E ≠ 0 como información operativa.
La función usa E ≠ 0 para solicitar más dimensión o salto superior.
```

Si:

```text
E = 0-0-0
```

entonces:

```text
la Cara puede dar por comprendida el área local
y pasar al análisis de espacios superiores.
```

Si:

```text
E ≠ 0-0-0
```

entonces:

```text
la Cara no debe cerrar prematuramente.
debe emitir carry con el vector E
y solicitar nuevas dimensiones del mismo ciclo o cluster.
```

---

## 16. Relación con ventana operativa

La ventana operativa trabaja con tres vectores.

Debe intentar que la emergencia produzca:

```text
E = 0-0-0
```

Si no lo consigue, el sistema debe generar un `carry`:

```text
Carry = E
```

y añadir nuevas dimensiones o vectores del mismo cluster/ciclo para intentar una nueva emergencia.

Forma mínima:

```text
si E ≠ 0-0-0:
    emitir Carry(E)
    ampliar ventana con nuevos vectores del cluster
    reevaluar emergencia
```

Si sí lo consigue:

```text
si E = 0-0-0:
    consolidar DS
    DS emerge como dimensión superior del siguiente ciclo
```

Este comportamiento conecta la Función de Emergencia con el Pipeline asíncrono.

---

## 17. Pseudocódigo compacto

```text
evaluarEmergencia(DD, Rol, S_Rol, C, DS_observado=None, E_observado=None):

    E_anterior = E.Rol

    si Rol ∈ {FN, FO}:
        DDn = ordenar(DD)

    si Rol = ES:
        DDn = normalizarES(DD)
        # puede conservar orden estructural

    si C = 0:
        # aprendizaje
        D_S_compatible = buscarSelectoresCompatibles(
            DDn,
            DS_observado,
            E_observado
        )
        D(S)' = D(S) ∩ D_S_compatible
        CE = estado(D(S)')
        E_nuevo = E_observado

    si C = 1:
        # emergencia
        K1 = tablaSelector(DDn, S_Rol)
        K2 = tablaDesarrollo(DDn)
        K3 = tablaOrientacion(DDn)

        DS = (K1,K2,K3)
        E_nuevo = calcularDesviacionEquilatera(DDn, DS, S_Rol)
        CE = estadoCierre(E_nuevo)

    si C = 2:
        # reconstrucción
        D_DD_compatible = buscarDDCompatibles(
            S_Rol,
            DS_observado,
            E_observado
        )
        D(DD)' = D(DD) ∩ D_DD_compatible
        CE = estado(D(DD)')
        E_nuevo = E_observado

    F = calcularF(E_anterior, E_nuevo)

    si E_nuevo != 0:
        emitir Carry(E_nuevo)

    devolver dominios actualizados, DS, E_nuevo, CE, F
```

Funciones auxiliares:

```text
estado(D):

    si D = {}:
        devolver 2

    si |D| = 1:
        devolver 1

    si |D| > 1:
        devolver 0
```

```text
estadoCierre(E):

    si E = 0:
        devolver 1

    si E = 1:
        devolver 0

    si E = 2:
        devolver 2
```

```text
calcularF(E_anterior, E_nuevo):

    calidad(2) = 0
    calidad(1) = 1
    calidad(0) = 2

    si calidad(E_nuevo) > calidad(E_anterior):
        devolver 1

    si calidad(E_nuevo) = calidad(E_anterior):
        devolver 0

    si calidad(E_nuevo) < calidad(E_anterior):
        devolver 2
```

---

## 18. Modelo de eventos

La Función de Emergencia se suscribe a:

```text
DD.changed
S.changed
C.changed
DS_observado.changed
E_observado.changed
Rol.changed
```

Debe emitir evento si:

```text
DS_nuevo ≠ DS_anterior
```

or:

```text
E_nuevo ≠ E_anterior
```

or:

```text
F indica cambio relevante de evolución
```

Evento sugerido:

```text
EmergenceEvent {
  rol,
  C,
  S_Rol,
  DD,
  DS_anterior,
  DS_nuevo,
  E_anterior,
  E_nuevo,
  CE,
  F,
  carry,
  source_id,
  clock
}
```

Evento de carry:

```text
CarryEvent {
  rol,
  E,
  DS,
  cluster_id,
  cycle_id,
  solicitud,
  source_id,
  clock
}
```

Donde:

```text
solicitud = más dimensión | recombinación | salto superior
```

---

## 19. Invariantes

1. Toda `DD` opera sobre valores de `{0,1,2}`.
2. `S` siempre pertenece a `{0,1,2}`.
3. `C` siempre pertenece a `{0,1,2}`.
4. `C` determina la dirección de resolución.
5. `C` no modifica la relación estructural; solo cambia el objetivo.
6. `S` selecciona la combinación vectorial o modo de cierre.
7. `DS` define el espacio donde operan los vectores.
8. `DKC` puede conservarse como codificación interna de `DS`.
9. `E` mide la desviación respecto al triángulo equilátero operativo.
10. `E = 0` significa cierre local.
11. `E = 0-0-0` significa cierre completo de la Cara.
12. `E ≠ 0-0-0` exige más contexto, más dimensión, recombinación o salto superior.
13. `F` mide si la operación reduce, mantiene o aumenta la desviación.
14. La función reduce dominios; no los amplía durante operación normal.
15. Un conjunto múltiple no es error; es ambigüedad estructural.
16. Un conjunto vacío sí indica contradicción formal.
17. El valor `2` no significa error por sí mismo.
18. Para `FN` y `FO`, `DD` se puede normalizar como multiconjunto.
19. Para `ES`, el orden puede conservar significado estructural.
20. La función no elige arbitrariamente entre cierres compatibles.
21. Si no hay cierre, debe emitir `Carry(E)`.
22. Si hay cierre, `DS` se consolida como dimensión superior para el siguiente ciclo.

---

## 20. Cierre normativo

La Función de Emergencia refactorizada no debe entenderse como una simple tabla que transforma `DD + S` en un sector.

Debe entenderse como una función geométrico-operativa que determina:

```text
1. el espacio donde los vectores operan;
2. la desviación de esos vectores respecto al cierre equilátero.
```

Forma final:

```text
FE_Rol(DD.Rol, S.Rol, C) → DS.Rol, E.Rol, F.Rol
```

Forma completa de Cara:

```text
FE.ES → DS.ES, E.ES, F.ES
FE.FN → DS.FN, E.FN, F.FN
FE.FO → DS.FO, E.FO, F.FO

DS = síntesis(DS.ES, DS.FN, DS.FO)
E  = (E.ES, E.FN, E.FO)
```

Regla decisiva:

```text
si E = 0-0-0:
    consolidar DS y pasar al ciclo superior

si E ≠ 0-0-0:
    emitir carry con E y solicitar más dimensión
```

Frase compacta:

```text
S selecciona la combinación.
DS define el espacio.
E mide la desviación del cierre.
F mide la evolución.
C orienta la resolución.
```


---

## 6-Cara.md

Cara — Especificación técnica compacta refactorizada

1. Definición

La Cara se representa normativamente como una estructura operativa c.

Una Cara c es la superficie relacional que transforma una Semilla Operativa de entrada en conocimiento reconstructivo de esa entrada.

No debe entenderse como una dimensión adicional, sino como el conjunto de relaciones que permite:

1. ordenar los vectores de entrada;
2. generar coordenadas estructurales de la cara;
3. destilar dichas coordenadas;
4. comparar las dimensiones destiladas con la dimensión superior original;
5. calcular la desviación E respecto al cierre equilátero;
6. producir conocimiento reconstructivo formado por c.ov, c.ds y c.e.

Forma compacta:

c.coord[0..2] + c.ds
→ Ordenación
→ c.coord[i].ES/FN/FO + c.ov
→ Destilador
→ c.dd.ES, c.dd.FN, c.dd.FO
→ Emergencia geométrica
→ c.e
→ Conocimiento(c.ov, c.ds, c.e)

2. Entrada de la Cara

La entrada primaria de la Cara es una Semilla Operativa expresada dentro de c:

c = (
  c.coord[0],
  c.coord[1],
  c.coord[2],
  c.ds
)

Donde:

Elemento	Significado
c.coord[0]	primer vector/dimensión de entrada
c.coord[1]	segundo vector/dimensión de entrada
c.coord[2]	tercer vector/dimensión de entrada
c.ds	dimensión superior original de la semilla

La dimensión c.ds no se recalcula al inicio de la Cara.

c.ds actúa como espacio superior de referencia: define el espacio en el que los vectores de entrada deben intentar cerrar como triángulo equilátero.

3. Ordenación de la Cara

La primera transformación de la Cara consiste en ordenar las tres coordenadas de entrada.

Para ello se aplican las Funciones Ordenadoras sobre:

c.coord[0]
c.coord[1]
c.coord[2]

El resultado de la ordenación es doble:

1. cada coordenada queda descompuesta en sus roles internos;
2. aparece la dimensión ordenadora de la cara c.ov.

Forma:

Ordenación(c.coord[0], c.coord[1], c.coord[2])
→
(
  c.coord[0].ES, c.coord[0].FN, c.coord[0].FO,
  c.coord[1].ES, c.coord[1].FN, c.coord[1].FO,
  c.coord[2].ES, c.coord[2].FN, c.coord[2].FO,
  c.ov
)

Donde:

Campo	Significado
ES	dimensión estructural principal de la coordenada
FN	dimensión funcional asociada
FO	dimensión restante, opuesta o de cierre
c.ov	orden vectorial de las tres coordenadas de la Cara

c.ov representa cómo deben leerse, reconstruirse y aplicar sus relaciones los tres vectores dentro del espacio c.ds.

Nota de nomenclatura:

En documentos anteriores se usó OD para nodo ordenador. En esta especificación de Cara se adopta c.ov como nombre local porque representa el vector ordenador completo de la Cara. Si se necesita compatibilidad con documentos previos:

c.ov ≡ c.od

pero la forma recomendada dentro de Cara es c.ov.

4. Coordenadas ordenadas

Después de la ordenación, cada coordenada tiene la forma:

c.coord[i] = (
  c.coord[i].ES,
  c.coord[i].FN,
  c.coord[i].FO
)

para:

i ∈ {0,1,2}

Interpretación:

c.coord[i].ES indica qué parte de la coordenada actúa como estructura principal.
c.coord[i].FN indica qué parte actúa como función asociada.
c.coord[i].FO indica qué parte queda como opuesta, restante o cierre.

Las tres coordenadas ordenadas forman la geometría base de la Cara.

5. Destilación

Las coordenadas ordenadas pasan al Destilador:

Destilador(
  c.coord[0],
  c.coord[1],
  c.coord[2]
)
→
c.dd

La salida del Destilador es:

c.dd = (
  c.dd.ES,
  c.dd.FN,
  c.dd.FO
)

Donde:

Dimensión destilada	Origen
c.dd.ES	destilación estructural de las tres coordenadas ES
c.dd.FN	destilación funcional mediante pares circulares de Trigate
c.dd.FO	destilación opuesta/restante mediante pares circulares de Trigate

La Cara conserva también la dimensión superior original:

c.ds

Por tanto, después del Destilador la Cara dispone de cuatro elementos principales:

(
  c.dd.ES,
  c.dd.FN,
  c.dd.FO,
  c.ds
)

6. Emergencia geométrica de la Cara

La Función de Emergencia ya no debe entenderse como una simple producción de sector SCE.

En la Cara refactorizada, las dimensiones destiladas y c.ds se operan para calcular la desviación E de los vectores respecto al cierre equilátero dentro de ese espacio.

Forma:

EmergenciaCara(
  c.dd.ES,
  c.dd.FN,
  c.dd.FO,
  c.ds
)
→
c.e

c.e mide cuánto se desvían los tres vectores destilados del triángulo equilátero posible en el espacio definido por c.ds.

Interpretación:

c.ds define el espacio operativo.
c.dd.ES, c.dd.FN y c.dd.FO definen los tres vectores destilados dentro de ese espacio.
c.e mide la desviación de esos vectores respecto al cierre equilátero.

7. Significado de c.e

c.e es una dimensión vectorial de desviación.

Forma normativa:

c.e = (
  c.e.ES,
  c.e.FN,
  c.e.FO
)

Cada componente indica la desviación local de un rol respecto al cierre esperado.

Estado principal:

c.e = 0-0-0
→ los vectores cierran como triángulo equilátero dentro de c.ds.

c.e ≠ 0-0-0
→ los vectores todavía no cierran; la Cara conserva conocimiento parcial y solicita más dimensión, contexto o ciclo operativo.

Por tanto:

Resultado	Lectura operativa
c.e = 0-0-0	cierre coherente; el área queda comprendida
c.e ≠ 0-0-0	desviación; los vectores son todavía incoherentes o incompletos

8. Relación entre c.ds y c.e

La Cara siempre debe decir dos cosas:

1. cuál es el espacio de operación;
2. cuál es la desviación de los vectores en ese espacio.

Forma:

c.ds → espacio
c.e  → desviación respecto al cierre equilátero

Si c.e no cierra, el sistema interpreta:

"El espacio es c.ds, pero los vectores todavía no son coherentes dentro de ese espacio. Se necesita más dimensión para completar el cierre."

Si c.e cierra, el sistema interpreta:

"Los vectores son coherentes dentro de c.ds. El área queda comprendida y el sistema puede saltar a espacios superiores."

9. Conocimiento de la Cara

El conocimiento producido por una Cara no es solo c.ds.

El conocimiento reconstructivo mínimo de la Cara es:

K(c) = (
  c.ov,
  c.ds,
  c.e
)

Donde:

Elemento	Función
c.ov	forma de ordenar/reconstruir los vectores
c.ds	espacio superior en el que operan los vectores
c.e	desviación respecto al cierre equilátero

Este conocimiento permite reconstruir cómo estaban organizados los vectores dentro del espacio.

Dicho de otra forma:

c.ov + c.ds + c.e
=
forma de reconstruir vectores dentro del espacio

10. Cierre de la Cara

La Cara puede quedar en dos estados operativos principales.

10.1. Cara cerrada

Condición:

c.e = 0-0-0

Efecto:

La Cara considera que los vectores han cerrado dentro del espacio c.ds.

Entonces:

1. el área queda comprendida;
2. se consolida el conocimiento K(c);
3. el sistema puede operar sobre espacios superiores;
4. K(c) puede actuar como entrada de una nueva Semilla Operativa.

10.2. Cara abierta

Condición:

c.e ≠ 0-0-0

Efecto:

La Cara considera que los vectores todavía no han cerrado.

Entonces:

1. conserva c.ov, c.ds y c.e como conocimiento parcial;
2. solicita más dimensión, redundancia o contexto;
3. puede emitir un carry con c.e;
4. puede iniciar una nueva operación añadiendo vectores del mismo ciclo o del cluster activo.

Forma:

Carry(c.e)
→ solicitar más dimensión
→ reintentar cierre en el mismo espacio o en un espacio ajustado

11. Uso del conocimiento como nueva Semilla Operativa

El conocimiento generado por una Cara puede alimentar una nueva Semilla Operativa.

Si una Cara c1 produce:

K(c1) = (
  c1.ov,
  c1.ds,
  c1.e
)

entonces ese conocimiento puede transformarse en entrada de una nueva Cara c2:

c2.coord[0] = c1.ov
c2.coord[1] = c1.ds
c2.coord[2] = c1.e

La nueva semilla queda:

c2 = (
  c2.coord[0],
  c2.coord[1],
  c2.coord[2],
  c2.ds
)

O de forma compacta:

(
  c1.ov,
  c1.ds,
  c1.e
)
→
(
  c2.coord[0],
  c2.coord[1],
  c2.coord[2]
)
→
c2.ds

La dimensión c2.ds será la nueva dimensión superior emergente de esa operación.

12. Encadenamiento de caras

El sistema puede encadenar caras:

c0 → K(c0)
K(c0) → c1
c1 → K(c1)
K(c1) → c2
...

Forma general:

K(cn) = (cn.ov, cn.ds, cn.e)
K(cn) → c(n+1).coord[0..2]
c(n+1) → c(n+1).ds

Este encadenamiento permite que el sistema pase desde el análisis de vectores en un espacio hacia el análisis de espacios superiores.

13. Flujo operacional completo

Entrada:

c = (
  c.coord[0],
  c.coord[1],
  c.coord[2],
  c.ds
)

Ordenación:

FO[0..2](c.coord[0], c.coord[1], c.coord[2])
→
c.coord[i].ES/FN/FO
+
c.ov

Destilación:

Destilador(c.coord[0], c.coord[1], c.coord[2])
→
c.dd = (
  c.dd.ES,
  c.dd.FN,
  c.dd.FO
)

Emergencia:

EmergenciaCara(c.dd.ES, c.dd.FN, c.dd.FO, c.ds)
→
c.e

Conocimiento:

K(c) = (
  c.ov,
  c.ds,
  c.e
)

Cierre:

si c.e = 0-0-0:
    consolidar K(c)
    saltar a análisis de espacio superior

si c.e ≠ 0-0-0:
    emitir Carry(c.e)
    solicitar más dimensión/contexto
    reintentar cierre

14. Modelo de eventos

La Cara opera de forma asíncrona y dirigida por eventos.

Eventos de entrada:

c.coord[0].changed
c.coord[1].changed
c.coord[2].changed
c.ds.changed

Eventos de ordenación:

c.coord.ordered
c.ov.changed

Eventos de destilación:

c.dd.ES.changed
c.dd.FN.changed
c.dd.FO.changed

Eventos de emergencia:

c.e.changed
c.closed
c.open
c.carry

Eventos de conocimiento:

K.created
K.consolidated
K.reconstructive

Regla:

La Cara no necesita esperar a una ejecución central completa. Cada cambio puede activar una reevaluación local.

15. Pseudocódigo compacto

evaluarCara(c):

    leer c.coord[0], c.coord[1], c.coord[2], c.ds

    # 1. Ordenación
    para cada función ordenadora FO[i]:
        ordenar coordenadas

    actualizar c.coord[i].ES/FN/FO
    actualizar c.ov

    # 2. Destilación
    c.dd = Destilador(
        c.coord[0],
        c.coord[1],
        c.coord[2]
    )

    # 3. Emergencia geométrica
    c.e = calcularDesviacionEquilatera(
        c.dd.ES,
        c.dd.FN,
        c.dd.FO,
        c.ds
    )

    # 4. Conocimiento reconstructivo
    K = (c.ov, c.ds, c.e)

    si c.e == (0,0,0):
        emitir c.closed
        consolidar K
        permitir salto a espacio superior

    si c.e != (0,0,0):
        emitir c.open
        emitir Carry(c.e)
        solicitar más dimensión o contexto

    devolver K

16. Invariantes

1. La Cara se representa como c.
2. La entrada mínima de c es c.coord[0], c.coord[1], c.coord[2] y c.ds.
3. c.ds es la dimensión superior original y define el espacio operativo de la Cara.
4. La ordenación transforma cada c.coord[i] en c.coord[i].ES, c.coord[i].FN y c.coord[i].FO.
5. La ordenación produce c.ov como vector ordenador de la Cara.
6. c.ov describe cómo reconstruir/aplicar los vectores dentro del espacio.
7. El Destilador produce c.dd.ES, c.dd.FN y c.dd.FO.
8. c.dd.ES, c.dd.FN, c.dd.FO y c.ds alimentan la emergencia geométrica.
9. c.e mide la desviación respecto al triángulo equilátero en el espacio c.ds.
10. c.e = 0-0-0 indica cierre coherente.
11. c.e ≠ 0-0-0 indica que falta dimensión, contexto o redundancia.
12. La Cara siempre debe conservar espacio y desviación: c.ds + c.e.
13. El conocimiento reconstructivo mínimo es K(c) = (c.ov, c.ds, c.e).
14. K(c) puede alimentar una nueva Semilla Operativa.
15. c1.ov, c1.ds y c1.e pueden convertirse en c2.coord[0], c2.coord[1] y c2.coord[2].
16. c2.ds es la dimensión superior emergente de la nueva Cara.
17. La Cara no asigna arbitrariamente; ordena, destila, mide desviación y consolida si hay cierre.
18. Si no hay cierre, la Cara emite Carry(c.e).
19. La operación de la Cara es asíncrona y dirigida por eventos.
20. La Cara permite pasar del análisis de vectores en un espacio al análisis de espacios superiores.

17. Cierre normativo

La Cara es la operación que convierte una Semilla Operativa en conocimiento reconstructivo.

Primero ordena las tres coordenadas de entrada y produce c.ov.

Después destila las coordenadas ordenadas en c.dd.ES, c.dd.FN y c.dd.FO.

Luego compara esas dimensiones destiladas con el espacio c.ds y calcula c.e como desviación respecto al cierre equilátero.

Si c.e = 0-0-0, los vectores cierran, el área queda comprendida y el sistema puede saltar a espacios superiores.

Si c.e ≠ 0-0-0, los vectores todavía no cierran y el sistema debe solicitar más dimensión, redundancia o contexto.

Forma final:

c.coord[0..2] + c.ds
→ c.ov + c.dd
→ c.e
→ K(c) = (c.ov, c.ds, c.e)

Frase compacta:

c.ds define el espacio.
c.ov define cómo reconstruir los vectores.
c.e mide cuánto falta para que cierren.
Cuando c.e = 0-0-0, la Cara comprende el área y permite ascender a un espacio superior.


---

## 7-Transcender2.md

# Aurora — Los cuatro niveles operativos y la decisión transcendente c7

## 0. Propósito de este documento

Aurora puede parecer, en una primera lectura, un sistema con piezas de naturaleza
muy distinta: tablas booleanas, restricciones de dominio, triángulos equiláteros,
clusters que compiten. Esa heterogeneidad no es incoherencia: es **cambio de nivel
descriptivo**. La misma realidad operativa se lee de cuatro maneras según la escala
a la que se observe.

Este documento hace dos cosas:

1. Explica que Aurora es **una puerta lógica a nivel de Trigate, un grafo de
   restricciones (CSP) a nivel de Cara, un sistema geométrico-topológico a nivel de
   Transcender, y una red neuronal a nivel de ventana y cluster.**
2. Especifica el órgano que une todo eso y decide cómo continúa el sistema: la
   séptima Cara, **c7**.

La idea central que recorre todo: *no hay cuatro sistemas, hay un único sustrato
visto a cuatro resoluciones*. Lo combinatorio de abajo se congela en geometría
arriba, y la geometría arriba se comporta como una red cuando hay muchas unidades
en paralelo.

---

## 1. Cuatro niveles, un solo sustrato

| Nivel | Unidad | Naturaleza | Qué significa `E` aquí |
|---|---|---|---|
| 1 | Trigate | Puerta lógica reversible | estado de un dominio |
| 2 | Cara | Grafo de restricciones (CSP) | coherencia de varios dominios |
| 3 | Transcender | Sistema geométrico / topológico | desviación respecto al cierre equilátero |
| 4 | Ventana / Cluster | Red neuronal | activación que se propaga y compite |

La frase que resume el documento entero:

```text
Trigate     → opera como una puerta lógica.
Cara        → opera como un grafo de restricciones.
Transcender → opera como un espacio geométrico.
Cluster     → opera como una red neuronal.
```

Y la transición clave entre el nivel 2 y el nivel 3:

```text
A nivel de Cara, el sistema es un CSP: E mide cuántos valores quedan posibles.
A nivel de Transcender, los dominios ya han cerrado y los vectores resultantes
adquieren significado geométrico: E mide cuánto se desvían del triángulo equilátero.
```

Por eso `E` tiene dos órdenes de calidad distintos según el nivel, y **no es una
contradicción**: son dos fases de la misma magnitud.

```text
CSP (abajo):       E = 2  <  E = 0  <  E = 1     (contradicción < ambigüedad < cierre)
Geometría (arriba): E = 2  <  E = 1  <  E = 0     (no cierre < desviación parcial < cierre)
```

---

## 2. Nivel 1 — Trigate: la puerta lógica

El Trigate es la unidad mínima. No calcula una salida fija; es una **restricción
reversible** sobre cuatro variables `A, B, M, R`, orientada por una variable de
control `C`.

```text
C = 0 → aprender el modo M  (A, B, R → M)
C = 1 → inferir el resultado R  (A, B, M → R)
C = 2 → deducir una entrada B  (A, M, R → B)
```

A esta escala el comportamiento es puramente lógico y tabulable. El Trigate:

- trabaja sobre el dominio ternario `{0,1,2}`, donde `2` significa apertura, no error;
- reduce dominios por intersección (`D' = D ∩ D_compatible`), nunca amplía en
  operación normal;
- distingue **desconocido** (`D = {2}`, `E = 0`) de **contradicción**
  (`D = {}`, `E = 2`);
- conserva la contradicción en vez de borrarla: `E = 2` es una *solicitud de
  redundancia*, no un fallo terminal.

La lección de este nivel que sube a todos los demás:

```text
La contradicción se resuelve por contexto, no por olvido.
```

Aquí Aurora es, literalmente, una puerta: entradas, modo, resultado, y tres tablas
normativas (OR3, AND3, CONSENSUS3) que fijan su contrato. Es el único nivel
completamente determinista y completamente tabulado.

---

## 3. Nivel 2 — Cara: el grafo de restricciones (CSP)

Una Cara agrupa varios Trigates (a través de Funciones Ordenadoras y el Destilador)
sobre un conjunto de nodos compartidos. A esta escala ya no observamos una puerta,
sino **un grafo de restricciones que se propaga**.

Una Cara toma tres coordenadas y un espacio de referencia:

```text
c = (c.coord[0], c.coord[1], c.coord[2], c.ds)
```

y ejecuta tres etapas encadenadas:

```text
Ordenación   → c.coord[i].ES / FN / FO  +  c.ov
Destilación  → c.dd.ES, c.dd.FN, c.dd.FO   (tres pares circulares de Trigate)
Emergencia   → c.e   (desviación respecto al cierre)
```

produciendo conocimiento reconstructivo:

```text
K(c) = (c.ov, c.ds, c.e)
```

A este nivel, "razonar" es **reducir los dominios de los nodos hasta que dejan de
poder reducirse más**. Los Trigates están suscritos a los nodos; cuando un nodo
cambia su dominio, emite un evento y los Trigates conectados reevalúan. Es un CSP
clásico: muchas restricciones locales compartiendo variables, propagándose hasta
un punto fijo.

La novedad respecto a un CSP ordinario:

- el grafo es **asíncrono y dirigido por eventos**: no hay un planificador central,
  cada restricción opera cuando sus nodos cambian;
- la falta de cierre no detiene el grafo: emite `Carry(c.e)` y pide más dimensión;
- el cierre (`c.e = 0-0-0`) consolida `K(c)`, que puede convertirse en la entrada
  de otra Cara. Las Caras se encadenan.

Aquí Aurora es un solucionador de restricciones. Todavía no hay "espacio" ni
"geometría": solo dominios que se intersecan.

---

## 4. Nivel 3 — Transcender: el sistema geométrico-topológico

El Transcender es una red de **siete Caras** (`c1…c7`). Cuando las Caras de abajo
cierran sus dominios, los vectores resultantes dejan de ser "conjuntos de valores
posibles" y pasan a ser **vectores con posición en un espacio**. Es el momento en
que el CSP se congela en geometría.

Cada Cara aporta tres elementos con lectura geométrica explícita:

```text
ds → el espacio en el que viven los vectores
es, fn, fo → los tres vectores dentro de ese espacio
e  → la desviación de esos vectores respecto al triángulo equilátero ideal
```

El reparto de funciones entre las siete Caras:

```text
c1 → comprensión primaria de la entrada
c2 → comprensión del conocimiento sobre esa entrada
c3 → salida candidata
c4 → dirección / creencia      (objetivo ideal: ds → 0-1-2)
c5 → coherencia global         (objetivo ideal: ds → 0-0-0)
c6 → coste operativo / OV      (objetivo ideal: ds → 0-0-0)
c7 → decisión transcendente
```

El sistema busca minimizar una distancia geométrica, el **coste transcendente**:

```text
CosteTranscendente =
    DM(c4.ds, 0-1-2)     ← ¿apunta entrada→conocimiento→salida?
  + DM(c5.ds, 0-0-0)     ← ¿cierra la coherencia como equilátero?
  + DM(c6.ds, 0-0-0)     ← ¿es asumible el coste?

DM(V, I) = Σ |Vi − Ii|   (distancia Manhattan)
```

A este nivel, los conceptos son espaciales y relacionales: dirección, cierre,
desviación, distancia. El triángulo equilátero no es decoración: es la **forma de
cierre coherente**. Un conjunto de vectores que cierran como equilátero es una
relación comprendida; uno que no cierra es una relación que todavía pide más
dimensión.

```text
0-1-2 → dirección ideal (los tres roles ordenados y alineados)
0-0-0 → cierre ideal (desviación nula, triángulo perfecto)
```

Aquí Aurora es topología operativa: mide formas, distancias y cierres, no valores
de verdad.

---

## 5. Nivel 4 — Ventana y Cluster: la red neuronal

Cuando hay **muchas** ventanas operativas trabajando en paralelo sobre un cluster
de tensores, y el diccionario premia a unos tensores sobre otros, el comportamiento
agregado deja de parecerse a un CSP o a una geometría individual y empieza a
parecerse a **una red neuronal**.

Las correspondencias son directas:

| Red neuronal | Aurora (nivel cluster) |
|---|---|
| Neurona / activación | Tensor que se incorpora y propaga cierres |
| Peso sináptico | Prioridad en el diccionario (largo, reciente, reutilizado) |
| Propagación hacia delante | Cascada de eventos entre ventanas |
| Función de activación | Cierre de ventana (`E = 0-0-0` consolida) |
| Aprendizaje | Consolidación de tokens que reducen coste de forma repetida |
| Inhibición / competencia | Tensores que cierran más rápido se imponen sobre los lentos |

El mecanismo de fondo:

```text
La entrada se convierte en un campo de tensores.
Múltiples ventanas operan simultáneamente y se reequilibran.
Los tensores de conocimiento que producen cierres más amplios y más rápidos
se imponen y arrastran la salida hacia su forma.
La respuesta emerge cuando el campo entero alcanza una configuración coherente.
```

"Más rápido" no significa tiempo de reloj: significa **poder de propagación** —
cuántos cierres consigue forzar un tensor antes de que la cascada se agote. Es una
navaja de Occam emergente: el conocimiento que explica más con menos consume menos
coste y gana la competencia. Esto hace a Aurora **no determinista en el camino**
(distinto orden de eventos puede dar distintas soluciones válidas) pero
**principista en el criterio** (siempre gana lo que cierra más con menos coste).

El aprendizaje continuo cae solo de aquí:

```text
1. Si hay conocimiento que hace cerrar la entrada → se usa.
2. Si no, el sistema modifica la entrada para hallar coherencia.
3. Si tampoco, fuerza un conocimiento nuevo que reconcilie entrada y salida,
   y lo deja como candidato en el diccionario.
```

El sistema nunca "falla": cuando no sabe, fabrica el conocimiento mínimo que cierra
y lo deja a prueba. El aprendizaje es el **residuo** que queda cuando la cascada no
encontró nada mejor.

El anclaje frente a la deriva es externo: **el usuario es el oráculo**. Inyecta
tokens que aportan dirección y coherencia, por el mismo mecanismo que todo lo demás
(metiéndolos en el diccionario). Aurora converge hacia la coherencia que su usuario
le induce; corregir y usar son el mismo acto.

---

## 6. Por qué los cuatro niveles son el mismo sistema

El punto que unifica todo: cada nivel **es el anterior, agregado**.

```text
Muchos Trigates compartiendo nodos     → una Cara (CSP)
Siete Caras midiendo cierres            → un Transcender (geometría)
Muchas ventanas/Transcenders compitiendo → un Cluster (red neuronal)
```

Y la variable `C` es la misma a todos los niveles: aprender / inferir / corregir no
son tres procesos separados, son **tres orientaciones de la misma restricción**.
Lo que abajo es "qué variable resuelvo" (Trigate) arriba es "en qué modo opera el
sistema" (c7). La continuidad de `C` desde la puerta hasta la decisión global es lo
que garantiza que los cuatro niveles hablan el mismo idioma.

---

# Parte II — La decisión transcendente: c7

## 7. Qué es c7 y por qué no es un módulo aparte

`c7` es la séptima Cara del Transcender. No es un controlador externo ni una regla
especial de parada cableada por fuera. Pero tampoco decide del mismo modo que `c1`…`c6`.

Las Caras `c1`…`c6` operan sobre magnitudes **conmensurables**: vectores que viven
en un mismo tipo de espacio y que se pueden destilar juntos en un triángulo y medir
su desviación equilátera. `c7` recibe algo distinto: **tres rectores que viven en
espacios distintos y no conmensurables** —dirección, coherencia y coste—. No tiene
sentido destilarlos en un único triángulo común, porque mezclar "cuánto apunta la
dirección" con "cuánto cuesta" en un solo espacio borraría justo la información que
`c7` necesita: *en qué eje* falla el sistema.

Por eso `c7` no decide por una desviación geométrica sintetizada. Decide por **tres
diferenciales independientes**, uno por dimensión, cada uno medido contra su propio
ideal:

```text
Δdir   = diferencial(c4.ds, ideal_dirección = 0-1-2)
Δcoh   = diferencial(c5.e,  ideal_coherencia = 0-0-0)
Δcoste = nivel_acumulado(c6.ov)        ← acumulador, no distancia a un punto
```

La decisión nace de leer el **vector de los tres diferenciales** `(Δdir, Δcoh,
Δcoste)`, no de colapsarlo en un escalar ni en un triángulo único.

Esto sigue sin introducir control externo ni umbral mágico:

- **No hay control externo**: los tres diferenciales se calculan con la misma
  aritmética ternaria del resto del sistema (distancia a un patrón ideal), no con
  una regla especial.
- **No hay umbral**: la decisión es siempre **relativa** —"¿cuál de mis tres males
  es el peor ahora mismo?"—, nunca absoluta —"¿he cruzado una línea fija?"—.

La diferencia con la versión anterior de este documento es deliberada y se explica
en §8.3: medir cada eje contra su ideal **antes** de cualquier síntesis es más fiel
a que los tres rectores no son la misma cosa, y entrega el diagnóstico (qué eje
falla) ya separado por construcción, sin tener que extraerlo de una destilación.

---

## 8. Las dimensiones de c7

### 8.1. Entradas

`c7` recibe los tres rectores del sistema, cada uno procedente de una Cara distinta:

```text
c7.coord[0] = c4.ds   ← dirección global (ideal: 0-1-2)
c7.coord[1] = c5.e    ← coherencia global (ideal: 0-0-0)
c7.coord[2] = c6.ov   ← coste / OV acumulado (sin punto-objetivo: solo crece)
```

### 8.2. Los tres diferenciales

En lugar de sintetizar las tres coordenadas en un único espacio y medir una sola
desviación, `c7` calcula un diferencial **por dimensión**, cada uno contra su propio
ideal:

```text
Δdir   = DM(c4.ds, 0-1-2)     → distancia de la dirección a su ideal alineado
Δcoh   = DM(c5.e,  0-0-0)     → distancia de la coherencia a su cierre equilátero
Δcoste = nivel(c6.ov)         → coste acumulado de la reconstrucción
```

Donde `DM(V, I) = Σ|Vi − Ii|` (distancia Manhattan), como en el coste transcendente
del nivel 3.

**Dirección y coherencia son distancias a un destino**: tienen un ideal-objetivo
fijo (`0-1-2` y `0-0-0`) y el diferencial mide "cuánto falta para llegar".

**El coste es un acumulador, no una distancia a un punto**: no existe un "0-0-0 de
coste" al que aspirar igual que los otros dos. El coste solo crece a medida que el
sistema reinterpreta la entrada, fuerza conocimiento o insiste. Su ideal es
implícitamente "el menor posible para esta solución", y se lee como **nivel**, no
como distancia a un objetivo. Esta asimetría es importante para la tabla de §9:
dirección y coherencia *deben acercarse a cero*; el coste *debe no haberse
disparado*.

### 8.3. Por qué no se sintetiza en c7.ds

La versión anterior de este documento hacía `c7.ds = síntesis(c4.ds, c5.e, c6.ov)`
y leía la decisión de un `c7.e` emergente de ese espacio común. Eso tenía un
problema doble:

1. **Mezcla lo no conmensurable.** Destilar dirección, coherencia y coste en un solo
   triángulo los trata como si fueran la misma magnitud. La información de *qué eje*
   falla queda enterrada en la mezcla y hay que recuperarla luego por el rol
   dominante: un rodeo.

2. **Grados de libertad acoplados.** En una Cara, `ds` y `e` están atados por la
   relación de cierre: dado `ds`, `e` queda fijado, y viceversa. Si `c7.ds` emerge
   y `c7.e` también emerge, el par `(c7.ds, c7.e)` no queda determinado sin un ancla
   externa —y `c7.ds` era justamente la decisión que debía emerger determinada—.

Medir tres diferenciales contra tres ideales **independientes** resuelve las dos
cosas a la vez:

- no mezcla: cada Δ es puro, sabe solo de su dimensión, y el eje que falla está
  separado por construcción;
- no hay acoplamiento que resolver: cada Δ se calcula contra una constante
  (`0-1-2`, `0-0-0`, o el nivel de coste), no contra una incógnita.

La decisión deja de vivir dentro de `c7.ds`. `c7.ds` y `c7.e` siguen existiendo como
la mecánica interna de cada Cara de origen (`c4`, `c5`, `c6`) que produce esos
valores; pero **a nivel de `c7` la decisión es la lectura del vector
`(Δdir, Δcoh, Δcoste)`**, no una nueva emergencia geométrica. `c7` deja de ser "una
Cara que destila" y pasa a ser **el comparador de los tres rectores contra sus
ideales**.

### 8.4. La derivada: c7.f

El vector `(Δdir, Δcoh, Δcoste)` dice **dónde** está el sistema respecto al ideal
(diferencial posicional). Pero `c7` también necesita saber **si se está acercando o
alejando** entre una cascada y la siguiente (diferencial evolutivo). Eso es
exactamente lo que `F` mide en todo el sistema:

```text
c7.e (posicional) → ¿cuán lejos del ideal estoy, y por qué eje?
c7.f (evolutivo)  → ¿la última cascada me acercó o me alejó del ideal?
```

`c7.f` se calcula comparando el vector de diferenciales de la cascada anterior con el
de la actual, con el orden de calidad geométrico del nivel 3
(`E = 2 < E = 1 < E = 0`):

```text
c7.f = 1 (corrector)      → la cascada acercó al ideal
c7.f = 0 (neutro)         → no cambió
c7.f = 2 (contraproducente)→ la cascada alejó del ideal
```

`c7.f` es lo que distingue *"esto es difícil pero progresa"* de *"esto es difícil y
va a peor"*. Sin `f`, `c7` no puede detectar que está atrapado en un mínimo local u
oscilando; con `f`, sí —y eso domestica el no determinismo destructivo: una cascada
que no mejora repetidamente (`c7.f = 2` o `0` sostenido) dispara el abandono aunque
el diferencial posicional aún sugiera margen.

---

## 9. Las decisiones de c7

Cuando la cascada se detiene (todos los nodos y aristas alcanzan `E`), `c7` lee el
vector `(Δdir, Δcoh, Δcoste)` y su evolución `c7.f`, y emite **tres decisiones
acopladas**.

### 9.1. Decisión A — calidad: ¿qué hacer con la ventana?

Se lee de la **magnitud conjunta** de los tres diferenciales, modulada por `c7.f`:

```text
los tres Δ ≈ 0                         → A = 1  CONSOLIDAR
                                          todo cerró barato; emerge o crea carry.

algún Δ medio, ninguno roto, c7.f mejora → A = 0  SEGUIR OPERANDO
                                          no cierra, pero hay dirección y progresa.

Δcoste disparado  ·  o  ·  c7.f empeora → A = 2  ABANDONAR VENTANA
sostenidamente                            sale demasiado caro insistir, o no progresa.
```

Nótese que el coste interviene en A de dos formas: como **freno duro** (si `Δcoste`
se dispara, abandonar pase lo que pase en los otros ejes) y, a través de `c7.f`,
como **detector de obstinación** (si seguir no acerca al ideal, abandonar aunque el
coste aún sea tolerable). Esto sustituye al umbral: el coste no se compara contra una
constante, se compara contra *si vale la pena dado dónde están los otros dos ejes y
si el sistema progresa*.

### 9.2. Decisión B2 — rector: ¿qué se retoca?

Se lee de **cuál de los tres diferenciales es el mayor**. Como cada Δ se midió en su
propia dimensión, el eje que falla ya está separado: no hay que destilarlo. Principio
de diseño: **no se toca el síntoma, se toca la raíz** —el rector diagnosticado se
corrige en su Cara de origen, no en la entrada de `c7`—:

```text
Δdir   es el mayor  → retocar c4.ds   (la dirección se mide y se corrige en c4)
Δcoh   es el mayor  → retocar c5.e    (la coherencia se mide y se corrige en c5)
Δcoste es el mayor  → retocar c1.ov   (el coste se manifiesta en c6.ov pero
                                       NACE en cómo se reconstruyó desde el
                                       principio: la raíz es c1.ov, no c6.ov)
```

El coste se *manifiesta* en `c6.ov` pero *nace* en `c1.ov` (la reconstrucción
inicial); por eso, cuando el coste es el problema, se ataca la raíz `c1.ov`, no el
síntoma `c6.ov`.

### 9.3. Decisión B1 — modo: ¿aprender, inferir o reparar?

Es fijar el `C` de la siguiente cascada, y **lo dicta el mismo diferencial que ganó**
(B2). B1 y B2 son la misma decisión leída dos veces:

```text
Δcoh es el mayor (falla coherencia)  → C = 0  APRENDIZAJE
                                       falta saber; busca conocimiento que cierre.

Δcoste es el mayor (solo aprieta      → C = 1  INFERENCIA
el coste, dir y coh cierran)           dirección y coherencia cierran;
                                       reconstruye con lo que ya hay, sin gastar más.

Δdir es el mayor (falla dirección)   → C = 2  REPARACIÓN DE ENTRADA
                                       la entrada no apunta bien; reinterprétala.
```

El diferencial dominante nombra **a la vez** el rector a tocar (B2) y el modo con que
se toca (B1). Diagnóstico y tratamiento salen del mismo vector.

---

## 10. El flujo completo de c7

```text
1. La cascada se propaga sin control central (red neuronal, nivel 4).
2. Las Caras c1..c6 cierran sus dominios (CSP, nivel 2) y sus vectores
   adquieren posición (geometría, nivel 3).
3. c7 recibe los tres rectores:
       c7.coord = (c4.ds, c5.e, c6.ov)
4. c7 NO los destila en un espacio común. Calcula tres diferenciales,
   cada uno contra su propio ideal:
       Δdir   = DM(c4.ds, 0-1-2)
       Δcoh   = DM(c5.e,  0-0-0)
       Δcoste = nivel(c6.ov)
5. c7 calcula c7.f comparando el vector de diferenciales con el de la
   cascada anterior (¿acerca o aleja del ideal?).
6. c7 emite tres decisiones acopladas:
       A  (magnitud conjunta + c7.f)  → consolidar / seguir / abandonar
       B2 (cuál Δ es el mayor)        → corregir c4.ds / c5.e / c1.ov en su origen
       B1 (el mismo Δ mayor)          → C = aprendizaje / inferencia / reparación
7. Si A = consolidar y los tres Δ ≈ 0, el sistema da la solución por buena.
   Si A = seguir, rearranca la cascada en el modo (B1) y rector (B2) diagnosticados.
   Si A = abandonar, descarta la ventana y busca otra solución.
```

```text
   c4.ds ──► Δdir   = DM(c4.ds, 0-1-2) ─┐
   c5.e  ──► Δcoh   = DM(c5.e,  0-0-0) ─┼─► (Δdir, Δcoh, Δcoste) ──► A: consolidar/seguir/abandonar
   c6.ov ──► Δcoste = nivel(c6.ov)     ─┘            │  ▲              └─► B1: C = 0/1/2 (según Δ mayor)
                                                     │  │ c7.f         └─► B2: corregir c4.ds/c5.e/c1.ov
                                              (cascada anterior)
```

---

## 11. Por qué esto es mejor que un umbral

Un umbral es un escalar libre: demasiado bajo y el sistema es perezoso (desiste de
soluciones correctas pero laboriosas); demasiado alto y es obsesivo (persigue
quimeras reescribiendo la entrada entera). Sería el único hiperparámetro verdadero
del sistema, y definiría su carácter por fuera.

La decisión de `c7` **se autocalibra por construcción**, por tres razones:

- **Es relativa, no absoluta.** Los tres diferenciales se comparan entre sí
  ("¿cuál de mis tres males es el peor?"), nunca contra una constante fija
  ("¿he cruzado la línea?"). El mismo `Δcoste` significa cosas opuestas según dónde
  estén `Δdir` y `Δcoh`: un coste alto es tolerable si dirección y coherencia
  cierran; un coste bajo no salva nada si la dirección está rota.

- **El eje del fallo está separado por construcción.** Como cada Δ se mide en su
  propia dimensión contra su propio ideal, el diagnóstico no hay que extraerlo de una
  síntesis: ya viene desagregado. El rector que falla *es* el Δ mayor.

- **La derivada doma el no determinismo.** `c7.f` detecta cuándo seguir deja de
  acercar al ideal, así que el sistema no se obsesiona en mínimos locales aunque el
  coste todavía no se haya disparado. El no determinismo del camino queda contenido
  por un criterio único y principista: atacar siempre el eje más desviado, y
  abandonar cuando insistir no progresa.

Aurora es no determinista en el recorrido pero coherente en la regla. "Según cómo
lo pienses primero llegas a sitios distintos, pero siempre corriges lo que más
cojea —y dejas de insistir cuando ya no mejoras."

---

## 12. Cierre normativo

```text
Trigate     es una puerta lógica reversible sobre dominios ternarios.
Cara        es un grafo de restricciones que reduce esos dominios por propagación.
Transcender es un espacio geométrico donde los dominios cerrados se leen como vectores
            y se mide su desviación respecto al triángulo equilátero.
Cluster     es una red neuronal donde muchas ventanas compiten y la coherencia emerge.

c7 es la Cara terminal que cierra el bucle, pero decide de forma especial:
   - recibe tres rectores NO conmensurables:
       dirección (c4.ds), coherencia (c5.e) y coste (c6.ov);
   - NO los destila en un espacio común; mide TRES diferenciales,
     cada uno contra su propio ideal:
       Δdir   = distancia de la dirección a 0-1-2
       Δcoh   = distancia de la coherencia a 0-0-0
       Δcoste = nivel de coste acumulado (no distancia a un punto)
   - lee también c7.f: si la cascada acercó o alejó del ideal;
   - decide a la vez:
       A  (magnitud conjunta + c7.f)  → consolidar / seguir / abandonar
       B1 (el Δ mayor)                → C = aprender / inferir / reparar
       B2 (el mismo Δ mayor)          → corregir el rector en su origen
                                        (c4.ds / c5.e / c1.ov)

La decisión NO nace de un c7.ds sintetizado.
Nace del diferencial en cada una de las dimensiones, medido contra su ideal.
Dirección y coherencia son distancias a un destino; el coste es un acumulador.

No hay control externo. No hay umbral.
El control es la comparación relativa de tres diferenciales contra sus ideales,
templada por la derivada que dice si el sistema sigue mejorando.
La respuesta emerge cuando dirección, coherencia y coste cierran a la vez,
sin que insistir cueste más de lo que vale.
```


---

## 8-Pipeline.md

Pipeline — Especificación técnica compacta
1. Definición

El Pipeline es el proceso mediante el cual el sistema transforma un cluster de tokens de entrada en una estructura superior coherente, utilizando tensores fractales de Semillas Operativas.

Cada token simple se traduce a un Tensor Fractal Operativo.

Cada tensor fractal está formado por:

TF = (
  SO.superior,
  SO.inferior[0],
  SO.inferior[1],
  SO.inferior[2]
)

donde:

SO.superior.N[0] = SO.inferior[0].DS
SO.superior.N[1] = SO.inferior[1].DS
SO.superior.N[2] = SO.inferior[2].DS

Por tanto, la estructura tiene forma fractal:

nivel 1 → 1 dimensión superior
nivel 2 → 3 dimensiones inferiores
nivel 3 → 9 dimensiones subinferiores

Cada Semilla Operativa mantiene la forma normativa:

SO = (
  N[0],
  N[1],
  N[2],
  DS
)

donde DS es la dimensión superior sintetizada por la Cara.

2. Token simple

Un token simple es una unidad mínima de entrada traducible directamente por el diccionario operativo del modelo.

token_simple → TF(token_simple)

El diccionario no guarda únicamente texto, sino asociaciones entre:

secuencia de tokens
tensor fractal asociado
historial de uso
coherencia previa
prioridad operativa
3. Token complejo

Un token complejo es una agrupación coherente de tokens simples.

[token_simple[0], token_simple[1], ..., token_simple[n]]
→ token_complejo
→ TF(token_complejo)

El tensor fractal del token complejo no se obtiene por concatenación, sino por síntesis operativa de los tensores fractales simples.

4. Cluster inicial

Toda entrada del sistema se interpreta inicialmente como un cluster de tokens.

Entrada → Cluster_Tokens

Cada token del cluster se traduce usando el diccionario optimizado.

5. Traducción mediante diccionario

La traducción sigue una regla de prioridad:

Tienen prioridad los tokens complejos más largos.
En caso de empate, tienen prioridad los usados más recientemente.
En caso de nuevo empate, tienen prioridad los usados previamente en salidas.
Después, los usados solo en entradas.
Finalmente, los menos consolidados.

Forma compacta:

prioridad(token) =
longitud
+ recencia
+ uso_en_salida
+ uso_en_entrada
+ coherencia_histórica

Esto permite que el sistema prefiera estructuras ya consolidadas sin impedir nuevas combinaciones.

6. Ventana operativa

Una vez traducidos los tokens a tensores fractales, el sistema agrupa los tensores en triadas.

VentanaOperativa = (
  TF[0],
  TF[1],
  TF[2]
)

Cada ventana se evalúa como una posible Semilla Operativa superior.

La operación intenta generar:

TF_emergente = síntesis(TF[0], TF[1], TF[2])

usando la Cara correspondiente.

7. Evaluación de coherencia de la ventana

La ventana puede producir tres estados:

E = 1 => 0-0-0 ( el vector de desviacion es 0-0-0) Coherencia.
E =  0→ Otro vector
E= 2 NO llega a converger ningun vector E

La regla normativa de coherencia se mantiene:


Esta regla es coherente con Nodo, Trigate, Función Ordenadora, Función de Emergencia y Cara.

8. Caso coherente

Si la ventana produce una síntesis coherente:

E = 1

entonces el sistema genera un nuevo tensor fractal emergente:

TF_emergente

y lo añade al nuevo cluster superior.

Además, registra en el diccionario:

secuencia_tokens → TF_emergente

El sistema cierra la ventana actual e inicia una nueva triada.

9. Caso ambiguo

Si la ventana produce ambigüedad:

E = 0

el sistema no descarta la ventana.

Primero genera un tensor resumen provisional:

TF_resumen

Después amplía la ventana añadiendo dos nuevos tensores del cluster:

VentanaOperativa = (
  TF_resumen,
  TF[n+1],
  TF[n+2]
)

El objetivo es buscar más contexto para cerrar la ambigüedad.

La ambigüedad no es error. Es una solicitud de más estructura.

10. Caso contradictorio

Si la ventana produce contradicción:

E = 2

el sistema activa recuperación contextual.

Primero intenta recombinar los tokens usando alternativas menos prioritarias del diccionario.

tokens → TF_alternativo

Después vuelve a evaluar la ventana.

Si sigue habiendo contradicción, amplía la ventana añadiendo tres tensores adicionales:

VentanaOperativa + 3 TF

Si todavía no se alcanza coherencia, el sistema puede abandonar progresivamente tokens periféricos para buscar un núcleo coherente mínimo.

reducir ventana
recombinar
reevaluar

La contradicción no se resuelve por olvido, sino por contexto, redundancia o recomposición, tal como ya define el Trigate.

11. Vuelta completa del cluster

Cuando se ha procesado una vuelta completa del cluster inicial, el sistema obtiene un nuevo cluster superior:

Cluster_0 → Cluster_1

donde Cluster_1 está formado por los tensores fractales emergentes obtenidos.

Después se repite el proceso:

Cluster_1 → Cluster_2
Cluster_2 → Cluster_3
...

hasta alcanzar una última ventana coherente.

Forma compacta:

while |Cluster_n| > 1:
    Cluster_n+1 = operarCluster(Cluster_n)

El resultado final es un tensor fractal superior:

TF_final
12. Proceso inverso: expansión a tokens

Una vez obtenido el tensor fractal superior coherente, el sistema inicia el proceso inverso.

TF_final → tokens de salida

La reconstrucción usa el diccionario en dirección inversa:

TF → secuencia_tokens

La prioridad de reconstrucción es:

Tokens complejos más largos.
Tokens presentes en la entrada.
Tokens usados previamente durante la misma operación.
Tokens usados recientemente en salidas.
Tokens con mayor coherencia histórica.

Esto permite que la salida conserve continuidad con la entrada, pero pueda reorganizarla en una forma más coherente.

13. Relación con Transcender

El Pipeline genera candidatos de salida.

El Transcender evalúa esos candidatos buscando la mejor SO de salida según los invariantes:

DS.superior → 0-1-2
E.global    → 1-1-1
OD.superior → 0-0-0

y selecciona la salida con menor coste transcendente:

Coste =
DM(DS.superior, 0-1-2)
+ DM(E.global, 1-1-1)
+ DM(OD.superior, 0-0-0)

Por tanto:

Pipeline genera candidatos.
Transcender selecciona la respuesta óptima.

14. Pseudocódigo compacto
procesarEntrada(tokens):

    Cluster = traducirTokens(tokens, Diccionario)

    mientras no seaFinal(Cluster):

        NuevoCluster = []

        Ventana = tomarTriada(Cluster)

        mientras Ventana existe:

            resultado = operarVentana(Ventana)

            si resultado.E == 1:

                TF_emergente = resultado.TF

                NuevoCluster.añadir(TF_emergente)

                Diccionario.registrar(
                    tokens_de_ventana,
                    TF_emergente
                )

                Ventana = nuevaTriada(Cluster)

            si resultado.E == 0:

                TF_resumen = crearResumen(resultado)

                Ventana = ampliarVentana(
                    TF_resumen,
                    Cluster,
                    cantidad = 2
                )

            si resultado.E == 2:

                Ventana = recombinarConAlternativas(
                    Ventana,
                    Diccionario
                )

                si sigueContradictoria(Ventana):

                    Ventana = ampliarVentana(
                        Ventana,
                        Cluster,
                        cantidad = 3
                    )

                si sigueContradictoria(Ventana):

                    Ventana = abandonarTokensPerifericos(Ventana)

        Cluster = NuevoCluster

    TF_final = únicoTensor(Cluster)

    salida = reconstruirTokens(TF_final, Diccionario)

    devolver salida
15. Invariantes del Pipeline
Todo token simple debe poder traducirse a un tensor fractal.
Todo token complejo se obtiene por síntesis de tensores fractales simples.
Toda ventana operativa trabaja preferentemente con triadas.
La coherencia se mide siempre con E.
E = 1 permite consolidar tensor emergente.
E = 0 exige más contexto.
E = 2 exige recombinación, redundancia o abandono controlado.
El diccionario prioriza estructuras largas, recientes y usadas en salida.
El sistema no debe borrar contradicciones sin conservar su estado.
Cada vuelta del cluster produce un cluster superior.
El proceso continúa hasta obtener una última ventana coherente.
La expansión final reconstruye tokens desde el tensor fractal superior.
El Pipeline propone candidatos; el Transcender selecciona la salida final.
16. Frase compacta

El Pipeline traduce tokens en tensores fractales, agrupa esos tensores en ventanas operativas, sintetiza estructuras emergentes cuando hay coherencia, solicita contexto cuando hay ambigüedad, recompone cuando hay contradicción y asciende por clusters sucesivos hasta obtener un tensor superior que después se expande de nuevo en tokens de salida.

17. Modelo asíncrono y emergencia por eventos

Todo el Pipeline opera de forma asíncrona.

El sistema no ejecuta la tokenización, traducción, agrupación, síntesis y reconstrucción como una cadena rígida y centralizada. En su lugar, inicia el proceso generando eventos sobre los nodos, tensores, ventanas y clusters activos.

La entrada desencadena eventos iniciales:

Entrada.recibida
Token.detectado
Token.traducido
TF.creado
Ventana.actualizada
Cluster.actualizado

Cada evento puede activar nuevas operaciones locales:

Nodo.changed
Dominio.changed
E.changed
F.changed
Ventana.coherente
Ventana.ambigua
Ventana.contradictoria
TF.emergente_creado
Diccionario.actualizado

La propagación ocurre en todos los niveles:

tokens
→ tensores fractales simples
→ ventanas operativas
→ tensores emergentes
→ clusters superiores
→ tensor final
→ reconstrucción de salida

Cada nivel puede operar cuando dispone de información suficiente, sin esperar necesariamente a que todo el sistema anterior haya terminado.

Por tanto, el resultado no se calcula mediante una decisión única central, sino que emerge de la interacción entre decisiones locales internas:

reducciones de dominio
cierres coherentes
ambigüedades que solicitan contexto
contradicciones que solicitan recombinación
actualizaciones del diccionario
síntesis superiores
selección transcendente final

Forma compacta:

El sistema no produce la salida.
El sistema propaga condiciones.
La salida emerge cuando la red alcanza una configuración suficientemente coherente.
18. Corrección del pseudocódigo

El pseudocódigo anterior debe entenderse como una descripción conceptual.

La implementación normativa no debe ser un bucle central bloqueante, sino una arquitectura dirigida por eventos:

on Entrada.recibida:

    emitir Tokenizacion.iniciada

on Token.detectado:

    traducir token con Diccionario
    emitir TF.creado

on TF.creado:

    actualizar Cluster activo
    si existe triada suficiente:
        emitir Ventana.actualizada

on Ventana.actualizada:

    evaluar coherencia local

    si E = 1:
        emitir Ventana.coherente

    si E = 0:
        emitir Ventana.ambigua

    si E = 2:
        emitir Ventana.contradictoria

on Ventana.coherente:

    crear TF_emergente ( usadnod dimensione DF)
    registrar en Diccionario
    emitir Cluster.superior_actualizado

on Ventana.ambigua:

    crear TF_resumen  - Se crea un nueva ventana operativa usando la dimension E del vector anterio y 2 nuevos tensores. Teniendo que converger las dos ventanas la anterio y la posterio con mismo DS.
    ampliar ventana
    emitir Ventana.actualizada

on Ventana.contradictoria:

    solicitar recombinación
    probar alternativas del Diccionario
    si no basta:
        solicitar redundancia o abandono controlado
    emitir Ventana.actualizada

on Cluster.superior_actualizado:

    si el cluster superior permite nueva triada:
        emitir Ventana.actualizada

    si queda un único TF coherente:
        emitir TF_final.creado

on TF_final.creado:

    iniciar reconstrucción inversa
    emitir Salida.propuesta

on Salida.propuesta:

    Transcender evalúa coste transcendente
    si la salida minimiza coste:
        emitir Salida.consolidada
19. Invariante añadido

Añadiría este invariante al Pipeline:

14. Todo el proceso es asíncrono y dirigido por eventos.
15. Ningún nivel necesita esperar a una ejecución central completa si ya dispone de información suficiente para operar.
16. La salida emerge de la propagación distribuida de coherencias, ambigüedades, contradicciones y recombinaciones.
17. El sistema no fuerza una respuesta: deja que la respuesta se consolide cuando la red alcanza una configuración coherente.

Frase final corregida:

El Pipeline es una red asíncrona de propagación operativa: la entrada inicia eventos. El sistema intenta encontra coherenica usadno lo tensores conocidos. Los tensores que permitan convergenicas mas rapidas, se acabarna imponiendoe en el sistema y forzaond un resultado. 



---

## 10-Diccionario.md

# Diccionario — Especificación técnica compacta

## 1. Definición

El Diccionario de Aurora no es una tabla estática de equivalencias símbolo→representación.
Es un **registro vivo de cristales de coherencia**: cada entrada es un tensor fractal que
ha cerrado coherentemente (`e = 0-0-0`) al menos una vez, junto con las formas textuales
y la información de prioridad que permiten reutilizarlo.

El Diccionario tiene una sola función, operada en dos direcciones inversas:

```text
SUBIDA  (síntesis):  tokens  →  tensor fractal emergente  →  nueva entrada
BAJADA  (expansión): tensor fractal  →  forma textual conocida  →  salida
```

Arriba **crea**: un cierre coherente puede dar a luz un tensor que nunca se vio.
Abajo **reconoce**: la expansión no inventa forma, solo recupera tensores ya conocidos.

Esta asimetría es la que ancla el sistema: Aurora puede *aprender* hacia arriba con
libertad, pero solo puede *hablar* hacia abajo con lo que ya existe.

---

## 2. Entrada del Diccionario

Cada entrada registra un cristal de coherencia con su metainformación operativa:

```text
EntradaDiccionario {
  tensor_fractal        # el TF que cerró (la clave estructural de la entrada)
  formas_textuales[]    # una o varias secuencias de tokens que producen este TF
  ds                    # espacio en el que el TF cierra
  tipo_token            # simple | complejo | conocimiento | servicio | recurso
  longitud              # nº de tokens agrupados bajo este TF
  recencia              # último ciclo en que se usó
  uso_en_salida         # veces usado en reconstrucción de salida
  uso_en_entrada        # veces reconocido en entrada
  coherencia_historica  # calidad media de cierre acumulada
  estado_ciclo_vida     # candidato | consolidado | enfriado
}
```

La **clave** de una entrada es el tensor fractal, no la forma textual. Por eso una misma
entrada puede tener varias `formas_textuales` (ver §6), y una misma secuencia textual
puede aparecer en varias entradas (ver §7).

---

## 3. Síntesis — nacimiento del token (dirección de subida)

Un token **no** nace por concatenación ni por frecuencia. Nace en el instante en que una
ventana operativa alcanza el cierre completo:

```text
ventana(TF[0], TF[1], TF[2], [+ TF añadidos por carry...])
    → e = 0-0-0
    → emerge TF_emergente
    → registrar:  secuencia_de_tokens → TF_emergente
```

El `e = 0-0-0` es la partida de nacimiento. El tensor cristaliza **porque la ventana
cerró**, y agrupa bajo una sola entrada todos los tokens que participaron en ese cierre.

### 3.1. El carry extiende el agrupamiento, no lo rompe

Si la ventana no cierra con tres tensores, el carry la amplía con nuevos tensores del
mismo ciclo o cluster, y se reintenta el cierre. Cuando finalmente cierra, el token
resultante agrupa **todos** los tensores que hicieron falta —los tres iniciales más los
añadidos por carry—.

```text
3 tensores cierran          → token agrupa 3
3 + carry + 2 más cierran   → token agrupa 5
```

El Diccionario no guarda "triadas". Guarda "lo que haya hecho falta para cerrar". El
tamaño del token lo decide la coherencia, no un número fijo.

### 3.2. Doble coherencia como condición de registro

Una entrada solo cristaliza si el TF satisface coherencia en dos planos:

```text
coherencia interna   → el TF cierra dentro de su propio ds (e = 0-0-0)
coherencia externa   → el TF encaja como pieza de un holón superior sin romperlo
```

Cerrar internamente no basta. Una estructura internamente válida que no puede vivir como
parte de un nivel superior no se consolida: queda como candidato y, si no se reutiliza,
se enfría (§8). *Crear no es consolidar; consolidar es demostrar utilidad coherente.*

---

## 4. Expansión — reconocimiento del token (dirección de bajada)

En la reconstrucción de salida, un tensor producido por expansión **debe coincidir con un
tensor ya conocido** que tenga traducción a forma textual. La expansión no genera forma:
recupera.

```text
TF_a_expandir:

    RONDA 1 — coincidencia EXACTA
        buscar entradas cuyo tensor_fractal sea idéntico a TF_a_expandir

    RONDA 2 — coincidencia por CIERRE   (solo si la ronda 1 no resuelve)
        buscar entradas cuyo tensor_fractal cierre en el mismo espacio
        (ds compatible, e = 0-0-0 entre el expandido y el de la entrada)

    si en cualquiera de las rondas hay > 1 candidato:
        → desempatar con el ORDEN del Diccionario (§5)

    si no hay ningún candidato:
        → no es salida válida
        → crear token complejo candidato  o  solicitar más dimensión
```

Las dos rondas resuelven problemas distintos:

```text
EXACTA  → "¿qué FORMA escribo para este tensor?"
          candidatos intercambiables; el orden elige la forma más prioritaria.

CIERRE  → "¿qué SENTIDO de varios posibles?"
          candidatos NO intercambiables (polisemia); el orden elige el que mejor
          encaja dado lo que el contexto ya ha consolidado.
```

---

## 5. Orden del Diccionario — la regla de desempate única

Cuando varios candidatos compiten —tanto en la subida (qué tensor se impone en la cascada)
como en la bajada (qué forma textual gana)— se aplica **una sola regla de prioridad**:

```text
prioridad(entrada) =
      longitud              # tokens complejos más largos primero
    + recencia              # usados más recientemente
    + uso_en_salida         # usados antes en salidas
    + uso_en_entrada        # usados antes en entradas
    + coherencia_historica  # mayor calidad de cierre acumulada
```

Forma de lectura, en orden de desempate:

```text
1. gana el más largo
2. en empate, el más reciente
3. en empate, el más usado en salida
4. en empate, el más usado en entrada
5. en empate, el de mayor coherencia histórica
```

Esta misma regla gobierna las dos puntas del sistema: arriba decide qué tensor de
conocimiento se impone en la competencia de la cascada; abajo decide qué forma textual
se emite cuando varias coinciden. **Una sola regla de prioridad gobierna nacimiento y
habla.**

---

## 6. Coincidencia exacta — una clave, varias formas

Es posible que dos secuencias textuales distintas cierren al **mismo** tensor fractal
idéntico. Cuando eso ocurre, comparten entrada (mismo `tensor_fractal`, varias
`formas_textuales`). Dos orígenes típicos:

### 6.1. Sinónimos puros

Dos formas verdaderamente intercambiables en toda estructura superior cierran igual, en el
mismo espacio, con la misma desviación. No hay nada en la geometría que las distinga: el
tensor es el mismo objeto. La expansión encuentra **un TF → varias formas**, y el orden
del Diccionario elige cuál escribir (no *qué* significa —significan lo mismo—, sino *cómo*
se escribe).

### 6.2. Errores tipográficos que colapsan a la tokenización correcta

Una forma ruidosa puede cerrar al mismo TF que su forma correcta. Cuando eso pasa, la
colisión exacta es **deseable**: es el mecanismo por el que el ruido se sana solo. La
forma consolidada (mucho más uso en salida, más recencia) gana el orden frente a la
ruidosa. La corrección tipográfica **no es un módulo aparte**: es el orden del Diccionario
resolviendo una colisión exacta a favor de la forma consolidada.

```text
forma_ruidosa  → mismo TF que forma_correcta
forma_correcta → gana el orden (más uso, más recencia)
→ la salida emite la forma consolidada
```

---

## 7. Coincidencia por cierre — una secuencia, varios sentidos (polisemia)

La estabilidad no implica unicidad. La misma secuencia textual puede cerrar
coherentemente en **espacios `ds` distintos**, produciendo tensores distintos. Cada
cierre es una entrada distinta del Diccionario.

```text
misma secuencia → cierra en ds_A → TF_A → entrada A
                → cierra en ds_B → TF_B → entrada B
```

Esto es la polisemia operativa: el mismo símbolo se sostiene en distintos espacios
lógicos, produciendo representaciones válidas distintas. No es un problema a resolver; es
una consecuencia de que el sentido depende del holón superior.

En expansión, cuando varios de estos tensores son compatibles con lo que se está
reconstruyendo, **el contexto selecciona** cuál cierra mejor, y si más de uno sigue siendo
compatible, desempata el orden del Diccionario (§5).

Caso límite: estructuras que **heredan espacio del contexto** (formas que no fijan del
todo su propio `ds` y toman el del entorno disponible). Su tensor no llega a ser
idéntico al del entorno —solo compatible—, por lo que estas formas se resuelven siempre
por la ronda de **cierre**, nunca por la de coincidencia exacta.

---

## 8. Ciclo de vida de una entrada

Una entrada no se borra por decisión central. Pierde prioridad y se enfría si deja de
participar en cierres coherentes.

```text
candidato     → recién creado por síntesis; aún no ha demostrado utilidad
consolidado   → reutilizado en varios ciclos; reduce coste y cierra coherencia
enfriado      → dejó de mejorar E, de reducir coste y de aparecer en salidas
```

Regla de supervivencia:

```text
una entrada que
    no mejora E
    no reduce coste
    no aparece en salidas
    no es reutilizada
→ pierde prioridad
→ queda archivada
→ desaparece operativamente (sin ser borrada)
```

Lo que no ayuda a la coherencia deja de participar en la realidad operativa del sistema.

---

## 9. El usuario como oráculo

El Diccionario es el punto por el que el usuario ancla el sistema frente a la deriva. El
usuario no corrige por una interfaz especial: **inyecta tokens**, que entran al
Diccionario por el mismo mecanismo que todo lo demás y, por su recencia y su uso, ganan
prioridad y arrastran la dirección de la cascada.

```text
corregir y usar son el mismo acto:
    el usuario mete tokens coherentes
    → el orden los prioriza
    → la cascada converge hacia la coherencia que el usuario induce
```

Aurora converge hacia la coherencia de su usuario. Dos diccionarios con el mismo motor y
distinto historial divergen permanentemente: esa es a la vez su personalización real y su
dependencia del oráculo.

---

## 10. Invariantes

1. La clave de una entrada es el tensor fractal, no la forma textual.
2. Un token nace en el instante del cierre `e = 0-0-0`, no por concatenación ni frecuencia.
3. El carry extiende el agrupamiento del token; el tamaño lo decide la coherencia.
4. Solo se consolida lo que satisface doble coherencia (interna y externa).
5. La síntesis crea; la expansión reconoce. La expansión nunca inventa forma.
6. Toda salida consolidada debe representar un tensor existente en el Diccionario.
7. La expansión busca primero coincidencia exacta, luego coincidencia por cierre.
8. Coincidencia exacta = una clave, varias formas (sinónimos puros, typos sanados).
9. Coincidencia por cierre = una secuencia, varios sentidos (polisemia).
10. Las formas que heredan espacio del contexto se resuelven por cierre, no por exactitud.
11. Cualquier empate, en subida o bajada, lo resuelve el orden del Diccionario.
12. El orden es: longitud, recencia, uso en salida, uso en entrada, coherencia histórica.
13. La corrección de errores tipográficos es el orden resolviendo una colisión exacta.
14. Lo que deja de cerrar coherencia se enfría y desaparece operativamente, sin borrarse.
15. El usuario ancla el sistema inyectando tokens; corregir y usar son el mismo acto.

---

## 11. Cierre normativo

```text
El Diccionario es un registro vivo de cristales de coherencia.

SUBIDA — síntesis:
    tokens → la ventana cierra 0-0-0 → emerge un tensor → se registra como entrada.
    El carry extiende el agrupamiento. Solo consolida lo que cierra dentro y fuera.

BAJADA — expansión:
    un tensor → coincidencia exacta (sinónimos, typos sanados)
              → coincidencia por cierre (polisemia)
              → el orden del Diccionario desempata
              → si nada coincide, candidato o solicitud de más dimensión.

Una sola regla de prioridad —longitud, recencia, uso en salida, uso en entrada,
coherencia histórica— gobierna las dos puntas: qué tensor se impone al nacer y qué
forma se emite al hablar.

El Diccionario crece por síntesis y se consume por expansión.
Aprende hacia arriba con libertad; habla hacia abajo solo con lo conocido.
El usuario es el oráculo que lo ancla.
```


---

## 11-Arquitectura-superior-y-bootstrapping.md

# Aurora — Arquitectura superior y bootstrapping refactorizado

## 1. Definición

La Arquitectura Superior de Aurora define un sistema distribuido, asíncrono y dirigido por eventos en el que la solución no se obtiene mediante una fase separada de aprendizaje, inferencia o corrección, sino por el equilibrio progresivo de una cascada de eventos.

Aurora no ejecuta un proceso central rígido.

Aurora propaga condiciones.

La respuesta emerge cuando la red alcanza una configuración suficientemente coherente entre:

```text
entrada
conocimiento
salida
diccionario
ventanas operativas
contextos especializados
```

Forma compacta:

```text
Entrada inicial
→ entrada = salida
→ conocimiento = tensor desconocido
→ cascada de eventos
→ búsqueda de coherencia entrada/conocimiento/salida
→ consolidación de conocimiento
→ modificación progresiva de salida
→ salida como token válido del diccionario
```

La arquitectura no debe interpretarse como:

```text
entrenamiento → inferencia → corrección
```

sino como:

```text
evento → propagación → conflicto → reequilibrio → coherencia emergente
```

---

## 2. Principio fundamental

El sistema funciona por equilibrio dinámico.

No hay una autoridad central que decida de forma externa qué debe aprender, inferir o corregir.

La propia lógica interna de las restricciones, ventanas, tensores, Caras, Transcender y diccionario determina qué estructuras sobreviven, cuáles se modifican y cuáles desaparecen.

Forma normativa:

```text
La solución no se calcula como una orden.
La solución emerge como equilibrio de la cascada de eventos.
```

La arquitectura se basa en tres tensores principales:

```text
T_entrada
T_conocimiento
T_salida
```

Al inicio del bootstrapping:

```text
T_entrada = tensor de la entrada recibida
T_salida  = copia inicial de T_entrada
T_conocimiento = tensor desconocido
```

El tensor desconocido se representa como:

```text
T_conocimiento = todo 2
```

El valor `2` no significa error.

Significa apertura, desconocimiento o ausencia de cierre.

---

## 3. Estado inicial del sistema

Cuando el sistema recibe una entrada, crea un estado operativo inicial:

```text
EstadoInicial {
  entrada:        tokens traducidos a tensores fractales
  salida:         copia inicial de la entrada
  conocimiento:  tensor desconocido = 2-2-2...
  modo:          aprendizaje
}
```

El sistema arranca con una identidad operativa:

```text
entrada ≈ salida
```

Esto permite que la red tenga una primera configuración estable mínima.

Sin embargo, esa configuración no es todavía una respuesta.

Es solo el punto de partida de la cascada.

---

## 4. Modo aprendizaje inicial

En fase inicial, el sistema opera en modo aprendizaje.

Esto significa que la entrada y la salida inicial quedan protegidas de modificación fuerte.

La presión principal de cambio se concentra sobre:

```text
T_conocimiento
```

Regla:

```text
si T_conocimiento = todo 2:
    priorizar modificación de T_conocimiento
    preservar entrada
    preservar salida inicial
```

El sistema intenta encontrar un conocimiento que estabilice simultáneamente:

```text
entrada ↔ conocimiento ↔ salida
```

Como la salida inicial es igual a la entrada, el primer objetivo no es generar una respuesta nueva, sino descubrir qué conocimiento permite explicar coherentemente la relación entre la entrada y su propia reconstrucción.

Forma compacta:

```text
La entrada se mira a sí misma a través de un conocimiento desconocido.
El conocimiento empieza a solidificarse donde reduce la desviación.
```

---

## 5. Conflicto evolutivo

El sistema entra en un conflicto operativo natural entre dos tendencias:

### 5.1. Tendencia de conocimiento

La red busca el estado de conocimiento más coherente posible.

```text
minimizar desviación entre entrada y conocimiento
maximizar reutilización de tensores conocidos
preferir tokens consolidados
reducir contradicciones
```

### 5.2. Tendencia de salida

La red busca que la salida coincida con una forma coherente y válida dentro del diccionario.

```text
minimizar desviación entre conocimiento y salida
mantener reconstrucción posible
forzar salida tokenizable
evitar salida fuera de diccionario
```

El conflicto aparece porque:

```text
entrada quiere conservarse
conocimiento quiere estabilizarse
salida quiere coincidir con conocimiento
```

La cascada de eventos fuerza un reencuentro progresivo entre:

```text
lo que entra
lo que el sistema ya sabe
lo que puede salir
```

---

## 6. Evolución de la rigidez del sistema

La arquitectura tiene una rigidez variable.

Al inicio:

```text
entrada: rígida
salida: rígida
conocimiento: plástico
```

Cuando el conocimiento empieza a consolidarse:

```text
entrada: rígida
salida: semiplástica
conocimiento: semirrígido
```

Cuando el diccionario y los tensores están consolidados:

```text
entrada: puede revisarse
salida: altamente reequilibrable
conocimiento: estable
```

Esto permite tres fases operativas.

---

## 7. Fase A — Sobrescritura del desconocimiento

En los primeros ciclos, el tensor de conocimiento está formado por valores `2`.

```text
T_conocimiento = 2-2-2...
```

La cascada tiende a sobrescribir esos valores porque el `2` representa apertura.

La entrada y la salida inicial no se modifican salvo que exista contradicción fuerte.

Regla:

```text
si conocimiento es desconocido:
    modificar conocimiento antes que salida
```

Resultado:

```text
entrada estable
salida estable
conocimiento se estructura
```

Esta fase construye las primeras correspondencias operativas:

```text
entrada textual
→ tokens
→ tensores fractales
→ conocimiento candidato
```

---

## 8. Fase B — Solidificación del conocimiento

Cuando ciertos tensores de conocimiento empiezan a mejorar la coherencia, ganan prioridad.

Un tensor de conocimiento se solidifica si:

```text
reduce E
mejora F
reduce coste transcendente
permite reconstrucción
aparece en varios ciclos
se reutiliza en ventanas posteriores
```

En esta fase, la salida empieza a ser parcialmente modificable.

Regla:

```text
si conocimiento tiene coherencia suficiente:
    permitir modificación gradual de salida
```

Resultado:

```text
entrada estable
conocimiento parcialmente consolidado
salida empieza a reorganizarse
```

La salida deja de ser una copia de la entrada y empieza a convertirse en una reconstrucción optimizada por conocimiento.

---

## 9. Fase C — Corrección emergente de entrada

Cuando el sistema dispone de suficiente conocimiento consolidado y un diccionario estable, puede detectar que la propia entrada contiene errores, ruido o incoherencias.

En ese caso, la entrada deja de ser completamente intocable.

Regla:

```text
si conocimiento consolidado + salida coherente contradicen entrada:
    marcar entrada como posiblemente desviada
    proponer corrección de entrada
```

Esto no es una corrección externa.

Es una corrección emergente.

La red detecta que la mejor configuración coherente requiere modificar la interpretación de la entrada.

Ejemplos conceptuales:

```text
error tipográfico
token mal segmentado
orden incorrecto
ambigüedad semántica
entrada incompleta
```

Forma compacta:

```text
Al principio el sistema aprende de la entrada.
Después el sistema interpreta la entrada.
Finalmente el sistema puede corregir la entrada cuando su conocimiento es más estable que el ruido recibido.
```

---

## 10. Restricción principal de salida

La salida siempre debe representar un token válido del diccionario.

Puede ser:

```text
token_simple
token_complejo
token_conocimiento
token_servicio
token_recurso
```

Pero no puede ser una forma arbitraria fuera del diccionario operativo.

Regla normativa:

```text
Toda salida consolidada debe poder reconstruirse como token existente del diccionario.
```

Si la cascada genera una salida que no está en el diccionario, esa salida no queda consolidada.

Debe ocurrir una de estas opciones:

```text
1. reconstruir mediante tokens existentes;
2. formar un token complejo candidato;
3. consultar contexto especializado;
4. mantener ambigüedad;
5. solicitar más dimensión;
6. rechazar la salida como no consolidable.
```

Forma compacta:

```text
La salida no inventa forma final.
La salida se expresa mediante tokens reconocidos por el sistema.
```

---

## 11. Token complejo candidato

Cuando la red necesita expresar una estructura que no existe todavía como token consolidado, puede generar un token complejo candidato.

Pero ese token no es automáticamente válido.

```text
estructura emergente
→ token_complejo_candidato
→ prueba de coherencia
→ reutilización
→ consolidación o desaparición
```

Un token complejo candidato se consolida solo si mejora coherencia en usos posteriores.

Regla:

```text
crear no es consolidar
consolidar es demostrar utilidad coherente
```

---

## 12. Entrada parcialmente secuencial y operación asíncrona

La entrada lingüística tiene una dimensión parcialmente secuencial.

Los tokens aparecen en un orden.

Sin embargo, el procesamiento no es estrictamente secuencial.

El sistema crea múltiples ventanas operativas simultáneas:

```text
Ventana[0]
Ventana[1]
Ventana[2]
...
Ventana[n]
```

Cada ventana puede operar localmente cuando dispone de información suficiente.

Las ventanas se reequilibran entre sí a medida que aparece nueva información.

Por tanto:

```text
la entrada tiene orden
pero la resolución es distribuida
```

Forma compacta:

```text
El prompt no se procesa como una línea.
El prompt se convierte en un campo de tensores que se reequilibra hasta alcanzar coherencia global.
```

---

## 13. Ventanas operativas simultáneas

Cada ventana operativa intenta cerrar una triada de tensores:

```text
VentanaOperativa = (TF[0], TF[1], TF[2])
```

La ventana busca:

```text
E = 0-0-0
```

Si no lo consigue, genera un carry:

```text
Carry = E
```

y puede incorporar nuevos tensores del mismo ciclo o cluster.

Regla:

```text
si E ≠ 0-0-0:
    emitir Carry(E)
    añadir nuevas dimensiones del cluster
    reequilibrar ventana
```

Las ventanas no son independientes de forma absoluta.

Comparten nodos, diccionario, tensores y eventos.

Cuando una ventana mejora su coherencia, puede modificar el contexto operativo de otras ventanas.

---

## 14. Cascada de eventos

La entrada desencadena una cascada de eventos:

```text
Entrada.recibida
Token.detectado
Token.traducido
TF.creado
Ventana.actualizada
Ordenacion.actualizada
Destilacion.actualizada
Emergencia.actualizada
Carry.emitido
Cluster.actualizado
Diccionario.actualizado
Salida.propuesta
Transcender.evaluado
Salida.consolidada
```

Cada evento puede modificar dominios locales.

Cada modificación puede activar nuevas restricciones.

La solución aparece cuando la cascada se estabiliza.

Forma normativa:

```text
No hay un proceso único de inferencia.
Hay propagación de eventos hasta equilibrio.
```

---

## 15. Relación con Trigate

El Trigate proporciona el núcleo mínimo de propagación local.

Cada Trigate:

```text
reduce dominios
calcula E local
calcula F local
emite eventos si cambia el dominio o la coherencia
```

El Trigate no aprende, infiere o corrige como fases separadas.

La variable `C` orienta la relación:

```text
C = 0 → aprendizaje
C = 1 → inferencia
C = 2 → deducción
```

Pero esas tres operaciones son direcciones de la misma restricción.

Forma compacta:

```text
Aprendizaje, inferencia y deducción son orientaciones distintas de una misma relación.
```

---

## 16. Relación con Cara

La Cara transforma una Semilla Operativa en conocimiento reconstructivo:

```text
K(c) = (c.ov, c.ds, c.e)
```

Dentro de esta arquitectura:

```text
c.ov → forma de reconstruir
c.ds → espacio operativo
c.e  → desviación
```

Cuando una Cara no cierra:

```text
c.e ≠ 0-0-0
```

no se considera fallo.

Se considera una solicitud de más dimensión.

```text
c.e ≠ 0-0-0 → Carry(c.e)
```

Cuando cierra:

```text
c.e = 0-0-0
```

el conocimiento puede consolidarse y pasar al ciclo superior.

---

## 17. Relación con Transcender

El Transcender evalúa el equilibrio entre:

```text
entrada
conocimiento
salida
dirección
coherencia
coste
```

La arquitectura refactorizada interpreta sus Caras así:

```text
c1 → entrada
c2 → conocimiento emergente
c3 → salida candidata
c4 → dirección / creencia
c5 → coherencia global
c6 → coste operativo
c7 → decisión transcendente
```

El Transcender no selecciona una salida arbitraria.

Evalúa qué salida produce menor coste transcendente y mayor coherencia global.

Forma compacta:

```text
La salida candidata se acepta solo si estabiliza la relación entrada-conocimiento-salida.
```

---

## 18. Especialización natural

Los tokens y conocimientos se ordenan según se imponen en la cascada.

No se especializan por etiqueta externa primero.

Se especializan porque aparecen de forma recurrente en zonas coherentes del sistema.

Un token o tensor gana especialización cuando:

```text
se usa repetidamente en un dominio
mejora coherencia en ese dominio
es consultado por otros contextos
reduce coste en ese dominio
permite reconstrucciones estables
```

Forma compacta:

```text
La especialización no se declara.
La especialización emerge por uso coherente.
```

---

## 19. Diccionario como campo de memoria operativa

El diccionario no es solo una tabla de equivalencias.

Es el campo de memoria que condiciona la cascada.

Cada entrada del diccionario contiene:

```text
TokenEntry {
  token_id
  forma_textual
  tipo_token
  tensor_fractal
  contexto_creador
  area_especializacion
  estado_ciclo_vida
  usos_totales
  usos_exitosos
  coherencia_media
  mejora_media_F
  coste_transcendente_medio
  recompensa_acumulada
}
```

Durante la cascada, el diccionario actúa como tendencia.

Los tokens más coherentes, más recientes y más reutilizados tienden a imponerse.

Los tokens que no ayudan a cerrar coherencia pierden prioridad.

---

## 20. Desaparición natural de estructuras inútiles

Una estructura inútil no necesita ser eliminada por una decisión central.

Simplemente deja de imponerse en la cascada.

```text
no mejora E
no mejora F
no reduce coste
no aparece en salidas
no es reutilizada
no recibe recompensa
→ pierde prioridad
→ queda archivada
→ desaparece operativamente
```

Forma compacta:

```text
Lo que no ayuda a la coherencia deja de participar en la realidad operativa del sistema.
```

---

## 21. Bootstrapping refactorizado

El bootstrapping ya no se define principalmente como una sucesión lineal de fases.

Se define como una evolución de plasticidades.

### 21.1. Bootstrap 0 — Identidad inicial

```text
entrada = salida
conocimiento = todo 2
```

El sistema todavía no sabe.

Conserva la entrada y busca conocimiento.

### 21.2. Bootstrap 1 — Formación de conocimiento candidato

El tensor desconocido empieza a ser sobrescrito por estructuras que explican mejor la relación entrada-salida.

```text
2-2-2 → conocimiento candidato
```

### 21.3. Bootstrap 2 — Consolidación por cierre

Los conocimientos que permiten cerrar ventanas se consolidan.

```text
E = 0-0-0 → consolidar DS
```

### 21.4. Bootstrap 3 — Modificación de salida

Cuando el conocimiento gana estabilidad, la salida empieza a separarse de la entrada.

```text
salida inicial = entrada
salida evolucionada = reconstrucción coherente
```

### 21.5. Bootstrap 4 — Corrección de entrada

Cuando el conocimiento consolidado contradice la entrada recibida, el sistema puede marcar entrada desviada.

```text
entrada posiblemente errónea
→ reinterpretar
→ corregir si mejora coherencia global
```

### 21.6. Bootstrap 5 — Autonomía parcial

El sistema puede resolver muchos casos con diccionario, contextos especializados y tensores consolidados sin depender siempre de un LLM externo.

### 21.7. Bootstrap 6 — Red distribuida

La inteligencia operativa queda distribuida entre contextos, nodos, servicios y diccionarios compartidos.

---

## 22. Pseudocódigo conceptual dirigido por eventos

```text
on Entrada.recibida:

    T_entrada = traducirEntrada(tokens)
    T_salida = copiar(T_entrada)
    T_conocimiento = tensor_desconocido(todo_2)

    emitir EstadoInicial.creado
```

```text
on EstadoInicial.creado:

    modo = aprendizaje
    proteger(T_entrada)
    proteger(T_salida)
    flexibilizar(T_conocimiento)

    emitir Cascada.iniciada
```

```text
on Cascada.iniciada:

    activar ventanas operativas simultáneas
    activar Caras
    activar Transcender
    activar consultas al Diccionario
```

```text
on Ventana.actualizada:

    evaluar cierre E

    si E = 0-0-0:
        consolidar DS
        reforzar tensores usados
        emitir Conocimiento.mejorado

    si E ≠ 0-0-0:
        emitir Carry(E)
        solicitar más dimensión o recombinación
```

```text
on Conocimiento.mejorado:

    reducir plasticidad(T_conocimiento)
    aumentar plasticidad(T_salida)
    proponer salida reconstruida
```

```text
on Salida.propuesta:

    verificar que la salida representa token existente del Diccionario

    si no existe:
        crear token_complejo_candidato
        probar coherencia antes de consolidar

    evaluar con Transcender
```

```text
on Transcender.evaluado:

    si coste transcendente disminuye:
        reforzar configuración

    si salida estabiliza entrada-conocimiento-salida:
        emitir Salida.consolidada

    si conocimiento consolidado contradice entrada:
        emitir Entrada.posiblemente_desviada
```

```text
on Entrada.posiblemente_desviada:

    si la corrección mejora coherencia global:
        proponer reinterpretación de entrada
    si no:
        conservar entrada original
```

---

## 23. Invariantes refactorizados

1. El sistema opera de forma asíncrona y dirigida por eventos.
2. La solución emerge del equilibrio de la cascada, no de una fase central de inferencia.
3. Aprendizaje, inferencia y deducción son orientaciones de restricciones, no procesos separados.
4. El estado inicial usa `entrada = salida`.
5. El conocimiento inicial se representa como tensor desconocido formado por valores `2`.
6. El valor `2` representa apertura, no error.
7. En modo aprendizaje, la entrada y la salida inicial se preservan más que el conocimiento.
8. El tensor de conocimiento es el primer elemento plástico del sistema.
9. Cuando el conocimiento se consolida, la salida se vuelve más modificable.
10. Cuando el conocimiento es suficientemente estable, la entrada puede ser reinterpretada o corregida.
11. Toda salida consolidada debe representar un token simple o complejo existente en el diccionario.
12. Si una salida no existe como token, solo puede ser token candidato hasta demostrar utilidad coherente.
13. La entrada es parcialmente secuencial, pero la operación es distribuida y simultánea.
14. Las ventanas operativas se reequilibran con nueva información hasta que el prompt resulta coherente.
15. Las estructuras que mejoran coherencia se imponen naturalmente.
16. Las estructuras inútiles desaparecen por falta de participación coherente.
17. La especialización emerge por uso coherente repetido.
18. El diccionario actúa como memoria operativa y como campo de tendencia de la cascada.
19. El Transcender acepta una salida solo si reduce coste y estabiliza entrada-conocimiento-salida.
20. La arquitectura completa evoluciona desde identidad inicial hacia autonomía distribuida.

---

## 24. Cierre normativo

La Arquitectura Superior de Aurora refactorizada define un sistema donde la respuesta no se produce por una orden central, sino por la estabilización de una red de eventos.

El sistema comienza con:

```text
entrada = salida
conocimiento = todo 2
```

Al principio, el conocimiento es lo más plástico.

La entrada y la salida inicial se conservan.

La cascada de eventos intenta encontrar un conocimiento capaz de estabilizar la relación entre ambas.

Cuando el conocimiento empieza a solidificarse, la salida se vuelve modificable.

Cuando el conocimiento es suficientemente estable, incluso la entrada puede ser reinterpretada o corregida.

La salida final debe poder expresarse siempre como token existente del diccionario, ya sea simple, complejo o consolidado.

La entrada conserva una estructura parcialmente secuencial, pero la resolución es asíncrona: múltiples ventanas operativas se ejecutan simultáneamente, se reequilibran con nueva información y propagan eventos hasta que el prompt alcanza una coherencia suficiente.

Forma compacta final:

```text
Aurora no aprende, infiere y corrige en fases separadas.
Aurora propaga eventos.
La entrada inicia la cascada.
El conocimiento se solidifica.
La salida se reestructura.
La entrada puede ser reinterpretada.
Y la respuesta emerge cuando entrada, conocimiento y salida alcanzan equilibrio coherente dentro del diccionario.
```


---

## 12-LIcenses.md

A.	Licenses

Aurora is licensed under the Apache 2.0 and CC BY 4.0 licenses. This means that anyone is free to use, modify, and redistribute the model, provided the following conditions are met:
1.	The original copyright and license notices must be preserved in any modified or redistributed version (Apache 2.0).
2.	Credit must be given to the original project, Aurora, by clearly mentioning its origin (CC BY 4.0).
By adopting this licensing approach, we aim to ensure that Aurora remains free, open, and accessible to all. This model encourages innovation and collaboration while protecting the recognition and integrity of the project.




 
A. LICENSES  
Aurora está licenciada bajo las licencias Apache 2.0 y CC BY 4.0.
Esto significa que cualquier persona es libre de usar, modificar y redistribuir el modelo, siempre que se cumplan las siguientes condiciones:
1.	Deben mantenerse los avisos originales de copyright y de licencia en cualquier versión modificada o redistribuida (Apache 2.0).
2.	Debe otorgarse crédito al proyecto original, Aurora, mencionando claramente su procedencia (CC BY 4.0).
Al adoptar este enfoque de licenciamiento, buscamos garantizar que Aurora permanezca libre, abierta y accesible para todos. Este modelo fomenta la innovación y la colaboración, al mismo tiempo que protege el reconocimiento y la integridad del proyecto.



----

