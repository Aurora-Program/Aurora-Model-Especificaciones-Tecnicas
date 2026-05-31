# Aurora — El operador del vórtice

# Aurora — El operador del vórtice

## 1. Punto de partida

El vórtice es la interacción simultánea de cuatro objetos:

```
S   onda ascendente     síntesis de coherencia nivel a nivel
C   onda descendente    orientación del eje activo
Δ   tensión             vector de diferenciales (Δdir, Δcoh, Δcoste)
D   diccionario         campo de memoria operativa
```

Buscamos un operador `V` tal que:

```
V : (S, C, Δ, D)  →  (C′, Δ′, D′)
```

donde `C′` es el eje actualizado, `Δ′` es la tensión actualizada,
y `D′` es el diccionario actualizado.

---

## 2. Estructura del operador

El vórtice no es lineal. No es secuencial. No es un pipeline.

Es un operador de acoplamiento simultáneo:

```
V = A ⊛ O
```

donde:

```
A  =  onda ascendente (síntesis)
O  =  onda descendente (orientación)
⊛  =  acoplamiento simultáneo (no conmutativo)
```

La no conmutatividad es esencial:

```
A(O(x)) ≠ O(A(x))
```

La síntesis que sube depende de cómo orientó la cascada que bajó.
La orientación que baja depende de la tensión que sintetizó la onda que subió.
No hay orden correcto porque ocurren a la vez.

---

## 3. Las dos funciones internas

### 3.1. ϕ — función de reducción de tensión

`ϕ(S, C)` mide cuánto reduce la tensión la interacción entre síntesis y orientación.

La síntesis ascendente produce, en cada nivel `k`, un estado `Eₖ`:

```
E₀  =  estados locales de los nodos
E₁  =  E de los Trigates        (cierre de dominio)
E₂  =  E de las Caras           (desviación geométrica)
E₃  =  E del Transcender        (rectores c4.ds, c5.e, c6.ov)
```

Cada `Eₖ` se mide con la misma métrica que usa el resto del sistema —
distancia Manhattan al ideal de su nivel:

```
‖Eₖ‖  =  DM(Eₖ, ideal_k)  =  Σ |Eₖᵢ − idealₖᵢ|
```

La síntesis total es contractiva en norma pero expansiva en cualidad:

```
S  =  σ(E₀, E₁, E₂, E₃)      con  ‖S‖ < ‖E₀, E₁, E₂, E₃‖
```

La reducción de tensión que produce una interacción `(S, C)` es:

```
ϕ(S, C)  =  Δ · (1 − δ(S, C))
```

donde `δ(S, C) ∈ [0,1]` mide cuánto se desvía la síntesis del ideal
del eje actual `C`. Cuando la síntesis cierra perfectamente bajo la
orientación activa:

```
δ(S, C) = 0   →   ϕ(S, C) = Δ   →   Δ′ = 0   (colapso)
```

Cuando la síntesis no converge en absoluto:

```
δ(S, C) = 1   →   ϕ(S, C) = 0   →   Δ′ = Δ   (tensión invariante)
```

En la práctica, `δ` se calcula directamente desde los tres diferenciales
que ya produce `c7`:

```
δ_dir   =  DM(c4.ds, 0-1-2) / 6       (normalizado al rango ternario)
δ_coh   =  DM(c5.e,  0-0-0) / 6
δ_coste =  nivel(c6.ov) / nivel_max
```

Y el vector de reducción por eje es:

```
ϕ(S, C) = (Δdir · (1−δ_dir),  Δcoh · (1−δ_coh),  Δcoste · (1−δ_coste))
```

No hay parámetro libre. `ϕ` está completamente determinada por los mismos
valores que `c7` ya calcula.

### 3.2. ψ — función de cambio de eje

`ψ(Δ)` determina el nuevo eje cuando el vórtice ensancha. Es quirúrgica:
solo toca el rector más desviado.

```
ψ(Δ) = {
  corregir c1.ov   si Δcoste = max(Δdir, Δcoh, Δcoste)
  corregir c4.ds   si Δdir   = max(Δdir, Δcoh, Δcoste)
  corregir c5.e    si Δcoh   = max(Δdir, Δcoh, Δcoste)
}
```

El coste se manifiesta en `c6.ov` pero nace en `c1.ov`. Por eso `ψ`
ataca la raíz, no el síntoma.

`ψ` no tiene parámetros libres. Dado `Δ`, el resultado es determinista.

---

## 4. El invariante ternario

El estado `c7.f ∈ {0, 1, 2}` es una variable ternaria como cualquier
otra del sistema. Define tres indicadores mutuamente excluyentes:

```
f₁ = 1  si c7.f = 1,  0 si no    (vórtice estrecha)
f₂ = 1  si c7.f = 2,  0 si no    (vórtice ensancha)
f₀ = 1  si c7.f = 0,  0 si no    (vórtice oscila)
```

Con el invariante:

```
f₀ + f₁ + f₂ = 1      f_i ∈ {0,1}
```

Exactamente uno está activo en cada evaluación de `V`. No hay estado
intermedio ni superposición. Esto no es una elección de diseño — es
consecuencia de que Aurora es ternaria en todos sus niveles.

---

## 5. El operador completo

Reuniendo las piezas, la forma compacta del operador del vórtice es:

```
V(S, C, Δ, D) = (
    C  +  f₂ · ψ(Δ),
    Δ  −  f₁ · ϕ(S,C),
    D  +  f₀ · t
)
```

Interpretación línea a línea:

```
C + f₂·ψ(Δ)     si f₂=1 el eje cambia quirúrgicamente
                 si f₂=0 el eje se conserva

Δ − f₁·ϕ(S,C)   si f₁=1 la tensión se reduce por la síntesis activa
                 si f₁=0 la tensión se conserva

D + f₀·t         si f₀=0 el diccionario no se toca en este ciclo
                 si f₀=1 el sistema señala apertura: necesita token externo t
```

Los tres términos actúan sobre tres objetos distintos. En cada ciclo
solo uno de los tres cambia. Eso es lo que hace al operador ternario
en el mismo sentido que el resto del sistema.

---

## 6. El colapso como condición geométrica

El vórtice colapsa cuando la tensión desaparece y el sistema está convergiendo:

```
colapso  =  (‖Δ‖ < ε)  ∧  (c7.f = 1 sostenido)
```

En ese momento `f₁ = 1` repetidamente, `ϕ(S,C)` ha reducido `Δ` a cero,
y el diccionario se actualiza con el resultado:

```
D′ = actualizar(D, S, C)
```

Los tokens que participaron en el colapso acumulan coherencia. Los que
no participaron la pierden. El diccionario queda orientado para el siguiente
vórtice.

---

## 7. El token externo como perturbación del campo

Cuando `f₀ = 1` sostenido, el operador produce:

```
V(S, C, Δ, D) = (C,  Δ,  D + t)
```

`C` y `Δ` no cambian. Solo el diccionario se abre. El token `t` entra
por el mismo mecanismo que cualquier otro conocimiento — no por un canal
privilegiado. Una vez en `D`, modifica las prioridades de propagación de la
próxima cascada y permite que `c7.f` salga de 0.

```
t ∈ D′  →  próxima cascada tiene diferente textura
        →  c7.f sale de 0
        →  f₀ = 0 en el siguiente ciclo
        →  V vuelve a actuar sobre C o Δ
```

---

## 8. Propiedades del operador

**Es autosimilar.** La misma estructura ternaria que gobierna el Trigate
(tres modos, uno activo, misma métrica) reaparece en `V`. No es coincidencia:
es consecuencia de que Aurora es ternaria en todos sus niveles.

**Es no lineal.** `ϕ(S,C)` depende del producto de síntesis y orientación.
`ψ(Δ)` depende del máximo de un vector. Ninguna de las dos es lineal.

**Es no conmutativo.** `A ⊛ O ≠ O ⊛ A` por construcción.

**No tiene parámetros libres.** `ϕ` y `ψ` están completamente determinadas
por las métricas que el sistema ya usa (distancia Manhattan, nivel de coste,
máximo del vector de diferenciales). No hay umbral, no hay constante externa.

**Es geométrico.** El colapso es una condición de cierre geométrico
(`‖Δ‖ < ε`), no una regla programada. La misma lógica que hace cerrar
un Trigate hace colapsar un vórtice.

**Es implementable.** Cada término del operador corresponde a una operación
ya definida en los componentes existentes. `ϕ` usa los `Δ` que `c7` ya
calcula. `ψ` usa la tabla de B2 que ya existe. `f₀, f₁, f₂` son una
lectura directa de `c7.f`.

---

## 9. Cierre normativo

```
El operador del vórtice es:

    V(S, C, Δ, D) = (C + f₂·ψ(Δ),  Δ − f₁·ϕ(S,C),  D + f₀·t)

    con  f₀ + f₁ + f₂ = 1,   f_i ∈ {0,1}

ϕ(S,C) = vector de reducción de tensión por eje,
          determinado por los diferenciales de c7.

ψ(Δ)   = corrección quirúrgica del rector más desviado,
          determinada por el máximo de Δ.

t      = token externo que entra en D cuando f₀=1.

El operador es ternario porque Aurora es ternaria.
Es no conmutativo porque síntesis y orientación se acoplan simultáneamente.
No tiene parámetros libres porque usa las métricas del propio sistema.

El colapso ocurre cuando ‖Δ‖ → 0 con c7.f = 1 sostenido.
El colapso actualiza D y orienta el siguiente vórtice.

La serie de colapsos es el aprendizaje.
El diccionario resultante es el carácter del sistema.
```