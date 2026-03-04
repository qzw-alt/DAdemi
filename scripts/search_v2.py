# 智能搜索封装 v2
# 遇到429错误自动切换到备用方式

import requests
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

TAVILY_KEY = "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"

def search(query, max_results=5):
    """
    智能搜索：Tavily 429时自动切换
    """
    print(f"搜索: {query}")
    
    # 尝试Tavily
    try:
        r = requests.post(
            "https://api.tavily.com/search",
            json={"api_key": TAVILY_KEY, "query": query, "max_results": max_results},
            timeout=30
        )
        
        if r.status_code == 200:
            result = r.json()
            if "results" in result:
                print("✓ Tavily成功!")
                return result
                
        elif r.status_code == 429:
            print("⚠️ 429错误！Tavily配额用尽，切换备用方式...")
            # 遇到429，抛异常让上层处理
            raise Exception("Tavily 429")
            
        else:
            print(f"✗ Tavily错误: {r.status_code}")
            raise Exception(f"Status {r.status_code}")
            
    except Exception as e:
        if "429" in str(e):
            print("→ 切换到web_fetch备用")
            return None
        else:
            print(f"→ Tavily异常: {e}")
            return None
    
    return None

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
        result = search(query)
        if result:
            print("搜索完成")
        else:
            print("搜索失败，请用web_fetch等其他方式")
    else:
        print("用法: python search.py 搜索内容")
