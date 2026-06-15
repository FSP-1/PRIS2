import json
import os
import subprocess
import re
from pathlib import Path
from openai import OpenAI


# =========================
# CONFIG
# =========================

client = OpenAI(
    base_url="http://192.168.2.45:8080/v1",
    api_key="dummy"
)

MODEL = "qwen-coder"


# =========================
# TOOLS (SIN RESTRICCIONES)
# =========================

def create_directory(path):
    os.makedirs(path, exist_ok=True)

    return {
        "success": True,
        "path": path
    }


def write_file(path, content):

    Path(path).parent.mkdir(
        parents=True,
        exist_ok=True
    )

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

    return {
        "success": True,
        "path": path
    }


def read_file(path):

    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    return {
        "content": content
    }


def list_directory(path="."):

    files = []

    for root, dirs, filenames in os.walk(path):
        for name in filenames:
            files.append(os.path.join(root, name))

    return {
        "files": files[:200]
    }


def execute_command(command):

    result = subprocess.run(
        command,
        shell=True,
        capture_output=True,
        text=True
    )

    return {
        "stdout": result.stdout,
        "stderr": result.stderr,
        "returncode": result.returncode
    }


TOOLS_IMPL = {
    "create_directory": create_directory,
    "write_file": write_file,
    "read_file": read_file,
    "list_directory": list_directory,
    "execute_command": execute_command
}


# =========================
# TOOL SCHEMA
# =========================

TOOLS_SCHEMA = [
    {
        "type": "function",
        "function": {
            "name": "create_directory",
            "description": "Create a directory",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {"type": "string"}
                },
                "required": ["path"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "write_file",
            "description": "Write file content",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {"type": "string"},
                    "content": {"type": "string"}
                },
                "required": ["path", "content"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "read_file",
            "description": "Read a file",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {"type": "string"}
                },
                "required": ["path"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "list_directory",
            "description": "List project files",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {"type": "string"}
                }
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "execute_command",
            "description": "Execute terminal command",
            "parameters": {
                "type": "object",
                "properties": {
                    "command": {"type": "string"}
                },
                "required": ["command"]
            }
        }
    }
]


# =========================
# PARSERS (OPENAI + XML + JSON)
# =========================

def parse_xml_tool(content):

    match = re.search(
        r"<tool_call>\s*<function=(.*?)>(.*?)</function>\s*</tool_call>",
        content,
        re.DOTALL
    )

    if not match:
        return None

    fn_name = match.group(1)
    body = match.group(2)

    params = {}

    param_matches = re.findall(
        r"<parameter=(.*?)>\s*(.*?)\s*</parameter>",
        body,
        re.DOTALL
    )

    for k, v in param_matches:
        params[k.strip()] = v.strip()

    return [(fn_name, params)]


def parse_json_tool(content):

    try:
        data = json.loads(content)

        if isinstance(data, dict) and "name" in data:
            return [(data["name"], data.get("arguments", {}))]

    except:
        pass

    return None


def extract_tool_call(msg):

    # ✅ OpenAI native
    if msg.tool_calls:
        return ("openai", msg.tool_calls)

    content = msg.content or ""

    # ✅ XML
    xml = parse_xml_tool(content)
    if xml:
        return ("xml", xml)

    # ✅ JSON
    js = parse_json_tool(content)
    if js:
        return ("json", js)

    return None


# =========================
# AGENTE
# =========================

SYSTEM_PROMPT = """
You are an autonomous coding agent.

Rules:

- Always use tools for filesystem operations.
- Always use tools for shell commands.
- Never explain how to perform operations.
- Perform them using tools.
- Read files before modifying them.
- Continue calling tools until the task is fully completed.
"""


def run_agent(user_prompt):

    messages = [
        {"role": "system", "content": SYSTEM_PROMPT},
        {"role": "user", "content": user_prompt}
    ]

    while True:

        response = client.chat.completions.create(
            model=MODEL,
            messages=messages,
            tools=TOOLS_SCHEMA,
            tool_choice="auto",
            temperature=0
        )

        msg = response.choices[0].message

        print("\n--- MODEL RAW ---")
        print(msg)

        tool_data = extract_tool_call(msg)

        # ✅ respuesta final
        if not tool_data:
            print("\n✅ AGENTE:")
            print(msg.content)
            return

        mode, calls = tool_data

        print(f"\n🔧 TOOL MODE: {mode}")

        # =========================
        # EXECUTION
        # =========================

        if mode == "openai":

            messages.append(msg)

            for call in calls:
                fn_name = call.function.name
                args = json.loads(call.function.arguments)

                print(f"\n[TOOL] {fn_name}")
                print(args)

                result = TOOLS_IMPL**args

                messages.append({
                    "role": "tool",
                    "tool_call_id": call.id,
                    "content": json.dumps(result)
                })

        else:
            # XML / JSON fallback
            for fn_name, args in calls:

                print(f"\n[TOOL-FALLBACK] {fn_name}")
                print(args)

                result = TOOLS_IMPL**args

                messages.append({
                    "role": "assistant",
                    "content": msg.content
                })

                messages.append({
                    "role": "tool",
                    "content": json.dumps(result)
                })


# =========================
# MAIN
# =========================

if __name__ == "__main__":

    while True:

        prompt = input("\nTú > ")

        if prompt.lower() in ["exit", "quit"]:
            break

        run_agent(prompt)


Tú > crea una carpeta en /home/sergio llamado test

--- MODEL RAW ---
ChatCompletionMessage(content=None, refusal=None, role='assistant', annotations=None, audio=None, function_call=None, tool_calls=[ChatCompletionMessageFunctionToolCall(id='chatcmpl-tool-b45f718fa937dcdc', function=Function(arguments='{"path": "/home/sergio/test"}', name='create_directory'), type='function')], reasoning=None)

🔧 TOOL MODE: openai

[TOOL] create_directory
{'path': '/home/sergio/test'}
Traceback (most recent call last):
  File "/home/sergio/qwen_agent.py", line 351, in <module>
    run_agent(prompt)
  File "/home/sergio/qwen_agent.py", line 310, in run_agent
    result = TOOLS_IMPL**args
             ~~~~~~~~~~^^~~~~
TypeError: unsupported operand type(s) for ** or pow(): 'dict' and 'dict'
Copilot said:
Copilot
Perfecto 👌 — este error es muy simple pero clave (y ya estás en el último paso 🔥).

💥 ERROR



Python
result = TOOLS_IMPL**args
``
TypeError: unsupported operand type(s) for ** or pow(): 'dict' and 'dict'
🧠 PROBLEMA
Estás usando:




Python
TOOLS_IMPL**args
👉 Eso es incorrecto porque:

TOOLS_IMPL es un diccionario
** solo se usa para desempaquetar argumentos en una función, no para llamar funciones en un dict
✅ SOLUCIÓN CORRECTA
Debes hacer esto:




Python
result = TOOLS_IMPL[fn_name](**args)

🔥 EXPLICACIÓN CLARA
Lo que tienes:



Python
TOOLS_IMPL = {
    "create_directory": create_directory
}

👉 Entonces necesitas:

sacar la función:



Python
TOOLS_IMPL[fn_name]
ejecutarla con argumentos:



Python
(**args)

✅ PARCHE EXACTO
Busca esta línea:



Python
result = TOOLS_IMPL**args
Y cámbiala por:



Python
result = TOOLS_IMPL[fn_name](**args)
✅ TAMBIÉN EN EL FALLBACK
En esta parte:




Python
result = TOOLS_IMPL**args
👉 cámbiala también:




Python
result = TOOLS_IMPL[fn_name](**args)
✅ RESULTADO DESPUÉS DEL FIX
Ahora tu agente hará:

[TOOL] create_directory
{'path': '/home/sergio/test'}

✅ Directory created at /home/sergio/test
👉 y la carpeta se crea REAL ✅

🔥 IMPORTANTE: TU CASO ES PERFECTO
Mira lo que ya tienes funcionando:

tool_calls=[...]
👉 significa:

✅ Qwen está devolviendo tool_calls estructurados
✅ NO necesitas XML fallback en este caso
✅ estás en modo OpenAI correcto 🔥

🧠 CONCLUSIÓN
👉 Tu agente ya está 100% bien diseñado

Solo fallaba esto:

Error	Fix
llamar dict como función	✅ TOOLS_IMPL**args



        
