Lo que describes ya no suena a un problema de tool calling.

Suena a que **Copilot Agent está usando un prompt completamente distinto al de Open WebUI**. VS Code Agent añade herramientas, contexto del workspace, instrucciones del agente y restricciones propias antes de enviar la petición al modelo. ([Visual Studio Code][1])

Y hay una pista enorme:

> ahora hace las tools, pero responde muy breve y hace el mínimo

Eso es exactamente el comportamiento de un modelo cuando:

```text
temperature = 0
top_p bajo
prompt de agente muy restrictivo
```

o cuando el modelo está recibiendo instrucciones tipo:

```text
Use tools.
Be concise.
Do not explain.
```

que Copilot Agent suele inyectar en su flujo. ([Visual Studio Code][2])

---

### La prueba que te recomiendo

Abre los logs de Copilot:

```text
Developer: Set Log Level
→ Trace
```

y luego:

```text
GitHub Copilot Chat: Show Logs
```

o:

```text
Developer Tools
→ Network
```

para capturar exactamente qué está enviando VS Code a tu endpoint.

Quiero ver si la petición lleva algo parecido a:

```json
{
  "temperature": 0,
  "top_p": 1,
  "max_tokens": 512
}
```

o incluso un system prompt enorme.

---

### Otra cosa importante

Cuando usas Open WebUI probablemente haces:

```text
"Implementa una API REST completa..."
```

y el modelo tiene libertad.

Pero Copilot Agent funciona más así:

```text
Plan
↓
tool
↓
edit file
↓
tool
↓
stop
```

Está diseñado para hacer cambios incrementales. ([Visual Studio Code][1])

Por eso un modelo que en Open WebUI genera 300 líneas puede en Copilot decidir:

```python
def hello():
    pass
```

y parar.

---

### Mi sospecha real ahora

Después de todo lo que has contado:

* Gemma E2B + llama-server → bien.
* Llama 3.1 + vLLM → tools funcionan pero respuestas pobres.
* Open WebUI → excelente.

Yo sospecho que **el template que has puesto para que funcionen las tools está demasiado agresivo**.

Muchos templates de tool calling incluyen reglas tipo:

```text
Always use tools.
Be concise.
Only perform requested action.
```

y eso hace que el modelo deje de razonar y simplemente haga el mínimo.

---

### Qué haría yo

Mantén:

```bash
--enable-auto-tool-choice
--tool-call-parser llama3_json
```

pero modifica el template para NO incluir cosas como:

```text
Be concise
Only answer with tool calls
Keep responses short
```

y añade algo parecido a:

```text
When coding:
- Produce complete implementations
- Verify modifications
- Read relevant files before editing
- Do not stop after the first change
- Continue until the task is fully completed
```

---

### Mi apuesta

No creo que tengas un problema de:

```text
vLLM
Marlin
AWQ
RTX 5080
```

Creo que tienes un problema de:

```text
Copilot Agent Prompt
+
Tool Template
```

Porque el hecho de que Open WebUI vaya "fenomenal" demuestra que el modelo sí sabe programar. Lo que ha cambiado es el contexto y las instrucciones que recibe. Y cuando las tools empezaron a funcionar, el comportamiento pasó de "simular herramientas" a "hacer lo mínimo", lo que suele indicar que el modelo está obedeciendo demasiado estrictamente el prompt del agente.

[1]: https://code.visualstudio.com/docs/copilot/agents/overview?utm_source=chatgpt.com "Using agents in Visual Studio Code"
[2]: https://code.visualstudio.com/blogs/2025/02/24/introducing-copilot-agent-mode?utm_source=chatgpt.com "Introducing GitHub Copilot agent mode (preview)"
