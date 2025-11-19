import json
from datetime import datetime
from typing import Dict, Any

from config import client, generation_config
from search import get_search_results

def fact_check(text: str) -> Dict[str, Any]:
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
        config=generation_config
    )
    
    analysis_result = json.loads(response.text)

    if 'factors' not in analysis_result:
        return analysis_result
    
    source_indexes = analysis_result['factors']['source_reliability'].get('source_links')
    
    if source_indexes:
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
        analysis_result['factors']['source_reliability']['sources'] = final_sources
    
    for factor_name in analysis_result['factors']:
        del analysis_result['factors'][factor_name]['source_links']
    
    return analysis_result
