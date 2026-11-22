from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from models import FactCheckRequest
from factchecker import fact_check

app = FastAPI(
    title="TruthLens API",
    description="API do automatycznej weryfikacji wiarygodności tekstów i wykrywania dezinformacji za pomocą modeli AI.",
    version="1.2.1",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["POST", "GET", "HEAD"],
    allow_headers=["Content-Type"],
)

@app.post(
    "/",
    summary="Analiza i weryfikacja tekstu",
    description="Przesyła tekst do analizy przez model AI w celu oceny wiarygodności, logiki oraz wykrycia ewentualnych manipulacji.",
    response_description="Szczegółowy raport w formacie JSON zawierający wyniki analizy czynnikowej.",
    tags=["Analiza"]
)
async def factcheck(req: FactCheckRequest):
    try:
        return fact_check(req.query)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get(
    "/health",
    summary="Status API (GET)",
    description="Sprawdza, czy serwis działa poprawnie.",
    response_description="Informacja o statusie serwisu.",
    tags=["Status"]
)
@app.head(
    "/health",
    summary="Status API (HEAD)",
    description="Sprawdza nagłówki statusu serwisu.",
    response_description="Informacja o statusie serwisu.",
    tags=["Status"]
)
async def health():
    return {"status": "ok"}
