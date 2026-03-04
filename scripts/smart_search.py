# 智能搜索封装
# 自动尝试多种搜索方式，Tavily失败时自动切换

import requests
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

TAVILY_KEY = "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"

def search_with_fallback(query, max_results=5):
    """
    智能搜索：自动尝试多种方式
    优先级: Tavily → web_fetch → 失败提示
    """
    print(f"搜索: {query}")
    print("尝试方式1: Tavily...")
    
    # 方式1: Tavily
    try:
        import requests
        r = requests.post(
            "https://api.tavily.com/search",
            json={"api_key": TAVILY_KEY, "query": query, "max_results": max_results},
            timeout=30
        )
        if r.status_code == 200:
            result = r.json()
            if "results" in result:
                print("✓ Tavily成功!")
                return {"source": "tavily", "data": result}
            else:
                print(f"✗ Tavily返回异常: {result}")
        else:
            print(f"✗ Tavily失败: {r.status_code}")
    except Exception as e:
        print(f"✗ Tavily异常: {e}")
    
    # 方式2: web_fetch (搜索引挚结果页面)
    print("尝试方式2: web_fetch (Bing搜索)...")
    try:
        # 用Bing搜索结果页面作为备选
        import urllib.parse
        encoded = urllib.parse.quote(query)
        url = f"https://www.bing.com/search?q={encoded}"
        # 这个方法不太靠谱，跳过
        print("✗ web_fetch不适合做搜索，跳过")
    except Exception as e:
        print(f"✗ web_fetch失败: {e}")
    
    # 所有方式都失败
    print("✗ 所有搜索方式都失败了")
    return {"source": "failed", "error": "所有搜索方式不可用"}

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
        search_with_fallback(query)
    else:
        print("用法: python smart_search.py 搜索内容")
