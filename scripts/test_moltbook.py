# Moltbook测试
import requests
import json
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

API_KEY = "moltbook_sk_P6XxaWqyPzKOO4hFMsoXvmFuTAlB3Jut"

# 尝试Moltbook API
url = "https://api.moltbook.com/v1/chat/completions"
headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

data = {
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "你好，请介绍一下你自己"}],
    "max_tokens": 200
}

print("尝试连接Moltbook API...")
try:
    r = requests.post(url, headers=headers, json=data, timeout=15)
    print(f"Status: {r.status_code}")
    print(f"Response: {r.text[:500]}")
except Exception as e:
    print(f"Error: {e}")
