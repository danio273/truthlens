from pydantic import BaseModel, Field

class FactCheckRequest(BaseModel):
    query: str = Field(
        ...,
        description="Tekst przeznaczony do weryfikacji i analizy wiarygodności.",
        examples=["Przykładowy tekst do analizy."]
    )