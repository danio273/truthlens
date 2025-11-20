from pydantic import BaseModel

class FactCheckRequest(BaseModel):
    query: str
