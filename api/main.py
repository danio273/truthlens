import google.genai as genai
from google.genai.types import GenerateContentConfig
from response_schema import RESPONSE_SCHEMA
from system_prompt import SYSTEM_PROMPT

import requests

import json
from typing import List, Dict, Any

from datetime import datetime

import os
from dotenv import load_dotenv

load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
SEARCH_API_KEY = os.getenv("SEARCH_API_KEY")
SEARCH_ENGINE_ID = os.getenv("SEARCH_ENGINE_ID")

client = genai.Client(api_key=GEMINI_API_KEY)

config = GenerateContentConfig(
    system_instruction=SYSTEM_PROMPT,
    temperature=0.1,
    response_mime_type="application/json",
    response_schema=RESPONSE_SCHEMA
)

def get_search_results(query: str) -> tuple[str, List[Dict[str, Any]]]:
    response = requests.get(
        "https://www.googleapis.com/customsearch/v1", 
        params={
            'key': SEARCH_API_KEY,
            'cx': SEARCH_ENGINE_ID,
            'q': query,
            'num': 5
        }
    )

    data = response.json()

    original_items = data.get('items')
    if not original_items:
        return "No relevant search results found in the external context.", []

    context_string = ""
    for i, item in enumerate(original_items): 
        context_string += (
            f"[Source {i} | URL: {item['link']}]\n"
            f"Title: {item.get('title', 'N/A')}\n"
            f"Snippet: {item.get('snippet', 'N/A')}\n\n"
        )
    
    return context_string.strip(), original_items

def fact_check_text(text: str) -> Dict[str, Any]:
    today = datetime.now().strftime("%B %d, %Y")

    retrieved_context, raw_search_items = get_search_results(text)

    content = (
        f"--- DYNAMIC DATA FOR ANALYSIS ---\n"
        f"CURRENT DATE FOR ANALYSIS: {today}\n"
        f"CONTEXT FOR VERIFICATION:\n{retrieved_context}\n"
        f"--- END OF DYNAMIC DATA ---\n\n"
        f"TEXT TO ANALYZE:\n"
        f"{text}"
    )

    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=[content],
        config=config
    )
    
    analysis_result = json.loads(response.text)

    if 'factors' not in analysis_result:
        return analysis_result
    
    source_indexes = analysis_result['factors']['source_reliability'].get('source_links', [])
    
    final_sources = []
    for index in source_indexes:
        if 0 <= index < len(raw_search_items):
            item = raw_search_items[index]
            final_sources.append({
                "title": item.get('title'),
                "snippet": item.get('snippet'),
                "displayLink": item.get('displayLink'),
                "link": item.get('link'),
            })
    
    for factor_name in analysis_result['factors']:
        del analysis_result['factors'][factor_name]['source_links']
    
    return analysis_result


if __name__ == "__main__":
    text = "text for check"

    result = fact_check_text(text)

    print(result)
    print(json.dumps(result, indent=2, ensure_ascii=False))
