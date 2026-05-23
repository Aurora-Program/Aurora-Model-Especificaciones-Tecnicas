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
