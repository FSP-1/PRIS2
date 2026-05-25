Este documento es un análisis integral sobre la **Seguridad de Aplicaciones**, abordando la necesidad de integrar la seguridad en todo el ciclo de vida del desarrollo de software, utilizando marcos normativos, metodologías y herramientas técnicas.

A continuación, se presenta un resumen de los puntos clave:

### 1. Conceptos Fundamentales

**Seguridad Proactiva:** La seguridad no debe ser una revisión final, sino una responsabilidad que se integra desde el inicio del desarrollo (filosofía **DevSecOps**), buscando detectar y corregir vulnerabilidades lo antes posible para reducir costes y riesgos.

**ISO/IEC 27034:** Es un estándar internacional que proporciona orientación para integrar la seguridad en los procesos de gestión de aplicaciones. Su objetivo es asegurar que las aplicaciones ofrezcan el nivel deseado de seguridad, independientemente del método de desarrollo utilizado.

**ONF (Organizational Normative Framework):** Es el marco de seguridad de la organización. Es una colección estructurada de políticas, normas, tecnologías y requisitos que personaliza las prácticas de seguridad para que sean relevantes al contexto específico de cada aplicación.

### 2. El Ciclo de Vida de Desarrollo Seguro (SDLC)

El enfoque central es el **SDLC Seguro**, que consiste en añadir controles de seguridad en cada fase del ciclo de vida tradicional:

* **Fase 1: Requisitos:** Definir requisitos de seguridad claros, concretos y verificables (autenticación, autorización, cifrado).
* **Fase 2: Diseño:** Pensar como atacante (modelado de amenazas) para diseñar una arquitectura segura y evitar fallos de diseño.
* **Fase 3: Implementación/Coding:** Aplicar buenas prácticas de codificación segura, asegurando que la seguridad esté presente en cada decisión de código.
* **Fase 4: Testing/Verificación:** Demostrar que los controles funcionan, utilizando análisis de código (SAST) y pruebas dinámicas (DAST).

### 3. Referencias Clave

**OWASP Top 10 (Edición 2025):** Es la guía esencial que lista las diez categorías de riesgos más críticas para las aplicaciones web. La edición 2025 pone un énfasis mayor en las **causas raíz** de las vulnerabilidades.

**Categorías Críticas (Ejemplos):**

* **A05: Inyección:** Manejo inseguro de datos que lleva a ataques como SQL Injection y XSS.
* **A03: Fallos de Cadena de Suministro de Software:** Riesgos en dependencias de terceros y procesos de construcción.
* **A06: Diseño Inseguro (Insecure Design):** Fallos arquitectónicos que requieren un rediseño, no solo un parche.
* **A10: Manejo Deficiente de Condiciones Excepcionales:** Fallos en el manejo de errores (ej. *failing open*).

### 4. Herramientas Técnicas (DevSecOps)

Para implementar el enfoque DevSecOps, se utilizan dos tipos principales de pruebas que operan en distintas etapas:

**A. SAST (Static Application Security Testing):**

* **Función:** Analiza el **código fuente** (pruebas de caja blanca) antes de la ejecución.
* **Ventaja:** Detecta vulnerabilidades tempranamente en el entorno de desarrollo o en el *pipeline* de CI/CD.
* **Ejemplos:** SonarQube, Semgrep, Checkmarx.

**B. DAST (Dynamic Application Security Testing):**

* **Función:** Analiza la **aplicación en tiempo de ejecución** (pruebas de caja negra), actuando como un atacante externo.
* **Ventaja:** Encuentra problemas que surgen cuando la aplicación está funcionando.
* **Ejemplos:** OWASP ZAP, Burp Suite, Nikto.

**Complementariedad:** La mejor práctica es usar ambas herramientas en conjunto: **SAST** para revisar el código y **DAST** para validar la aplicación desplegada.

### Conclusión

La seguridad de aplicaciones requiere un enfoque holístico que combine **marcos normativos (ISO 27034)**, una **metodología estructurada (SDLC Seguro)** y la **aplicación técnica automatizada (DevSecOps con SAST/DAST)**. Esto transforma la seguridad de una tarea final a una práctica continua e integrada en el flujo de desarrollo.
