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