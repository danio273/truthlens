from pydantic import BaseModel

class FactCheckRequest(BaseModel):
    text: str
