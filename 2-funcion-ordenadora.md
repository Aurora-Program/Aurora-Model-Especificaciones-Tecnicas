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