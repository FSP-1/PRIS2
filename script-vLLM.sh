#!/bin/bash

# Check if Nouveau driver is loaded and blacklist it if present
lsmod | grep nouveau

# Edit blacklist configuration to disable Nouveau GPU support
nano /etc/modprobe.d/blacklist-nouveau.conf
# Add the following content:
"""
blacklist nouveau
options nouveau modeset=0
"""

# Reebot VM
# Verify Nouveau is unloaded
lsmod | grep nouveau

# Install NVIDIA drivers and CUDA toolkit
sudo apt install build-essential dkms
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-cuda-toolkit

# Reebot VM

# Install uv package manager and activate it
apt install curl
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

# Create virtual environment with Python 3.12
uv venv --python 3.12 --seed --managed-python
source .venv/bin/activate

# Install Hugging Face CLI and vLLM
pip install huggingface_hub[cli]
uv pip install vllm --torch-backend=auto

# Install evaluation suite
pip install lm_eval

# Download Qwen3.5-4B-AWQ quantized model
hf download QuantTrio/Qwen3.5-4B-AWQ --local-dir ./custom-models/Qwen3.5-4B-AWQ

# Test vLLM service configuration
vllm serve /home/sergio/custom-models/Qwen3.5-4B-AWQ  \
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
  --override-generation-config '{"temperature":0.2,"top_k": 20,"top_p":0.9,"repetition_penalty":1.15}'

sudo nano /etc/systemd/system/vllm.service

# Paste the following service configuration:
"""
[Unit]
Description=vLLM Server
After=network.target

[Service]
User=sergio
WorkingDirectory=/home/sergio
        
ExecStart=
ExecStart=/home/sergio/.venv/bin/vllm serve /home/sergio/custom-models/Qwen3.5-4B-AWQ  \
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
  --override-generation-config '{"temperature":0.2,"top_k": 20,"top_p":0.9,"repetition_penalty":1.15}'

Restart=always
RestartSec=5

Environment=PYTHONUNBUFFERED=1
Environment=PATH=/home/sergio/.venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=CUDA_HOME=/usr/local/cuda
Environment=HF_HOME=/home/sergio/.cache/huggingface
Environment=TRANSFORMERS_CACHE=/home/sergio/.cache/huggingface

[Install]
WantedBy=multi-user.target

"""

# Open firewall rule to allow connections from network to vLLM port
sudo ufw allow from 192.168.2.45/24 to any port 8080 proto tcp

# Reload systemd, restart service, and monitor logs
sudo systemctl daemon-reload
sudo systemctl restart vllm
sudo systemctl stop vllm
journalctl -u vllm -f


