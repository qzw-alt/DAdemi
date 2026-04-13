import requests

api_key = "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"
url = "https://api.tavily.com/search"

data = {
    "api_key": api_key,
    "query": "medical tourism China",
    "max_results": 5
}

try:
    r = requests.post(url, json=data, timeout=10)
    print(f"Status: {r.status_code}")
    print(f"Response: {r.text[:500]}")
except Exception as e:
    print(f"Error: {e}")
