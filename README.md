Si quieres algo parecido a Claude Tool Use encima de Open WebUI + vLLM + MCP, yo no intentaría meter toda la lógica dentro de Open WebUI.

Haría esto:

```text
Usuario
   │
   ▼
Open WebUI
   │
   ▼
Agent API (FastAPI)
   │
   ├── vLLM OpenAI API
   │
   └── MCP Server
          │
          ▼
      Microsoft Graph
```

El Agent API es quien decide:

1. preguntar al modelo
2. detectar tool_calls
3. ejecutar herramientas
4. reinyectar resultados
5. repetir hasta obtener respuesta final

Exactamente igual que hace Claude.

---

# Estructura

```text
agent/
│
├── main.py
├── agent.py
├── mcp.py
├── llm.py
├── config.py
├── requirements.txt
└── .env
```

---

# .env

```env
VLLM_URL=http://192.168.2.45:8080/v1
MODEL=qwen3.5

MCP_URL=https://mcp.partenon.medgaz.com/mcp

MCP_BEARER=xxxxxxxx
```

---

# requirements.txt

```txt
fastapi
uvicorn
httpx
python-dotenv
```

---

# config.py

```python
from dotenv import load_dotenv
import os

load_dotenv()

VLLM_URL = os.getenv("VLLM_URL")
MODEL = os.getenv("MODEL")

MCP_URL = os.getenv("MCP_URL")
MCP_BEARER = os.getenv("MCP_BEARER")
```

---

# llm.py

```python
import httpx

from config import VLLM_URL, MODEL


async def chat(messages, tools=None):

    payload = {
        "model": MODEL,
        "messages": messages,
        "temperature": 0.2,
    }

    if tools:
        payload["tools"] = tools
        payload["tool_choice"] = "auto"

    async with httpx.AsyncClient(timeout=120) as client:

        r = await client.post(
            f"{VLLM_URL}/chat/completions",
            json=payload,
        )

        r.raise_for_status()

        return r.json()
```

---

# mcp.py

```python
import httpx

from config import MCP_URL, MCP_BEARER


async def call_tool(tool_name, arguments):

    payload = {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": arguments
        }
    }

    headers = {
        "Authorization": f"Bearer {MCP_BEARER}"
    }

    async with httpx.AsyncClient(timeout=120) as client:

        r = await client.post(
            MCP_URL,
            json=payload,
            headers=headers
        )

        r.raise_for_status()

        return r.json()
```

---

# agent.py

Este es el corazón.

```python
from llm import chat
from mcp import call_tool


MAX_TOOL_LOOPS = 10


async def run_agent(user_prompt):

    messages = [
        {
            "role": "system",
            "content": """
You are an AI assistant.

When tools are available:

- ALWAYS use tools before claiming you cannot access data.
- Never invent Outlook information.
- Never say you cannot access Outlook if a tool exists.
- Use ms-365 tools whenever relevant.
"""
        },
        {
            "role": "user",
            "content": user_prompt
        }
    ]

    tools = []

    for _ in range(MAX_TOOL_LOOPS):

        response = await chat(
            messages,
            tools=tools
        )

        msg = response["choices"][0]["message"]

        tool_calls = msg.get("tool_calls")

        if not tool_calls:

            return msg["content"]

        messages.append(msg)

        for tc in tool_calls:

            name = tc["function"]["name"]

            arguments = tc["function"]["arguments"]

            result = await call_tool(
                name,
                arguments
            )

            messages.append({
                "role": "tool",
                "tool_call_id": tc["id"],
                "content": str(result)
            })

    return "Agent stopped after max tool loops."
```

---

# main.py

```python
from fastapi import FastAPI
from pydantic import BaseModel

from agent import run_agent

app = FastAPI()


class ChatRequest(BaseModel):
    prompt: str


@app.post("/chat")
async def chat_endpoint(req: ChatRequest):

    result = await run_agent(
        req.prompt
    )

    return {
        "response": result
    }
```

---

# Ejecutar

```bash
uvicorn main:app \
  --host 0.0.0.0 \
  --port 9000
```

---

# Prueba

```bash
curl http://localhost:9000/chat \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{
        "prompt":"list my Outlook folders"
      }'
```

Flujo:

```text
User
  ↓

Qwen

tool_call:
ms-365_list-mail-folders

  ↓

MCP

  ↓

Graph

  ↓

Folders JSON

  ↓

Qwen

  ↓

Final answer
```

---

Lo siguiente que yo haría en tu caso es añadir una fase de **tool repair**, porque Qwen 4B suele equivocarse en los parámetros.

Por ejemplo:

```python
if tool_name == "ms-365_list-mail-messages":

    search = args.get("$search")

    if search:

        search = search.strip("'")

        if not search.startswith('"'):
            search = f'"{search}"'

        args["$search"] = search
```

y reglas similares para Outlook, Calendar y OneDrive.

Eso acerca mucho el comportamiento a Claude: el modelo propone la llamada y el agente la corrige antes de ejecutar. Con Qwen 3.5 4B AWQ esa capa de reparación suele marcar una diferencia enorme.
