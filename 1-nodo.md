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

