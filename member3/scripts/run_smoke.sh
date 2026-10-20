#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
    read -rsp "粘贴 Cockpit 本地密钥: " OPENAI_API_KEY
    echo
    export OPENAI_API_KEY
fi

export NO_PROXY="${NO_PROXY:+$NO_PROXY,}172.26.240.1,127.0.0.1,localhost"
export no_proxy="$NO_PROXY"

uv run --locked harbor run \
    -p tasks/010-pivot-product-revenue \
    --agent-import-path member3.loop_recovery:LoopRecoveryTerminus2 \
    -m openai/gpt-6-luna \
    --ak api_base=http://172.26.240.1:64915/v1 \
    --ak max_turns=10 \
    --ak enable_loop_recovery=true \
    --ak 'llm_call_kwargs={"max_tokens":2048}' \
    --ak 'model_info={"max_input_tokens":272000,"max_output_tokens":2048}' \
    -n 1 \
    -k 1 \
    --jobs-dir member3/runs/smoke
