Perfecto 👌 este agente que has puesto es MUCHO mejor estructurado que el anterior que hicimos — de hecho ya está en el modelo correcto estilo OpenAI agent 🔥
Te explico:

🧠 ✅ QUÉ HACE ESTE AGENTE (BIEN HECHO)
Este ya es un agent loop estándar real, igual que OpenAI:
✅ Flujo

Envías prompt
Modelo responde:

con texto → fin ✅
con tool_calls → ejecuta ✅


Ejecutas la función real
Devuelves resultado al modelo
Loop continúa 🔁


💥 PERO hay un detalle clave en TU caso
👉 esto SOLO funciona si:
msg.tool_calls != None ✅


⚠️ Problema real con Qwen2.5
Qwen 2.5 normalmente:
❌ NO devuelve tool_calls estructurados
✅ devuelve texto/XML/JSON
👉 por eso antes estabas usando XML parsing

🔥 ENTONCES ESTE AGENTE… ¿FUNCIONA?
✅ Con estos modelos:

Llama 3.1 FP16 ✅
Hermes ✅
Mistral con template ✅

👉 funciona PERFECTO

❌ Con Qwen2.5 AWQ
👉 pasa esto:
msg.tool_calls = None ❌
msg.content = texto ❌

💥 el agente nunca ejecuta tools

✅ SOLUCIÓN PARA HACERLO FUNCIONAR CON QWEN
Tienes 2 caminos:

🥇 OPCIÓN A — Mantener este código (recomendado)
👉 pero añadir fallback XML (lo que hicimos antes)

🔧 Añade esto después de:
Pythonmsg = response.choices[0].messageShow more lines

✅ PATCH (CLAVE)
Python# 🔥 fallback cuando Qwen no usa tool_callsif not msg.tool_calls and msg.content:    import re    match = re.search(        r"<tool_call>\s*<function=(.*?)>(.*?)</function>\s*</tool_call>",        msg.content,        re.DOTALL    )    if match:        function_name = match.group(1)        body = match.group(2)        params = {}        param_matches = re.findall(            r"<parameter=(.*?)>\s*(.*?)\s*</parameter>",            body,            re.DOTALL        )        for name, value in param_matches:            params[name.strip()] = value.strip()        print(f"\n[XML TOOL DETECTADO] {function_name}")        print(params)        result = TOOLS_IMPL[function_name](**params)        messages.append({            "role": "assistant",            "content": msg.content        })        messages.append({            "role": "tool",            "content": json.dumps(result)        })        continueShow less

✅ Resultado
Ahora tu agente soporta:




TipoFuncionatool_calls OpenAI✅XML (Qwen)✅texto normal✅
💥 hybrid agent (lo mejor posible en local)

🥇 OPCIÓN B — Cambiar a modelo compatible
Si usas:
Llama-3.1-8B-Instruct (FP16)

👉 NO necesitas XML
👉 este código funciona sin tocar nada

🔥 MEJORA MUY IMPORTANTE (te recomiendo hacerlo)
Añade forcing al system prompt:

🔧 CAMBIA esto:
PythonSYSTEM_PROMPT = """You are a coding agent...."""Show more lines

✅ por esto:
PythonSYSTEM_PROMPT = """You are a coding agent.RULES:- You MUST use tools for any filesystem or command task- Do NOT explain how to do things manually- Always call tools until the task is completed- Never answer with steps if a tool is availableYou can:- Create directories- Create files- Modify files- Read files- Execute commands"""Show more lines

✅ RESULTADO FINAL
Con ese agente + fix tendrás:
✅ loop real
✅ ejecución automática
✅ compatible con Qwen
✅ fallback robusto
✅ comportamiento tipo Copilot agent

🧠 CONCLUSIÓN
Tu código ya es:
👉 ✅ arquitectura correcta
👉 ❌ faltaba compatibilidad con Qwen
