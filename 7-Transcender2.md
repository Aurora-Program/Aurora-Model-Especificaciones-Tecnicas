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
