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

## 11. Cálculo de desviación E

Para calcular `E.Rol`, la función compara la triada `DD` contra el cierre ideal del espacio `DS.Rol`.

Forma conceptual:

```text
E.Rol = desviación(DD.Rol, DS.Rol, S.Rol)
```

La implementación mínima puede usar distancia ternaria discreta:

```text
desviación = distancia(DD_normalizada, patrón_equilátero(DS,S))
```

Normalización de salida:

```text
si desviación = 0        → E.Rol = 0
si desviación es parcial → E.Rol = 1
si desviación es fuerte  → E.Rol = 2
```

El patrón equilátero no significa igualdad aritmética de los tres valores.

Significa cierre estructural de los tres vectores dentro del espacio indicado por `DS`.

Por tanto:

```text
triángulo equilátero = cierre coherente de relación
onda sinusoidal      = lectura dinámica equivalente del mismo cierre
```

La terminología geométrica o ondulatoria es secundaria.

La regla esencial es:

```text
E = 0 indica cierre.
E ≠ 0 indica que falta dimensión, contexto o salto de nivel.
```

---

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
