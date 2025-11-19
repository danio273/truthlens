from fastapi import FastAPI, HTTPException
from models import FactCheckRequest
from factchecker import fact_check

app = FastAPI(
    title="TruthLens API",
    docs_url=None,
    redoc_url=None,
    openapi_url=None
)

@app.post("/")
async def factcheck(req: FactCheckRequest):
    try:
        return fact_check(req.text)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
