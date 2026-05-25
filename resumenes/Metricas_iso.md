Este documento es un compendio exhaustivo sobre las **Métricas de Calidad de Proyecto Software**, explicando cómo medir, interpretar y utilizar estas métricas para gestionar la calidad del código, prevenir la deuda técnica y tomar decisiones estratégicas en la ingeniería de software.

Aquí tienes un resumen estructurado de los puntos clave:

## Resumen: Métricas de Calidad de Proyecto Software

### 1. Fundamentos: ¿Por qué medir la calidad?

La medición de calidad en software es esencial para transformar el desarrollo en un proceso **controlado, repetible y gestionable**. Su objetivo no es solo cuantificar, sino **reducir la incertidumbre** en el proceso de desarrollo, permitiendo a los ingenieros tomar decisiones basadas en evidencia. Las métricas permiten evaluar atributos como la complejidad, la mantenibilidad y el acoplamiento, proporcionando una visión objetiva del sistema.

### 2. El Marco Teórico: Modelo ISO/IEC 25010

El modelo **ISO/IEC 25010** proporciona el marco conceptual para la calidad del software, definiendo características como **Mantenibilidad, Fiabilidad, Eficiencia, Seguridad y Usabilidad**. Las métricas de software actúan como el puente que traduce estos conceptos abstractos de calidad en propiedades observables y cuantificables del código.

### 3. Clasificación de las Métricas

Las métricas se clasifican según el aspecto del sistema que analizan:

* **Métricas de Diseño:** Evalúan la estructura interna, el acoplamiento y la cohesión (ej. las **CK Metrics**).
* **Métricas de Complejidad:** Miden la dificultad lógica del código (ej. Complejidad Ciclomática).
* **Métricas de Tamaño:** Cuantifican el volumen del código (ej. Líneas de Código (LOC) y Puntos de Función (FP)).

**Importancia de la Combinación:** Ninguna métrica es suficiente. La calidad real se revela al **combinar** métricas de diseño, complejidad y tamaño para obtener una visión multidimensional del sistema.

### 4. Métricas Clave y su Interpretación

#### A. Métricas de Diseño (CK Metrics)

Evalúan la estructura de clases en Programación Orientada a Objetos (POO) para detectar "smells" (olores de diseño):

* **WMC (Weighted Methods per Class):** Mide la complejidad de los métodos dentro de una clase. Un valor alto indica una clase demasiado grande o con demasiadas responsabilidades (violación del SRP).
* **DIT (Depth of Inheritance Tree):** Mide la profundidad de la herencia, indicando el grado de reutilización y la complejidad cognitiva de la jerarquía.
* **CBO (Coupling Between Objects):** Mide el nivel de interdependencia entre clases. Un alto CBO indica un sistema rígido y frágil, con alto riesgo de efectos colaterales.
* **LCOM (Lack of Cohesion of Methods):** Mide la cohesión interna de una clase. Una baja cohesión significa que la clase tiene múltiples responsabilidades, lo que dificulta la mantenibilidad.

#### B. Métricas de Complejidad

Miden la dificultad lógica del código:

* **Complejidad Ciclomática (McCabe):** Cuantifica el número de caminos de ejecución independientes en un módulo. Un valor alto (ej. > 20) señala un **código de riesgo crítico** que es difícil de testear y de entender.
* **Carga Cognitiva (Complejidad Percibida):** Mide el esfuerzo mental que el desarrollador necesita para comprender el código, enfocándose en el anidamiento profundo y la falta de abstracciones.

#### C. Métricas de Tamaño

* **LOC (Líneas de Código):** Mide la cantidad de código. Aunque útil para la estimación, es **limitada** para evaluar la calidad, ya que no considera la eficiencia ni la complejidad intrínseca.
* **Puntos de Función (FP):** Miden la funcionalidad entregada al usuario. Son valiosos para estimar el esfuerzo de desarrollo y medir el valor de negocio, pero no miden la calidad interna del código.

### 5. Deuda Técnica y el Impacto Económico

Las métricas son la herramienta clave para **cuantificar la Deuda Técnica**.

* **El Triángulo de la Deuda Crítica:** La acumulación de **Alta Complejidad**, **Alto Acoplamiento** y **Baja Cohesión** genera una deuda técnica peligrosa.
* **Coste de Mantenimiento:** La combinación de estas métricas predice directamente el **alto coste de mantenimiento** (60-80% del coste total del proyecto), ya que hace que los cambios sean lentos, caros y arriesgados.
* **ROI Positivo:** La inversión en refactorización (reducir complejidad, acoplamiento y mejorar la cohesión) genera un **ROI positivo** al disminuir el tiempo de Time-to-Market (TTM), reducir los costos de *bug fixing* y mejorar la moral del equipo.

### 6. Gobernanza y Control Continuo

La efectividad de las métricas depende de su integración en la gobernanza del proyecto:

* **Dashboards de Calidad:** Herramientas visuales que agregan las métricas (complejidad, cobertura de pruebas, duplicación) para ofrecer una visión en tiempo real del estado de salud del sistema.
* **Quality Gates (Puertas de Calidad):** Mecanismos obligatorios dentro del ciclo CI/CD que **bloquean** el despliegue de código si no cumple con umbrales mínimos de calidad (ej. Complejidad Ciclomática $\le 15$ o Cobertura de Pruebas $\ge 80\%$).
* **Control Continuo:** La evaluación de la calidad debe ser un proceso constante, detectando y corrigiendo problemas en tiempo real (en cada *commit*) para prevenir la acumulación de defectos.

### Conclusión Estratégica

Las métricas de calidad son el puente entre la **tecnología y el negocio**. Permiten a las organizaciones pasar de una gestión reactiva de la calidad a una **disciplina proactiva y basada en evidencia**. Al utilizar estas métricas, las empresas pueden identificar las zonas críticas (hotspots), priorizar la refactorización de manera estratégica y asegurar la sostenibilidad y competitividad del software a largo plazo.
