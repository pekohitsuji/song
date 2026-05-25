### writen by gemini (CLI) ver. 0.43.0
### added a little bit by a pekohitsuji

import os
import re
import glob

def identify_ai(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        return f"Error reading file: {e}"

    header_match = re.search(r'<header>(.*?)</header>', content, re.DOTALL | re.IGNORECASE)
    footer_match = re.search(r'<footer>(.*?)</footer>', content, re.DOTALL | re.IGNORECASE)
    
    header_content = header_match.group(1) if header_match else ""
    footer_content = footer_match.group(1) if footer_match else ""
    
    combined = header_content + footer_content
    
    if any(keyword in combined for keyword in ["ChatGPT", "GPT", "OpenAI"]):
        return "ChatGPT"
    elif "Claude" in combined:
        return "Claude"
    elif "Gemini" in combined:
        return "Gemini"
    else:
        return "Unknown"

files = [f for f in glob.glob("*.html") if not f.endswith("--temp.html")]
files.sort()

results = []
for file in files:
    ai = identify_ai(file)
    results.append((file, ai))

print("| HTML ファイル名 | 作成したAI |")
print("| :--- | :--- |")
for filename, ai in results:
    print(f"| [{filename}](<../{filename}>) | {ai} |")
