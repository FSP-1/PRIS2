1. ¿Cuál es la principal diferencia entre una arquitectura SOA y una arquitectura de microservicios? 

2. Explique por qué el Enterprise Service Bus (ESB) puede convertirse en un riesgo crítico dentro de una arquitectura SOA. 

3. ¿Qué ventajas aporta la descentralización de datos en microservicios frente a una base de datos compartida? 

4. Defina el concepto de resiliencia en APIs REST y relacione su importancia con las falsas suposiciones sobre redes distribuidas. 

5. Explique qué es el Model Context Protocol (MCP) y cómo facilita la interacción entre LLMs y herramientas externas. 

6. Diferencie entre “Tool Use” y un servidor MCP dentro de una arquitectura basada en IA. 

7. ¿Por qué la Ingeniería Inversa es fundamental para la interoperabilidad y el análisis de malware? 

8. Compare Ingeniería Directa e Ingeniería Inversa indicando sus diferencias en el flujo de abstracción. 

9. ¿Qué papel cumple el estándar ISO 19506 (KDM) en la gobernanza de sistemas legacy? 

10. Explique cómo el derecho a la interoperabilidad limita legalmente ciertas restricciones impuestas por contratos EULA. 

11. ¿Cuál es el objetivo principal de la norma ISO/IEC 27034 en la securización de aplicaciones? 

12. Defina el concepto de ONF (Organizational Normative Framework) y explique su importancia en el ciclo de vida seguro del software. 

13. Relacione el S-SDLC con OWASP Top 10 y explique cómo contribuye a reducir vulnerabilidades críticas. 

14. Compare las herramientas SAST y DAST indicando ventajas, desventajas y complementariedad dentro de DevSecOps. 

15. Explique la filosofía “Docs as Code” y sus ventajas frente a documentación tradicional basada en Word. 

16. ¿Qué relación existe entre la mantenibilidad definida en ISO 25010 y el llamado “bus factor”? 

17. Describa cómo OpenAPI y Swagger funcionan como contrato técnico entre servicios y equipos de desarrollo. 

18. Explique cómo TDD mejora las subcaracterísticas de Testabilidad y Modificabilidad definidas en ISO/IEC 25010. 

19. ¿Por qué el uso de IA generativa en desarrollo software puede incrementar la deuda técnica si no existen mecanismos de validación? 

20. Relacione las métricas CK (como CBO o LCOM) con la mantenibilidad y calidad del software según ISO/IEC 25010. 
1. **Diferencia entre SOA y microservicios**
   SOA utiliza un bus central (ESB) para coordinar servicios y transformar datos, mientras que los microservicios eliminan esa dependencia y cada servicio funciona de forma independiente con su propia lógica y base de datos. Los microservicios usan normalmente REST/JSON o gRPC y favorecen la escalabilidad y autonomía de equipos. 

2. **Riesgo crítico del ESB en SOA**
   El ESB puede convertirse en un punto único de fallo. Si el bus central deja de funcionar, toda la organización puede quedar paralizada. Además, concentra demasiada lógica de negocio, generando acoplamiento de infraestructura. 

3. **Ventajas de la descentralización de datos**
   Cada microservicio posee su propia base de datos, lo que reduce el acoplamiento entre módulos y permite modificar servicios sin afectar al resto. También mejora la escalabilidad y la independencia tecnológica. 

4. **Resiliencia en APIs REST**
   La resiliencia consiste en diseñar APIs capaces de soportar fallos de red, latencia o cambios de infraestructura sin colapsar. Surge porque muchas veces se asume erróneamente que la red es fiable, rápida y segura, cuando realmente no lo es. 

5. **¿Qué es MCP?**
   El Model Context Protocol (MCP) es un estándar que permite que un modelo de lenguaje (LLM) interactúe con herramientas externas de forma estructurada. Gracias a MCP, un LLM puede leer información, ejecutar acciones y escribir resultados usando un protocolo común. 

6. **Tool Use vs servidor MCP**
   El Tool Use es la capacidad puntual de un LLM para utilizar herramientas concretas. Un servidor MCP, en cambio, es una infraestructura completa que organiza y estandariza la comunicación entre el modelo y múltiples herramientas externas. 

7. **Importancia de la Ingeniería Inversa**
   La Ingeniería Inversa permite analizar sistemas ya construidos para comprender su funcionamiento interno. Es clave para lograr interoperabilidad entre sistemas cerrados, recuperar software legacy y analizar malware como Stuxnet. 

8. **Ingeniería Directa vs Ingeniería Inversa**
   La Ingeniería Directa parte de requisitos y diseños abstractos para crear software. La Ingeniería Inversa hace el proceso contrario: parte de un sistema ya implementado y lo descompone para descubrir su diseño y funcionamiento. 

9. **Función de ISO 19506 (KDM)**
   ISO 19506 define un estándar para representar el conocimiento de sistemas software legacy. Facilita la gobernanza TI, el análisis de dependencias y la modernización de sistemas antiguos. 

10. **Derecho a la interoperabilidad y EULA**
    La ley permite realizar ingeniería inversa cuando es necesaria para garantizar interoperabilidad entre sistemas. Por ello, algunas restricciones impuestas por contratos EULA no pueden prevalecer sobre el derecho legal reconocido. 

11. **Objetivo de ISO/IEC 27034**
    La norma ISO/IEC 27034 busca integrar la seguridad durante todo el ciclo de vida del software, proporcionando directrices para desarrollar aplicaciones seguras desde el diseño hasta el mantenimiento. 

12. **¿Qué es ONF?**
    El Organizational Normative Framework (ONF) es un marco organizativo que reúne políticas, reglas y controles de seguridad aplicables al desarrollo software. Su función es garantizar que la seguridad se mantenga durante todo el ciclo de vida de la aplicación. 

13. **Relación entre S-SDLC y OWASP Top 10**
    El Secure Software Development Life Cycle incorpora controles de seguridad en cada fase del desarrollo. Esto ayuda a prevenir vulnerabilidades descritas en OWASP Top 10, como inyecciones SQL o fallos de autenticación. 

14. **SAST vs DAST**
    SAST analiza el código fuente de forma estática antes de ejecutar la aplicación, detectando errores tempranos. DAST analiza la aplicación en ejecución simulando ataques reales. SAST encuentra fallos internos y DAST detecta vulnerabilidades en tiempo real; ambos son complementarios en DevSecOps. 

15. **Filosofía Docs as Code**
    Docs as Code propone tratar la documentación igual que el código fuente, utilizando Git, Markdown, pull requests y CI/CD. Esto mejora la trazabilidad, automatización y colaboración frente a documentos Word tradicionales. 

16. **Mantenibilidad y bus factor**
    La mantenibilidad en ISO 25010 mide la facilidad para modificar y comprender un sistema. El “bus factor” representa el riesgo de que el conocimiento dependa de pocas personas; buena documentación y diseño reducen ese riesgo. 

17. **OpenAPI y Swagger como contrato técnico**
    OpenAPI y Swagger definen formalmente cómo funciona una API, especificando endpoints, parámetros y respuestas. Actúan como contrato técnico entre equipos, evitando inconsistencias e incompatibilidades. 

18. **Cómo TDD mejora ISO 25010**
    TDD obliga a escribir pruebas antes del código, lo que genera software más modular y desacoplado. Esto mejora la testabilidad, analizabilidad y modificabilidad definidas en ISO/IEC 25010. 

19. **IA generativa y deuda técnica**
    La IA puede generar código funcional pero difícil de entender o mantener, aumentando la carga cognitiva y la deuda técnica. Por ello, son necesarios tests, code reviews humanos y analizadores estáticos para validar calidad y mantenibilidad. 

20. **CK Metrics e ISO 25010**
    Las métricas CK permiten medir atributos internos del software. Un CBO alto implica demasiado acoplamiento y reduce la modificabilidad; un LCOM alto indica baja cohesión y dificulta la mantenibilidad según ISO/IEC 25010. 


Identifique un escenario técnico donde sea necesario aplicar el Patrón Strategy. ¿Qué beneficio aporta este patrón en términos de cumplimiento del principio Open/Closed (SOLID) frente a una estructura basada en condicionales múltiples (switch/if)? explicalo brevemente como estudiante universitario y no uses enlaces solo con tu informacion
