import os
from dotenv import load_dotenv
import google.genai as genai
from google.genai.types import GenerateContentConfig

from prompts.system_prompt import SYSTEM_PROMPT
from prompts.response_schema import RESPONSE_SCHEMA

load_dotenv()

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
SEARCH_API_KEY = os.getenv("SEARCH_API_KEY")
SEARCH_ENGINE_ID = os.getenv("SEARCH_ENGINE_ID")

if not (GEMINI_API_KEY and SEARCH_API_KEY and SEARCH_ENGINE_ID):
    raise RuntimeError("Keys are missing")

client = genai.Client(api_key=GEMINI_API_KEY)

generation_config = GenerateContentConfig(
    system_instruction=SYSTEM_PROMPT,
    temperature=0.1,
    response_mime_type="application/json",
    response_schema=RESPONSE_SCHEMA
)
