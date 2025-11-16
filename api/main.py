import google.genai as genai
from google.genai.types import GenerateContentConfig

from response_schema import RESPONSE_SCHEMA
from system_prompt import SYSTEM_PROMPT

import json
from typing import Dict, Any

import os
from dotenv import load_dotenv

load_dotenv()
API_KEY = os.getenv("GEMINI_API_KEY")

client = genai.Client(api_key=API_KEY)

config = GenerateContentConfig(
    system_instruction=SYSTEM_PROMPT,
    temperature=0.1,
    response_mime_type="application/json",
    response_schema=RESPONSE_SCHEMA
)

def fact_check_text(input_text: str) -> Dict[str, Any]:
    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=input_text,
        config=config
    )
    return json.loads(response.text)


if __name__ == "__main__":
    text = "text for check"

    result = fact_check_text(text)

    print(result)
    print(json.dumps(result, indent=2, ensure_ascii=False))
