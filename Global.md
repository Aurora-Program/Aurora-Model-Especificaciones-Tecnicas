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
especial de parada: es **una Cara más**, que decide con la misma maquinaria
geométrica que cualquier otra (ordenar, destilar, medir desviación equilátera). El
control de Aurora no está cableado fuera del sistema; **emerge** como la desviación
de una Cara que resultó estar al final.

Esto es importante: no hay un "umbral" en ningún sitio. No existe un número mágico
que, al cruzarse, detenga el sistema. La decisión de parar, seguir o abandonar es
**relativa**, y se toma comparando tres rectores entre sí, no contra una constante.

---

## 8. Las dimensiones de c7

`c7` recibe como coordenadas los tres rectores del sistema, cada uno procedente de
una Cara distinta:

```text
c7.coord[0] = c4.ds   ← dirección global (¿apunta a 0-1-2?)
c7.coord[1] = c5.e    ← coherencia global (¿cierra a 0-0-0?)
c7.coord[2] = c6.ov   ← coste / OV (¿cuánto ha costado?)
```

Y produce, como cualquier Cara, su conocimiento `K(c7) = (c7.ov, c7.ds, c7.e)`:

```text
c7.ds = síntesis(c4.ds, c5.e, c6.ov)
        → el espacio formado por los tres rectores juntos.
        La decisión vive en este espacio, no en ninguno de los rectores por separado.

c7.ov = c6.ov
        → el coste se hereda y se propaga hacia arriba sin cambiar de significado.

c7.e  = Emergencia(destilar(c4.ds, c5.e, c6.ov), c7.ds)
        → la desviación del triángulo que forman los tres rectores entre sí.
        ESTO EMERGE; NO SE ASIGNA.
```

### 8.1. Por qué `c7.e` debe emerger y no copiarse

`c7.e` **no** es una copia de `c5.e`. Si lo fuera, `c7` no mediría nada nuevo: solo
reempaquetaría lo que `c5` ya dijo, y se perdería el órgano de decisión.

En toda la especificación de Aurora, `c.e` es **una salida emergente**: la
desviación que *resulta* de destilar las tres coordenadas y medir su cierre. `c7`
no es la excepción. `c5.e` ya entra en `c7` como una coordenada; no hace falta
volver a copiarla a la salida.

Lo que `c7.e` mide es:

```text
c7.e = ¿forman dirección, coherencia y coste un triángulo cerrado?

c7.e = 0-0-0  → los tres rectores están de acuerdo a la vez:
                la dirección es buena, la coherencia cierra y el coste es asumible.
c7.e ≠ 0-0-0  → algo rompe el triángulo, y la componente más desviada
                dice exactamente QUÉ rector falla.
```

Esta es la clave de por qué no hace falta umbral: **el mismo valor de `OV`
significa cosas opuestas según dónde estén los otros dos rectores**. Un `OV` alto
es tolerable si dirección y coherencia cierran; un `OV` bajo no salva nada si la
dirección está rota. `c7` nunca pregunta "¿es OV demasiado alto en absoluto?";
pregunta "¿es OV el peor de mis tres males ahora mismo?".

---

## 9. Las decisiones de c7

Cuando la cascada se detiene (todos los nodos y aristas alcanzan `E`), `c7` emite
**dos decisiones acopladas**, ambas leídas del mismo `c7.e` emergente.

### 9.1. Decisión A — calidad: ¿qué hacer con la ventana?

Se lee de la **magnitud** de `c7.e`:

```text
c7.e = 0-0-0           → A = 1  CONSOLIDAR
                         la solución es buena; emerge o crea un carry.

c7.e parcial (tiene 1) → A = 0  SEGUIR OPERANDO
                         no cierra, pero hay dirección; merece seguir.

c7.e fuerte (tiene 2)  → A = 2  ABANDONAR VENTANA
                         no converge ni merece la pena seguir intentando.
```

Esto reutiliza exactamente la lectura de `E` global del resto del sistema
(`0-0-0` cierra / contiene-1 ajusta / contiene-2 salto). No es una regla nueva.

### 9.2. Decisión B2 — rector: ¿qué se retoca?

Se lee de **cuál componente** de `c7.e` se desvía más. Tras la ordenación de la
Cara, el rol dominante (ES/FN/FO) nombra al rector responsable. Principio de
diseño: **no se toca el síntoma, se toca la raíz** — el rector diagnosticado en
`c7.coord[i]` se corrige en su Cara de origen:

```text
si domina la desviación en dirección  → retocar c4.ds
si domina la desviación en coherencia  → retocar c5.e
si domina la desviación en coste       → retocar c1.ov
```

El coste se *manifiesta* en `c6.ov`, pero *nace* en cómo se reconstruyó desde el
principio; por eso se corrige en `c1.ov` (la raíz), no en `c6.ov` (el síntoma).

### 9.3. Decisión B1 — modo: ¿aprender, inferir o reparar?

Es fijar el `C` de la siguiente cascada, y **lo dicta el mismo rector que falló**
(B2). B1 y B2 son la misma decisión leída dos veces:

```text
falla la coherencia (c5.e)  → C = 0  APRENDIZAJE
                              falta saber; busca conocimiento que cierre.

aprieta solo el coste       → C = 1  INFERENCIA
                              dirección y coherencia cierran; reconstruye con lo que hay.

falla la dirección (c4.ds)  → C = 2  REPARACIÓN DE ENTRADA
                              la entrada no apunta bien; reinterprétala.
```

El rol más desviado de `c7.e` nombra **a la vez** el rector a tocar (B2) y el modo
con que se toca (B1). Diagnóstico y tratamiento salen del mismo vector.

---

## 10. El flujo completo de c7

```text
1. La cascada se propaga sin control central (red neuronal, nivel 4).
2. Las Caras c1..c6 cierran sus dominios (CSP, nivel 2) y sus vectores
   adquieren posición (geometría, nivel 3).
3. c7 recibe los tres rectores:
       c7.coord = (c4.ds, c5.e, c6.ov)
4. c7 ordena y destila esas coordenadas como cualquier Cara.
5. c7.e emerge como desviación del triángulo equilátero de los tres rectores.
6. c7 emite dos decisiones acopladas:
       A  (magnitud de c7.e)        → consolidar / seguir / abandonar
       B1 (rol dominante de c7.e)   → C = aprendizaje / inferencia / reparación
       B2 (rol dominante de c7.e)   → corregir c4.ds / c5.e / c1.ov en su origen
7. Si A = consolidar y c7.e = 0-0-0, el sistema da la solución por buena.
   Si A = seguir, rearranca la cascada en el modo y rector diagnosticados.
   Si A = abandonar, descarta la ventana y busca otra solución.
```

```text
            c4.ds ─┐
            c5.e  ─┼──► c7 ──► c7.e (emergente) ──► A: consolidar/seguir/abandonar
            c6.ov ─┘                            └─► B1: C = 0/1/2
                                                └─► B2: corregir rector de origen
```

---

## 11. Por qué esto es mejor que un umbral

Un umbral es un escalar libre: demasiado bajo y el sistema es perezoso (desiste de
soluciones correctas pero laboriosas); demasiado alto y es obsesivo (persigue
quimeras reescribiendo la entrada entera). Sería el único hiperparámetro verdadero
del sistema, y definiría su carácter por fuera.

La decisión tri-axial de `c7` **se autocalibra por construcción**, porque:

- los tres rectores están en la misma escala ternaria y se comparan entre sí;
- la decisión es siempre **relativa** ("¿cuál de mis tres males es el peor?"),
  nunca absoluta ("¿he cruzado la línea?");
- el no determinismo del camino queda domado por un criterio único y principista:
  atacar siempre el eje más desviado.

Aurora es no determinista en el recorrido pero coherente en la regla. "Según cómo
lo pienses primero llegas a sitios distintos, pero siempre corriges lo que más
cojea."

---

## 12. Cierre normativo

```text
Trigate     es una puerta lógica reversible sobre dominios ternarios.
Cara        es un grafo de restricciones que reduce esos dominios por propagación.
Transcender es un espacio geométrico donde los dominios cerrados se leen como vectores
            y se mide su desviación respecto al triángulo equilátero.
Cluster     es una red neuronal donde muchas ventanas compiten y la coherencia emerge.

c7 es la Cara terminal que cierra el bucle:
   - recibe dirección (c4.ds), coherencia (c5.e) y coste (c6.ov);
   - su espacio c7.ds es la combinación de los tres;
   - su desviación c7.e EMERGE y diagnostica qué rector falla;
   - decide a la vez si consolidar/seguir/abandonar (A),
     en qué modo reabrir (B1: aprender/inferir/reparar),
     y qué rector corregir en su origen (B2).

No hay control externo. No hay umbral.
El control es geometría: la forma del triángulo que forman los tres rectores.
La respuesta emerge cuando dirección, coherencia y coste cierran a la vez.
```
