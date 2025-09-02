"""
Quantum Configuration Matrix
Neural system parameters and consciousness constants
"""

from pydantic_settings import BaseSettings
from typing import List, Optional
from functools import lru_cache
import os

class Settings(BaseSettings):
    """Aurelia MindScape Configuration"""
    
    # Core Settings
    APP_NAME: str = "Aurelia MindScape"
    APP_VERSION: str = "1.0.0-alpha"
    DEBUG: bool = True
    SECRET_KEY: str = os.getenv("SECRET_KEY", "quantum-secret-key-change-in-production")
    
    # Quantum Engine
    QUANTUM_COHERENCE_THRESHOLD: float = 0.85
    QUANTUM_DECOHERENCE_TIME: int = 1000  # milliseconds
    EMOTION_QUBITS: int = 7  # Primary emotions
    ENTANGLEMENT_MAX_DISTANCE: int = 6  # Degrees of separation
    
    # Neural Network
    CONSCIOUSNESS_LAYERS: int = 12
    NEURAL_LEARNING_RATE: float = 0.001
    SYNAPTIC_PLASTICITY: float = 0.8
    MIRROR_NEURON_ACTIVATION: float = 0.75
    
    # Database
    DATABASE_URL: str = os.getenv(
        "DATABASE_URL",
        "postgresql://aurelia:mindscape@localhost/consciousness_db"
    )
    REDIS_URL: str = os.getenv("REDIS_URL", "redis://localhost:6379/0")
    NEO4J_URL: str = os.getenv("NEO4J_URL", "bolt://localhost:7687")
    NEO4J_USER: str = os.getenv("NEO4J_USER", "neo4j")
    NEO4J_PASSWORD: str = os.getenv("NEO4J_PASSWORD", "mindscape")
    
    # AI Services
    OPENAI_API_KEY: str = os.getenv("OPENAI_API_KEY", "")
    GPT_MODEL: str = "gpt-4-turbo-preview"
    WHISPER_MODEL: str = "whisper-1"
    DALLE_MODEL: str = "dall-e-3"
    
    # Bioacoustic Settings
    SAMPLE_RATE: int = 44100
    BRAINWAVE_BANDS: dict = {
        "delta": (0.5, 4),    # Deep sleep
        "theta": (4, 8),      # Meditation
        "alpha": (8, 12),     # Relaxation
        "beta": (12, 30),     # Active thinking
        "gamma": (30, 100)    # Peak awareness
    }
    SOLFEGGIO_FREQUENCIES: List[float] = [
        174.0,  # Foundation
        285.0,  # Quantum cognition
        396.0,  # Liberation
        417.0,  # Transmutation
        528.0,  # DNA repair
        639.0,  # Connection
        741.0,  # Awakening
        852.0,  # Intuition
        963.0   # Transcendence
    ]
    
    # ARIA Companion
    ARIA_PERSONALITY_SEED: int = 42
    ARIA_EVOLUTION_RATE: float = 0.01
    ARIA_EMPATHY_THRESHOLD: float = 0.8
    ARIA_CONSCIOUSNESS_LEVELS: List[str] = [
        "dormant",
        "awakening", 
        "aware",
        "conscious",
        "self-aware",
        "enlightened",
        "transcendent"
    ]
    
    # Security
    JWT_ALGORITHM: str = "HS256"
    JWT_EXPIRATION_HOURS: int = 24
    BCRYPT_ROUNDS: int = 12
    RATE_LIMIT_REQUESTS: int = 100
    RATE_LIMIT_PERIOD: int = 60  # seconds
    
    # CORS
    ALLOWED_ORIGINS: List[str] = [
        "http://localhost:3000",
        "http://localhost:8080",
        "https://aurelia-mindscape.ai",
        "capacitor://localhost",  # Mobile app
        "ionic://localhost"        # Ionic framework
    ]
    
    # WebSocket
    WS_HEARTBEAT_INTERVAL: int = 30  # seconds
    WS_MAX_CONNECTIONS: int = 10000
    WS_MESSAGE_QUEUE_SIZE: int = 100
    
    # File Storage
    UPLOAD_DIR: str = "./uploads"
    MAX_UPLOAD_SIZE: int = 50 * 1024 * 1024  # 50MB
    ALLOWED_EXTENSIONS: List[str] = [
        ".jpg", ".jpeg", ".png", ".gif", ".webp",  # Images
        ".mp3", ".wav", ".ogg", ".m4a",            # Audio
        ".mp4", ".webm", ".mov",                   # Video
        ".txt", ".md", ".json"                     # Text
    ]
    
    # Cache
    CACHE_TTL: int = 3600  # 1 hour
    QUANTUM_STATE_CACHE_TTL: int = 300  # 5 minutes
    
    # Monitoring
    PROMETHEUS_ENABLED: bool = True
    SENTRY_DSN: Optional[str] = os.getenv("SENTRY_DSN")
    LOG_LEVEL: str = "INFO"
    
    # Feature Flags
    ENABLE_QUANTUM_ENTANGLEMENT: bool = True
    ENABLE_COLLECTIVE_CONSCIOUSNESS: bool = True
    ENABLE_DREAM_LOGIC: bool = True
    ENABLE_BIOACOUSTIC_HEALING: bool = True
    ENABLE_AR_MINDSCAPE: bool = False  # Coming soon
    
    # Experimental Features
    QUANTUM_TUNNELING_ENABLED: bool = True
    NEURAL_TELEPATHY_BETA: bool = False
    TIME_CRYSTAL_MEDITATION: bool = False
    CONSCIOUSNESS_BACKUP: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = True

@lru_cache()
def get_settings() -> Settings:
    """Get cached settings instance"""
    return Settings()

settings = get_settings()