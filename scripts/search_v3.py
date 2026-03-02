# 智能搜索v3 - 带429保护
import requests
import json
import time
import sys
import io
import os
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 配置
TAVILY_KEY = "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"
LOG_FILE = "tavily_usage.log"
COOLDOWN_HOURS = 24  # 429后冷却24小时
MAX_RETRIES = 1      # 最多重试1次

# 读取日志，检查是否在冷却期
def is_in_cooldown():
    if not os.path.exists(LOG_FILE):
        return False
    try:
        with open(LOG_FILE, 'r') as f:
            for line in f:
                if "429" in line:
                    # 最后一次429的时间
                    parts = line.split("|")
                    if len(parts) > 0:
                        timestamp = parts[0].strip()
                        # 这里简化处理，实际可以用时间戳
                        print(f"⚠️ 检测到上次429错误，需要等待冷却")
                        return True
    except:
        pass
    return False

# 记录使用
def log_usage(status, error=None):
    with open(LOG_FILE, 'a') as f:
        if error:
            f.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')} | {status} | {error}\n")
        else:
            f.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')} | {status}\n")

def search(query, max_results=5):
    print(f"\n🔍 搜索: {query}")
    
    # 检查冷却
    if is_in_cooldown():
        print("⏭️ Tavily在冷却期，跳过")
        return None
    
    # 尝试Tavily
    retry = 0
    while retry <= MAX_RETRIES:
        try:
            print(f"📡 调用Tavily (尝试 {retry+1})...")
            r = requests.post(
                "https://api.tavily.com/search",
                json={"api_key": TAVILY_KEY, "query": query, "max_results": max_results},
                timeout=10  # 10秒超时
            )
            
            if r.status_code == 200:
                result = r.json()
                if "results" in result and result["results"]:
                    log_usage("SUCCESS")
                    print("✅ Tavily成功!")
                    return result
                else:
                    print("⚠️ Tavily返回空结果")
                    return None
                    
            elif r.status_code == 429:
                print("❌ 429错误！配额用尽！")
                log_usage("429", f"status:{r.status_code}")
                print("💡 切换到备用方式...")
                return None
                
            elif r.status_code == 401:
                print("❌ 401错误！Key无效！")
                log_usage("401_INVALID_KEY", f"status:{r.status_code}")
                return None
                
            else:
                print(f"⚠️ 错误 {r.status_code}")
                if retry < MAX_RETRIES:
                    retry += 1
                    time.sleep(3)
                    continue
                return None
                
        except requests.exceptions.Timeout:
            print("⏱️ 超时")
            if retry < MAX_RETRIES:
                retry += 1
                time.sleep(2)
                continue
            return None
        except Exception as e:
            print(f"❌ 异常: {e}")
            return None
    
    return None

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
        result = search(query)
        if result:
            print(f"✓ 找到 {len(result.get('results', []))} 条结果")
        else:
            print("✗ 搜索失败，请用其他方式")
    else:
        print("用法: python search_v3.py 搜索内容")
