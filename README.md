import json
import os
import subprocess
from pathlib import Path

from openai import OpenAI


# =========================
# CONFIG
# =========================

client = OpenAI(
    base_url="http://192.168.2.45:8000/v1",
    api_key="dummy"
)

MODEL = "qwen2.5-coder"


# =========================
# TOOLS
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
            files.append(
                os.path.join(root, name)
            )

    return {
        "files": files[:500]
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


TOOLS_SCHEMA = [
    {
        "type": "function",
        "function": {
            "name": "create_directory",
            "description": "Create a directory",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {
                        "type": "string"
                    }
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
                    "path": {
                        "type": "string"
                    },
                    "content": {
                        "type": "string"
                    }
                },
                "required": [
                    "path",
                    "content"
                ]
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
                    "path": {
                        "type": "string"
                    }
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
                    "path": {
                        "type": "string"
                    }
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
                    "command": {
                        "type": "string"
                    }
                },
                "required": ["command"]
            }
        }
    }
]


SYSTEM_PROMPT = """
You are a coding agent.

You can:

- Create directories
- Create files
- Modify files
- Read files
- Execute commands

Before modifying files inspect the project.

Continue using tools until the task is completed.
"""


def run_agent(user_prompt):

    messages = [
        {
            "role": "system",
            "content": SYSTEM_PROMPT
        },
        {
            "role": "user",
            "content": user_prompt
        }
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

        if not msg.tool_calls:

            print("\nAGENTE:")
            print(msg.content)

            return

        messages.append(msg)

        for call in msg.tool_calls:

            fn_name = call.function.name

            args = json.loads(
                call.function.arguments
            )

            print(f"\nEjecutando: {fn_name}")
            print(args)

            result = TOOLS_IMPL[fn_name](**args)

            messages.append({
                "role": "tool",
                "tool_call_id": call.id,
                "content": json.dumps(result)
            })


if __name__ == "__main__":

    while True:

        prompt = input("\nTú > ")

        if prompt.lower() in ["exit", "quit"]:
            break

        run_agent(prompt)
