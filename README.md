vllm serve ./custom-models/Qwen3-Coder-30B-A3B-Instruct-AWQ \
  --served-model-name qwen3.5 \
  --host 192.168.2.45 \
  --port 8080 \
  --quantization marlin \
  --gpu-memory-utilization 0.95 \
  --enable-auto-tool-choice \
  --tool-call-parser hermes \
  --generation-config vllm \
  --override-generation-config '{"temperature":0.1,"top_p":0.9,"repetition_penalty":1.15,"max_tokens":1024}'
