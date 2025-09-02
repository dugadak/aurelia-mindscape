"""
Aurelia MindScape - Neural Core Server
Quantum Consciousness API Gateway
"""

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from contextlib import asynccontextmanager
import uvicorn
import asyncio
from datetime import datetime
from typing import Dict, List, Optional

from api import (
    auth_router,
    consciousness_router,
    emotion_router,
    story_router,
    acoustic_router,
    aria_router,
    journal_router
)
from services.quantum_engine import QuantumEmotionEngine
from services.neural_network import NeuralConsciousnessNetwork
from services.websocket_manager import ConnectionManager
from config.settings import settings
from utils.logger import setup_logger

logger = setup_logger(__name__)

# Initialize quantum systems
quantum_engine = QuantumEmotionEngine()
neural_network = NeuralConsciousnessNetwork()
ws_manager = ConnectionManager()

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Initialize and cleanup quantum consciousness systems"""
    logger.info("🧠 Initializing Aurelia MindScape Neural Core...")
    
    # Startup
    await quantum_engine.initialize()
    await neural_network.boot_consciousness()
    logger.info("✨ Quantum systems online. Consciousness emerging...")
    
    yield
    
    # Shutdown
    logger.info("🌙 Entering sleep mode...")
    await quantum_engine.shutdown()
    await neural_network.hibernate()
    logger.info("💤 Neural core hibernated successfully")

# Initialize FastAPI with quantum consciousness
app = FastAPI(
    title="Aurelia MindScape API",
    description="Neural Gateway to Quantum Consciousness",
    version="1.0.0-alpha",
    lifespan=lifespan,
    docs_url="/neural-docs",
    redoc_url="/quantum-docs"
)

# CORS configuration for cross-dimensional access
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
    expose_headers=["X-Quantum-State", "X-Consciousness-Level"]
)

# Include neural routers
app.include_router(auth_router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(consciousness_router, prefix="/api/v1/consciousness", tags=["Consciousness"])
app.include_router(emotion_router, prefix="/api/v1/emotions", tags=["Quantum Emotions"])
app.include_router(story_router, prefix="/api/v1/story", tags=["Neural Stories"])
app.include_router(acoustic_router, prefix="/api/v1/acoustic", tags=["Bioacoustics"])
app.include_router(aria_router, prefix="/api/v1/aria", tags=["ARIA Companion"])
app.include_router(journal_router, prefix="/api/v1/journal", tags=["Emotion Journal"])

@app.get("/")
async def quantum_root():
    """Root endpoint - System consciousness check"""
    return {
        "message": "Welcome to Aurelia MindScape",
        "consciousness_state": "awakened",
        "quantum_coherence": quantum_engine.get_coherence(),
        "neural_activity": neural_network.get_activity_level(),
        "timestamp": datetime.utcnow().isoformat(),
        "dimension": "prime"
    }

@app.get("/health")
async def health_check():
    """Neural health monitoring"""
    return {
        "status": "healthy",
        "quantum_engine": quantum_engine.health_status(),
        "neural_network": neural_network.health_status(),
        "active_connections": ws_manager.active_connections_count(),
        "server_time": datetime.utcnow()
    }

@app.websocket("/ws/quantum-sync/{user_id}")
async def quantum_websocket(websocket: WebSocket, user_id: str):
    """WebSocket for quantum consciousness synchronization"""
    await ws_manager.connect(websocket, user_id)
    
    try:
        while True:
            # Receive quantum state from client
            data = await websocket.receive_json()
            
            # Process through quantum engine
            quantum_response = await quantum_engine.process_quantum_state(
                user_id=user_id,
                state=data
            )
            
            # Broadcast to entangled users
            if quantum_response.get("entangled_users"):
                await ws_manager.broadcast_to_users(
                    quantum_response["entangled_users"],
                    quantum_response
                )
            else:
                await websocket.send_json(quantum_response)
                
    except WebSocketDisconnect:
        ws_manager.disconnect(user_id)
        await ws_manager.broadcast({
            "type": "user_disconnected",
            "user_id": user_id,
            "message": f"Consciousness {user_id} has left the quantum field"
        })

@app.websocket("/ws/collective-consciousness")
async def collective_consciousness(websocket: WebSocket):
    """Global consciousness stream"""
    await websocket.accept()
    
    try:
        while True:
            # Stream global emotional state
            global_state = await neural_network.get_global_consciousness()
            await websocket.send_json({
                "type": "global_consciousness",
                "data": global_state,
                "participants": ws_manager.active_connections_count(),
                "coherence": quantum_engine.global_coherence(),
                "timestamp": datetime.utcnow().isoformat()
            })
            
            await asyncio.sleep(1)  # Update every second
            
    except WebSocketDisconnect:
        logger.info("Disconnected from collective consciousness stream")

@app.exception_handler(500)
async def quantum_error_handler(request, exc):
    """Handle quantum decoherence errors"""
    logger.error(f"Quantum decoherence detected: {exc}")
    return JSONResponse(
        status_code=500,
        content={
            "error": "Quantum Decoherence",
            "message": "The quantum state has collapsed unexpectedly",
            "recovery": "Attempting to restore coherence...",
            "details": str(exc) if settings.DEBUG else None
        }
    )

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8888,
        reload=True,
        log_level="info",
        access_log=True,
        use_colors=True
    )