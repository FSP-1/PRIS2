no, ya que esto se lo estamos dando al model params system promt de open web ui, ya que este no es un agente y no sabe interpretar bien las tools calls de este servidor mcp, si fuese claude no haria falta. COn eso en mente, sabes como uno puede hacer un agente como claude para que interprete tools bien? la arquitectura es asi, un vllm server con vllm serve /home/sergio/custom-models/Qwen3.5-4B-AWQ  \
  --served-model-name qwen3.5 \
  --host 192.168.2.45 \
  --port 8080 \
  --quantization marlin \
  --gpu-memory-utilization 0.9 \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_coder \
  --max-model-len 84768 \
  --reasoning-parser qwen3 \
  --trust-remote-code \
  --max-num-batched-tokens 8192 \
  --generation-config vllm \
  --override-generation-config '{"temperature":0.2,"top_k": 20,"top_p":0.9,"repetition_penalty":1.15}' , conectado a open web ui para usar el modelo, y en open web ui se pone 
  Manage Tool Servers y el reverse proxy https://mcp.partenon.medgaz.com/mcp
  dime donde y como haria esto
  Created 5 todos

Voy a describir una arquitectura práctica y darte un prototipo mínimo (Node.js) para construir un “agent bridge” que haga lo que hace Claude: recibir salidas estructuradas del modelo (tool_call), ejecutar las herramientas reales en tu servidor MCP y devolver los resultados al modelo, todo sin exponer los JSON de planificación al usuario final.

Resumen breve de la solución
- Usa vLLM con `--tool-call-parser` (ya lo tienes) para que el modelo produzca llamadas a herramientas estructuradas.
- Construye un microservicio “agent-bridge” que:
  - recibe/consulta la salida parseada del modelo (tool_call),
  - valida y mappea la llamada al nombre del tool en endpoints.json (ej. `ms-365-*`),
  - llama al servidor MCP (`/mcp`) para ejecutar la herramienta,
  - inyecta la respuesta resumida al diálogo del modelo y continúa la generación.
- Integra ese bridge con Open Web UI como “Tool Server” (o coloca el bridge entre Open Web UI y MCP reverse proxy) para que Open Web UI no tenga que ejecutar herramientas por sí misma.

Arquitectura y flujo (alto nivel)
1. vLLM serve (qwen3.5) — ya con:
   --tool-call-parser qwen3_coder
   --enable-auto-tool-choice
   (produce tool_call estructurado en la respuesta o vía parser API)
2. Agent-bridge (Node.js/Express)
   - recibe la respuesta parseada del modelo (o consulta el endpoint de vLLM),
   - normaliza tool name (prefijo ms-365- cuando corresponda),
   - llama a `/mcp` (POST) con la invocación de herramienta (MCP protocol),
   - recibe resultado (usa excludeResponse cuando convenga),
   - envía al modelo el resultado como assistant message (resumen humano),
   - repite hasta que el modelo termine.
3. Open Web UI
   - configura “Manage Tool Servers” apuntando al agent-bridge en vez de directo a MCP,
   - o deja Open Web UI enviar prompts a vLLM y haz que el bridge consuma la misma sesión/turns (depende de integración).

Diseño de seguridad/UX
- Nunca mostrar el JSON de tool_call al usuario; el bridge ejecuta silenciosamente y presenta sólo resúmenes humanos.
- Para emails: seguir tu flujo de draft → attachments → preview → confirm → send. El bridge asegura que `ms-365-*` tools se usan y que la llamada final (`ms-365-send-draft-message`) sólo ocurre tras confirmación humana.
- Manejar attachments grandes con upload-session y resumir estado al usuario.
- Registrar audit logs (pero sin exponer bodies o tokens).

Prototipo mínimo (Node.js) — flujo simplificado
- Este ejemplo asume que vLLM te devuelve una respuesta JSON con campo `tool_call` (si usas parser) o que tienes una forma de extraerlo. El bridge hace 1) parse, 2) call MCP, 3) feed-back.

Node.js/Express pseudocódigo (conciso):

- Recibe POST /agent/generate { conversation }  
- Llama a vLLM serve generate API con conversation + system prompt  
- Si la respuesta contiene `tool_call` estructurado:
  - mapear tool name a `ms-365-...` si corresponde
  - POST a MCP `/mcp` con body: { tool: <toolName>, parameters: {...} } (usa el formato MCP que tu server espera)
  - Recibir resultado; si `excludeResponse=true` soportado, pedirlo así para respuestas pequeñas
  - Crear assistant message: "Tool result: Success — Subject 'X' ; id: abc (hidden) — presenting preview"
  - Añadir assistant message al conversation y volver a llamar a vLLM para continuar
- Si no hay tool_call, devolver la respuesta final al cliente (Open Web UI)

Puntos de implementación concretos y tips
- Uso de vLLM:
  - Mantén `--tool-call-parser` activo; verifica cómo vLLM expone el parse (respuesta JSON o SSE events). Lee logs de vllm serve para confirmar el esquema.
- Contratos:
  - Establece un mensaje de sistema (en el bridge) que diga: “If you want to run a tool, emit a single JSON object named tool_call with name and parameters. Do not print that JSON to the user.” (Complementa con tu system-prompts.md).
- Robustez:
  - Validar parámetros antes de llamar a MCP (no pasar archivos binarios sin revisión).
  - Timeouts/retries en llamadas a MCP.
- Integración con Open Web UI:
  - Open Web UI’s “Tool Server” expects a particular HTTP contract; implementar esa API en el bridge para que Open Web UI pueda listar y ejecutar tools a través del bridge (si prefieres esa integración).
  - Alternativamente, configura Open Web UI to use vLLM for chat but make the bridge the only actor that can call MCP; in Open Web UI show only messages — no raw tool JSON.
- Testing:
  - Empieza con simple calls: list drafts (ms-365-list-mail-folders → ms-365-list-mail-folder-messages) and assert agent-bridge runs them and returns human summary.
  - Añade unit tests mocking MCP responses.

¿Quieres que:
- 1) Genere el esqueleto de este agent-bridge en src (un pequeño Express app) directamente en tu repo (con llamadas concretas a `/mcp`), o
- 2) Te entregue el prototipo completo aquí para que lo copies y lo arranques localmente, o
- 3) Solo te explique cómo configurar Open Web UI para usar el bridge como Tool Server?

Dime cuál opción prefieres y lo construyo (si eliges 1 o 2, crearé los archivos y tests y actualizaré el TODOs).
