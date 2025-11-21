from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from models import FactCheckRequest
from factchecker import fact_check

app = FastAPI(
    title="TruthLens API",
    docs_url=None,
    redoc_url=None,
    openapi_url=None
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["POST", "GET", "HEAD"],
    allow_headers=["Content-Type"],
)

@app.post("/")
async def factcheck(req: FactCheckRequest):
    try:
        return fact_check(req.query)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
@app.head("/health")
async def health():
    return {"status": "ok"}
