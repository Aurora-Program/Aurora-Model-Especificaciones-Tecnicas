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
