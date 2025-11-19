import requests
from typing import List, Dict, Any
from config import SEARCH_API_KEY, SEARCH_ENGINE_ID

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
