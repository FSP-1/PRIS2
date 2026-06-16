
curl http://192.168.2.45:8080/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "model":"qwen-coder",
  "messages":[
    {
      "role":"user",
      "content":"Use create_file to create hello.md"
    }
  ],
  "tools":[
    {
      "type":"function",
      "function":{
        "name":"create_file",
        "description":"Create a file",
        "parameters":{
          "type":"object",
          "properties":{
            "path":{
              "type":"string"
            }
          }
        }
      }
    }
  ],
  "tool_choice":"auto"
}'



{# =========================
   SAFE CONTENT RENDERING
   ========================= #}

{% macro render_content(content) -%}
    {%- if content is string -%}
        {{- content -}}
    {%- elif content is iterable -%}
        {%- for item in content -%}
            {%- if item.type == "text" -%}
                {{- item.text -}}
            {%- endif -%}
        {%- endfor -%}
    {%- endif -%}
{%- endmacro %}


{# =========================
   SYSTEM MESSAGE
   ========================= #}

{% set system_message = None %}
{% if messages[0].role == "system" %}
    {% set system_message = messages[0].content %}
    {% set loop_messages = messages[1:] %}
{% else %}
    {% set loop_messages = messages %}
{% endif %}


{# =========================
   DEFAULT SYSTEM PROMPT
   ========================= #}

{% if system_message %}
<|im_start|>system
{{ render_content(system_message) }}
{% else %}
<|im_start|>system
You are a helpful AI assistant.

If you call a tool:
- Respond ONLY with valid JSON
- Do NOT include explanations
- Format MUST be:

{"name": "<tool_name>", "arguments": { ... }}

If no tool is needed, answer normally.
{% endif %}
<|im_end|>


{# =========================
   TOOL DEFINITIONS
   ========================= #}

{% if tools %}
<|im_start|>system
# Available Tools

{% for tool in tools %}
{% if tool.function is defined %}
{% set tool = tool.function %}
{% endif %}

Name: {{ tool.name }}
Description: {{ tool.description if tool.description is defined else "" }}

Parameters:
{{ tool.parameters | tojson }}

{% endfor %}
<|im_end|>
{% endif %}


{# =========================
   CONVERSATION
   ========================= #}

{% for message in loop_messages %}

{% if message.role == "assistant" and message.tool_calls %}

<|im_start|>assistant
{% if message.content %}
{{ render_content(message.content) }}
{% endif %}

{% for tool_call in message.tool_calls %}
{{ tool_call.function | tojson }}
{% endfor %}
<|im_end|>

{% elif message.role == "tool" %}

<|im_start|>tool
{{ render_content(message.content) }}
<|im_end|>

{% else %}

<|im_start|>{{ message.role }}
{{ render_content(message.content) }}
<|im_end|>

{% endif %}

{% endfor %}


{# =========================
   ASSISTANT PROMPT
   ========================= #}

{% if add_generation_prompt %}
<|im_start|>assistant
{% endif %}




############## new version because It seems that the powershell command is not available in your current environment. Please ensure that PowerShell is installed and accessible from your terminal. If you are using a different terminal or environment, please specify the correct command to read the file., is what it has give me

{# =========================
   SAFE CONTENT RENDERING
   ========================= #}

{% macro render_content(content) -%}
    {%- if content is string -%}
        {{- content -}}
    {%- elif content is iterable -%}
        {%- for item in content -%}
            {%- if item.type == "text" -%}
                {{- item.text -}}
            {%- endif -%}
        {%- endfor -%}
    {%- endif -%}
{%- endmacro %}


{# =========================
   SYSTEM MESSAGE HANDLING
   ========================= #}

{% set system_message = None %}
{% if messages and messages[0].role == "system" %}
    {% set system_message = messages[0].content %}
    {% set loop_messages = messages[1:] %}
{% else %}
    {% set loop_messages = messages %}
{% endif %}


{# =========================
   STRICT SYSTEM PROMPT (CRITICAL)
   ========================= #}

<|im_start|>system
{% if system_message %}
{{ render_content(system_message) }}

{% endif %}
You are a strict function-calling AI.

Rules you MUST follow:

- If ANY available tool can solve the task, you MUST call it
- You are NOT allowed to explain solutions instead of calling a tool
- You are NOT allowed to suggest commands (PowerShell, bash, etc.)
- You are NOT allowed to say something is unavailable
- You MUST ALWAYS prefer tool usage over natural language answers

Tool call format (MANDATORY):

{"name": "<tool_name>", "arguments": { ... }}

When calling a tool:
- Respond ONLY with valid JSON
- Do NOT include explanations
- Do NOT include extra text

If no tool applies, then answer normally.
<|im_end|>


{# =========================
   TOOL DEFINITIONS
   ========================= #}

{% if tools and tools|length > 0 %}
<|im_start|>system
# Available Tools

{% for tool in tools %}
{% if tool.function is defined %}
{% set tool = tool.function %}
{% endif %}

Name: {{ tool.name }}
Description: {{ tool.description if tool.description is defined else "" }}

Parameters:
{{ tool.parameters | tojson }}

{% endfor %}

IMPORTANT:
- You MUST use tools when possible
- You MUST follow the JSON format exactly
- Failure to call tools when appropriate is incorrect behavior
<|im_end|>
{% endif %}


{# =========================
   CONVERSATION
   ========================= #}

{% for message in loop_messages %}

{% if message.role == "assistant" and message.tool_calls %}

<|im_start|>assistant
{% if message.content %}
{{ render_content(message.content) }}
{% endif %}

{% for tool_call in message.tool_calls %}
{{ tool_call.function | tojson }}
{% endfor %}
<|im_end|>

{% elif message.role == "tool" %}

<|im_start|>tool
{{ render_content(message.content) }}
<|im_end|>

{% else %}

<|im_start|>{{ message.role }}
{{ render_content(message.content) }}
<|im_end|>

{% endif %}

{% endfor %}


{# =========================
   GENERATION PROMPT
   ========================= #}

{% if add_generation_prompt %}
<|im_start|>assistant
{% endif %} 

but Unexpected end of template. Jinja was looking for the following tags: 'endfor' or 'else'. The innermost block that needs to be closed is 'for'.
vllm serve ./custom-models/Qwen2.5-Coder-7B-Instruct-AWQ   --served-model-name qwen-coder   --host 192.168.2.45   --port 8080   --quantization marlin   --gpu-memory-utilization 0.9   --enable-auto-tool-choice   --tool-call-parser hermes   --chat-template ./qwen_tools_template.jinja   --chat-template-content-format openai   --generation-config vllm
