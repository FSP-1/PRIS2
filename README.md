# PRIS2
Ensayo
PARCIALMENTE CORRECTO
0,25/2
Calificación: 0,25 de 2 puntos posibles
Identifique un escenario técnico donde sea necesario aplicar el Patrón Strategy. ¿Qué beneficio aporta este patrón en términos de cumplimiento del principio Open/Closed (SOLID) frente a una estructura basada en condicionales múltiples (switch/if)?

Respuesta
En el escenario dado creo que lo mejor seria cuando estamos en un proyecto donde tengamos un montón de métodos que se llaman entre si, así nos aseguramos que cada método pueda llegar/mandar la información necesaria sin necesidad excesiva de funciones.

El Patrón Strategy nos ayuda ver mejor el flujo del proyecto que si usáramos una estructura en condiciones, así si incluso un equipo externo se le asignara el código del proyecto, podría empezar a trabajar en el día uno ya que no seria tan complejo de seguir/entenderlo

El escenario es el de algoritmos intercambiables. El beneficio es que se pueden añadir nuevos comportamientos sin modificar la clase original (Open/Closed), eliminando el Smell de Switch Statements.

BAJAR PUNTOS

No mencionar el principio Open/Closed o confundir el patrón con una Factory.

Pregunta 2
2
Ensayo
PARCIALMENTE CORRECTO
1,5/2
Calificación: 1,5 de 2 puntos posibles
Metodologías y Vibe Coding (IA)

Explique cómo influye el uso de herramientas de IA generativa (Vibe Coding) en la aparición de Deuda Técnica en un proyecto gestionado con Scrum. ¿Qué acciones específicas debe realizar el ingeniero de software para validar que el código generado no comprometa la mantenibilidad a largo plazo?

Respuesta
Si el Vibe Coding no se actúa como es debido en un proyecto gestionado con Scrum, provocaría una parada masiva en el backlog, ya que el equipo tendría que mover todo item con del Sprint backlog con deuda técnica al siguiente Sprint, rompiendo el tiempo programado de esos Sprint, ya que no cumpliría el principio DD (Done), donde un item se considera echo, si solo si ,pasan sus test/cobertura y cumple con los requisitos dados en el HU (Historia de usuario).

Para que esto no pase en un principio, el ingeniero debe de hacer test que presente el nivel de calidad y lo que se quiere de dicho ítem, así la ia se basaría en ellas en vez de generar código chunk o peor. También ayudan bastante aplicar técnicas de refactorización o estructuras de carpetas (MVC, MVVM..etc).

Mencionar que la IA puede generar código que "funciona" pero es dificil de entender (Carga Cognitiva). Debe proponer Code Reviews humanos y paso de Linters/analizadores estáticos.

BAJA PUNTOS:

Decir solo que "la IA se equivoca" sin hablar de mantenibilidad o deuda técnica

Pregunta 3
3
Ensayo
PARCIALMENTE CORRECTO
1/2
Calificación: 1 de 2 puntos posibles
Defina el concepto de Inmutabilidad del Contenedor dentro de una arquitectura de Despliegue Continuo (CD). ¿Por qué se considera una mala práctica realizar cambios manuales dentro de un contenedor en ejecución en el entorno de producción?

Respuesta
Por que antes de cualquier cambio a un contenedor, debe de pasar unos series de test y evaluaciones, es decir el CI (Despliegue integrado), sino uno no sabría lo que se cambia o modifica cumple con los requisitos de calidad de ese contenedor, más aun cuando esta en ejecución, eso provocaría fallos y nuestros clientes no les gastaría experimentarlos.

Por eso antes se pasa el contenedor a un CI y del CI pasa al CD, con ello se verifica que ese contenedor cumple con los test  y requisitos.

Por eso se llama Inmutabilidad del Contenedor, que no debe jamás ser cambiado cuando el contenedor esta en ejecución en entorno de producción.

Debe explicar que la inmutabilidad asegura que el contenedor sea igual en todos los entornos. Cambiar algo a mano rompe la paridad de entornos y el despliegue deja de ser predecible

BAJA PUNTOS

No mencionar la palabra "paridad de entornos" o "reproducibilidad".

Pregunta 4
4
Ensayo
PARCIALMENTE CORRECTO
1,5/2
Calificación: 1,5 de 2 puntos posibles
Relacione el indicador CBO (Acoplamiento entre Objetos) con la subcaracterística de Modificabilidad de la norma ISO 25010. ¿Qué impacto técnico tiene un CBO elevado cuando se requiere realizar un cambio en un módulo central del sistema?

Respuesta
Si en un proyecto software tenemos elevados indicadores de CBO, no nos dejaría con mucha libertad de modificación de funcionalidades/métodos, ya que significa que cada funcionalidad dependería de otra funcionalidad. Haciendo que cada vez que se necesite modificar un método o parecido, habría que cambiarlo al que hace referencia o se usa en otros métodos, aumentando significativamente el coste del mantenimiento. Cuando menos CBO tengamos mejor, significaría que en nuestro proyecto sus funcionalidades no dependen demasiado de otras funcionalidades .

Debe explicar que un CBO alto significa que las clases dependen mucho de otras. Esto reduce la Modificabilidad porque un cambio pequeño causa un "efecto dominó" (regresión).



Bajar puntos:

Confundir Acoplamiento con Cohesión.

Pregunta 5
5
Ensayo
PARCIALMENTE CORRECTO
0,75/2
Calificación: 0,75 de 2 puntos posibles
Defina técnicamente qué es una Costura (Seam) según Michael Feathers y explique su importancia en el Algoritmo de Cambio Seguro. ¿Por qué es obligatorio realizar Tests de Caracterización antes de proceder a la ruptura de dependencias en un sistema heredado?

Respuesta
Los test de Caracterización, son test que comprueban lo básico del sistema en ese momento(Tanto para lo bueno como lo malo), haciendo que cualquier modificación o agregación al método , siga haciendo su función principal. Con ello podemos refactorizar sin problemas nuestro proyecto software así pudiendo aplicar el Algoritmo de Cambio Seguro, ya que este va cambiado poco a poco el método original.

Costura: Lugar donde se puede alterar el comportamiento sin editar el código (ej. una interfaz). Tests Caract: Sirven para "congelar" el comportamiento actual y asegurar que no rompemos nada (regresión).

BAJA PUNTOS

Decir que una costura es "un comentario" o que los tests de caracterización son para buscar bugs nuevos (son para proteger lo que ya hay).
