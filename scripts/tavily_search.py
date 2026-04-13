# Tavily搜索封装
import requests
import sys
import io
import json

# 设置输出编码
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

API_KEY = "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"
URL = "https://api.tavily.com/search"

def search(query, max_results=10):
    """搜索函数"""
    data = {
        "api_key": API_KEY,
        "query": query,
        "max_results": max_results
    }
    
    try:
        r = requests.post(URL, json=data, timeout=30)
        if r.status_code == 200:
            return r.json()
        else:
            return {"error": f"Status: {r.status_code}", "message": r.text}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
        print(f"搜索: {query}")
        result = search(query)
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        print("用法: python tavily_search.py 搜索内容")
