# 👨‍💻 Aurelia MindScape Developer Guide

## 🚀 Quick Start

### Prerequisites
- Python 3.11+
- Flutter 3.16+
- Node.js 18+ (for development tools)
- Docker & Docker Compose
- PostgreSQL 14+
- Redis 6+

### 1. Clone & Setup
```bash
# Clone repository
git clone https://github.com/dugadak/aurelia-mindscape.git
cd aurelia-mindscape

# Setup development environment
./scripts/setup-dev.sh  # Unix/Mac
# or
scripts\setup-dev.bat   # Windows
```

### 2. Environment Configuration
```bash
# Copy environment template
cp .env.example .env

# Edit .env file with your configurations
nano .env
```

Required environment variables:
```env
# Core
SECRET_KEY=your-secret-key-here
DEBUG=True

# Database
DATABASE_URL=postgresql://aurelia:password@localhost:5432/mindscape
REDIS_URL=redis://localhost:6379/0

# AI Services
OPENAI_API_KEY=sk-...
GPT_MODEL=gpt-4-turbo-preview

# Optional Services
NEO4J_URL=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=password
```

## 🏗 Project Structure

```
aurelia-mindscape/
├── server/                 # Backend (FastAPI)
│   ├── api/               # API endpoints
│   ├── models/            # Database models
│   ├── services/          # Business logic
│   ├── utils/             # Utilities
│   ├── config/            # Configuration
│   └── tests/             # Backend tests
├── app/                   # Mobile app (Flutter)
│   ├── lib/
│   │   ├── screens/       # UI screens
│   │   ├── widgets/       # Reusable widgets
│   │   ├── models/        # Data models
│   │   ├── services/      # API services
│   │   ├── providers/     # State management
│   │   └── themes/        # App themes
│   └── test/              # Flutter tests
├── docs/                  # Documentation
├── scripts/               # Utility scripts
└── docker/               # Docker configurations
```

## 💻 Backend Development

### Running the Server
```bash
cd server

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Unix/Mac
# or
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt
pip install -r requirements-dev.txt

# Run migrations
alembic upgrade head

# Start development server
uvicorn main:app --reload --port 8888
```

### Creating New Endpoints

#### 1. Define Router
```python
# server/api/feature.py
from fastapi import APIRouter, Depends, HTTPException
from typing import List
from models.feature import Feature
from services.feature_service import FeatureService

router = APIRouter()

@router.post("/create")
async def create_feature(
    data: FeatureCreate,
    service: FeatureService = Depends()
):
    """Create new feature"""
    return await service.create(data)

@router.get("/{feature_id}")
async def get_feature(
    feature_id: str,
    service: FeatureService = Depends()
):
    """Get feature by ID"""
    feature = await service.get(feature_id)
    if not feature:
        raise HTTPException(404, "Feature not found")
    return feature
```

#### 2. Create Service
```python
# server/services/feature_service.py
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from models.feature import Feature
from database import get_db

class FeatureService:
    def __init__(self, db: AsyncSession = Depends(get_db)):
        self.db = db
    
    async def create(self, data: FeatureCreate) -> Feature:
        """Create new feature with quantum processing"""
        # Quantum state initialization
        quantum_state = await self.initialize_quantum_state(data)
        
        # Create database entry
        feature = Feature(
            **data.dict(),
            quantum_signature=quantum_state
        )
        
        self.db.add(feature)
        await self.db.commit()
        await self.db.refresh(feature)
        
        # Emit event
        await self.emit_creation_event(feature)
        
        return feature
    
    async def initialize_quantum_state(self, data):
        """Initialize quantum state for feature"""
        # Quantum logic here
        pass
```

#### 3. Define Models
```python
# server/models/feature.py
from sqlalchemy import Column, String, Float, JSON
from sqlalchemy.dialects.postgresql import UUID
from database import Base
import uuid

class Feature(Base):
    __tablename__ = "features"
    
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    quantum_state = Column(JSON)
    coherence_level = Column(Float, default=0.0)
    
    # Relationships
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    user = relationship("User", back_populates="features")
```

### Database Migrations

```bash
# Create new migration
alembic revision --autogenerate -m "Add feature table"

# Apply migrations
alembic upgrade head

# Rollback
alembic downgrade -1
```

### Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=app --cov-report=html

# Run specific test
pytest tests/test_consciousness.py::test_quantum_state

# Run with verbose output
pytest -v

# Run async tests
pytest -v --asyncio-mode=auto
```

Example test:
```python
# tests/test_feature.py
import pytest
from httpx import AsyncClient
from main import app

@pytest.mark.asyncio
async def test_create_feature():
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.post(
            "/api/v1/feature/create",
            json={"name": "Test Feature"},
            headers={"Authorization": "Bearer test-token"}
        )
    assert response.status_code == 201
    assert response.json()["name"] == "Test Feature"
```

## 📱 Flutter App Development

### Setup Flutter Environment
```bash
cd app

# Get dependencies
flutter pub get

# Generate code (if using code generation)
flutter pub run build_runner build

# Run on emulator/device
flutter run

# Run with specific flavor
flutter run --flavor development
flutter run --flavor production
```

### Creating New Screens

#### 1. Screen Widget
```dart
// lib/screens/feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurelia_mindscape/providers/feature_provider.dart';

class FeatureScreen extends ConsumerStatefulWidget {
  const FeatureScreen({super.key});
  
  @override
  ConsumerState<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends ConsumerState<FeatureScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }
  
  @override
  Widget build(BuildContext context) {
    final featureState = ref.watch(featureProvider);
    
    return Scaffold(
      body: featureState.when(
        data: (data) => _buildContent(data),
        loading: () => const QuantumLoader(),
        error: (err, stack) => ErrorWidget(err),
      ),
    );
  }
  
  Widget _buildContent(FeatureData data) {
    return Container(
      decoration: _quantumGradient(),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildQuantumVisualizer(),
            _buildInteractionZone(),
          ],
        ),
      ),
    );
  }
}
```

#### 2. State Management with Riverpod
```dart
// lib/providers/feature_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurelia_mindscape/services/api_service.dart';

// Feature state
@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState({
    required String id,
    required String name,
    required double quantumCoherence,
    @Default([]) List<String> activeNodes,
  }) = _FeatureState;
}

// Feature notifier
class FeatureNotifier extends StateNotifier<FeatureState> {
  final ApiService _api;
  
  FeatureNotifier(this._api) : super(FeatureState.initial());
  
  Future<void> updateQuantumState(Map<String, dynamic> state) async {
    state = state.copyWith(quantumCoherence: state['coherence']);
    
    // Sync with server
    await _api.updateFeature(state);
    
    // Emit quantum event
    _emitQuantumEvent(state);
  }
}

// Providers
final featureProvider = StateNotifierProvider<FeatureNotifier, FeatureState>(
  (ref) => FeatureNotifier(ref.watch(apiServiceProvider)),
);

final quantumStreamProvider = StreamProvider<QuantumUpdate>((ref) {
  return ref.watch(websocketServiceProvider).quantumStream;
});
```

#### 3. Custom Widgets
```dart
// lib/widgets/quantum_visualizer.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuantumVisualizer extends StatefulWidget {
  final double coherenceLevel;
  final List<QuantumNode> nodes;
  
  const QuantumVisualizer({
    super.key,
    required this.coherenceLevel,
    required this.nodes,
  });
  
  @override
  State<QuantumVisualizer> createState() => _QuantumVisualizerState();
}

class _QuantumVisualizerState extends State<QuantumVisualizer>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: QuantumFieldPainter(
        coherence: widget.coherenceLevel,
        nodes: widget.nodes,
        rotation: _rotationController.value,
        pulse: _pulseController.value,
      ),
    );
  }
}

class QuantumFieldPainter extends CustomPainter {
  final double coherence;
  final List<QuantumNode> nodes;
  final double rotation;
  final double pulse;
  
  QuantumFieldPainter({
    required this.coherence,
    required this.nodes,
    required this.rotation,
    required this.pulse,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.screen;
    
    // Draw quantum field
    for (final node in nodes) {
      _drawQuantumNode(canvas, center, node, paint);
    }
    
    // Draw entanglement lines
    _drawEntanglements(canvas, center, paint);
  }
  
  void _drawQuantumNode(
    Canvas canvas, 
    Offset center, 
    QuantumNode node, 
    Paint paint
  ) {
    final angle = node.phase + rotation * 2 * math.pi;
    final radius = 100 * (1 + 0.2 * math.sin(pulse * 2 * math.pi));
    
    final position = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
    
    // Quantum glow effect
    paint.shader = RadialGradient(
      colors: [
        Colors.purpleAccent.withOpacity(coherence),
        Colors.blueAccent.withOpacity(coherence * 0.5),
        Colors.transparent,
      ],
    ).createShader(Rect.fromCircle(center: position, radius: 30));
    
    canvas.drawCircle(position, 10 * node.amplitude, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

### Testing Flutter App

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/app_test.dart
```

Example widget test:
```dart
// test/feature_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:aurelia_mindscape/screens/feature_screen.dart';

void main() {
  testWidgets('Feature screen shows quantum visualizer', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: FeatureScreen(),
        ),
      ),
    );
    
    expect(find.byType(QuantumVisualizer), findsOneWidget);
    expect(find.text('Quantum Coherence'), findsOneWidget);
    
    // Test interaction
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
```

## 🔌 WebSocket Development

### Server-side WebSocket
```python
# server/websocket/quantum_handler.py
from fastapi import WebSocket, WebSocketDisconnect
from typing import Dict, Set
import json

class QuantumConnectionManager:
    def __init__(self):
        self.active_connections: Dict[str, WebSocket] = {}
        self.quantum_states: Dict[str, dict] = {}
    
    async def connect(self, websocket: WebSocket, user_id: str):
        await websocket.accept()
        self.active_connections[user_id] = websocket
        
        # Initialize quantum state
        self.quantum_states[user_id] = {
            "coherence": 1.0,
            "entangled_with": set()
        }
        
        # Notify entangled users
        await self.broadcast_quantum_event({
            "type": "user_connected",
            "user_id": user_id,
            "quantum_state": self.quantum_states[user_id]
        })
    
    async def disconnect(self, user_id: str):
        del self.active_connections[user_id]
        del self.quantum_states[user_id]
        
        await self.broadcast_quantum_event({
            "type": "user_disconnected",
            "user_id": user_id
        })
    
    async def process_quantum_message(self, user_id: str, message: dict):
        """Process quantum state updates"""
        if message["type"] == "quantum_update":
            self.quantum_states[user_id].update(message["state"])
            
            # Check for entanglement
            entangled_users = self.find_entangled_users(user_id)
            
            for entangled_id in entangled_users:
                if entangled_id in self.active_connections:
                    await self.send_personal_message(
                        entangled_id,
                        {
                            "type": "entanglement_update",
                            "source": user_id,
                            "quantum_state": self.quantum_states[user_id]
                        }
                    )

manager = QuantumConnectionManager()

@app.websocket("/ws/quantum/{user_id}")
async def quantum_websocket_endpoint(websocket: WebSocket, user_id: str):
    await manager.connect(websocket, user_id)
    try:
        while True:
            data = await websocket.receive_json()
            await manager.process_quantum_message(user_id, data)
    except WebSocketDisconnect:
        await manager.disconnect(user_id)
```

### Client-side WebSocket (Flutter)
```dart
// lib/services/websocket_service.dart
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WebSocketService {
  late WebSocketChannel _channel;
  final _quantumStreamController = StreamController<QuantumUpdate>.broadcast();
  
  Stream<QuantumUpdate> get quantumStream => _quantumStreamController.stream;
  
  void connect(String userId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.aurelia-mindscape.ai/ws/quantum/$userId'),
    );
    
    _channel.stream.listen(
      (message) {
        final data = jsonDecode(message);
        _handleMessage(data);
      },
      onError: (error) => _handleError(error),
      onDone: () => _reconnect(),
    );
    
    // Send initial quantum state
    sendQuantumUpdate({
      'type': 'quantum_update',
      'state': {
        'coherence': 1.0,
        'phase': 0.0,
      }
    });
  }
  
  void _handleMessage(Map<String, dynamic> data) {
    switch (data['type']) {
      case 'entanglement_update':
        _quantumStreamController.add(
          QuantumUpdate.entanglement(data)
        );
        break;
      case 'collective_consciousness':
        _quantumStreamController.add(
          QuantumUpdate.collective(data)
        );
        break;
    }
  }
  
  void sendQuantumUpdate(Map<String, dynamic> update) {
    _channel.sink.add(jsonEncode(update));
  }
  
  void dispose() {
    _channel.sink.close();
    _quantumStreamController.close();
  }
}
```

## 🧪 AI/ML Integration

### Using OpenAI GPT-4
```python
# server/services/ai_service.py
from openai import AsyncOpenAI
from config.settings import settings

class AIService:
    def __init__(self):
        self.client = AsyncOpenAI(api_key=settings.OPENAI_API_KEY)
    
    async def generate_story(
        self, 
        emotional_context: dict,
        user_preferences: dict
    ) -> dict:
        """Generate interactive story based on emotional state"""
        
        prompt = self._build_story_prompt(emotional_context, user_preferences)
        
        response = await self.client.chat.completions.create(
            model="gpt-4-turbo-preview",
            messages=[
                {
                    "role": "system",
                    "content": "You are a quantum storyteller creating emotionally adaptive narratives."
                },
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=0.8,
            max_tokens=2000,
            response_format={"type": "json_object"}
        )
        
        story_data = json.loads(response.choices[0].message.content)
        
        # Process with quantum logic
        story_data = await self._apply_quantum_narrative(story_data)
        
        return story_data
    
    async def analyze_emotion(self, text: str, voice_features: dict = None):
        """Multi-modal emotion analysis"""
        
        # Text analysis
        text_emotions = await self._analyze_text_emotion(text)
        
        # Voice analysis if provided
        if voice_features:
            voice_emotions = await self._analyze_voice_emotion(voice_features)
            
            # Fusion algorithm
            combined = self._fuse_emotions(text_emotions, voice_emotions)
        else:
            combined = text_emotions
        
        return {
            "primary_emotion": combined["dominant"],
            "emotion_vector": combined["vector"],
            "confidence": combined["confidence"],
            "quantum_state": self._emotion_to_quantum(combined)
        }
```

### Custom ML Models
```python
# server/ml/emotion_model.py
import torch
import torch.nn as nn
from transformers import AutoModel, AutoTokenizer

class QuantumEmotionModel(nn.Module):
    """Custom emotion model with quantum-inspired architecture"""
    
    def __init__(self, num_emotions=7):
        super().__init__()
        
        # Pre-trained transformer
        self.bert = AutoModel.from_pretrained('bert-base-uncased')
        
        # Quantum layers
        self.quantum_encoder = nn.Sequential(
            nn.Linear(768, 512),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(512, 256),
            QuantumActivation(),  # Custom quantum activation
        )
        
        # Emotion classifier
        self.emotion_head = nn.Linear(256, num_emotions)
        
        # Quantum state predictor
        self.quantum_head = nn.Linear(256, 128)  # Quantum state vector
    
    def forward(self, input_ids, attention_mask):
        # BERT encoding
        outputs = self.bert(
            input_ids=input_ids,
            attention_mask=attention_mask
        )
        
        pooled = outputs.pooler_output
        
        # Quantum processing
        quantum_features = self.quantum_encoder(pooled)
        
        # Dual outputs
        emotions = torch.softmax(self.emotion_head(quantum_features), dim=-1)
        quantum_state = self.quantum_head(quantum_features)
        
        return {
            'emotions': emotions,
            'quantum_state': quantum_state,
            'coherence': self._calculate_coherence(quantum_state)
        }
    
    def _calculate_coherence(self, quantum_state):
        """Calculate quantum coherence from state vector"""
        # Quantum coherence calculation
        amplitude = torch.abs(quantum_state)
        phase = torch.angle(quantum_state.type(torch.complex64))
        coherence = torch.mean(torch.cos(phase) * amplitude)
        return coherence

class QuantumActivation(nn.Module):
    """Custom quantum-inspired activation function"""
    
    def forward(self, x):
        # Superposition of activation states
        return 0.5 * torch.tanh(x) + 0.5 * torch.sigmoid(x)
```

## 🔧 Debugging & Troubleshooting

### Common Issues

#### 1. Quantum Decoherence Error
```python
# Error: QuantumDecoherenceException
# Solution: Increase coherence threshold

# server/config/settings.py
QUANTUM_COHERENCE_THRESHOLD = 0.85  # Increase from 0.75
QUANTUM_DECOHERENCE_TIME = 2000    # Increase from 1000ms
```

#### 2. WebSocket Connection Issues
```dart
// Flutter: WebSocket connection keeps dropping
// Solution: Implement reconnection logic

class ResilientWebSocket {
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  
  void _reconnect() {
    if (_reconnectAttempts < 5) {
      _reconnectTimer = Timer(
        Duration(seconds: math.pow(2, _reconnectAttempts).toInt()),
        () {
          _reconnectAttempts++;
          connect();
        }
      );
    }
  }
}
```

#### 3. Memory Leaks in Flutter
```dart
// Always dispose controllers and subscriptions
@override
void dispose() {
  _animationController.dispose();
  _streamSubscription?.cancel();
  _scrollController.dispose();
  super.dispose();
}
```

### Logging & Monitoring

#### Backend Logging
```python
# server/utils/logger.py
import logging
from pythonjsonlogger import jsonlogger

def setup_logger(name: str):
    logger = logging.getLogger(name)
    
    handler = logging.StreamHandler()
    formatter = jsonlogger.JsonFormatter(
        '%(timestamp)s %(level)s %(name)s %(message)s',
        timestamp=True
    )
    handler.setFormatter(formatter)
    
    logger.addHandler(handler)
    logger.setLevel(logging.INFO)
    
    return logger

# Usage
logger = setup_logger(__name__)
logger.info("Quantum state initialized", extra={
    "user_id": user_id,
    "coherence": 0.95,
    "quantum_state": quantum_state
})
```

#### Flutter Logging
```dart
// lib/utils/logger.dart
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );
  
  static void logQuantumEvent(String event, Map<String, dynamic> data) {
    _logger.i('Quantum Event: $event', data);
  }
  
  static void logError(String message, dynamic error, StackTrace? stack) {
    _logger.e(message, error, stack);
  }
}
```

## 🚀 Performance Optimization

### Backend Optimization

#### 1. Database Query Optimization
```python
# Use select_related and prefetch_related
from sqlalchemy.orm import selectinload, joinedload

async def get_user_with_emotions(user_id: str):
    query = (
        select(User)
        .options(
            selectinload(User.emotions),
            selectinload(User.journal_entries),
        )
        .where(User.id == user_id)
    )
    result = await db.execute(query)
    return result.scalar_one_or_none()
```

#### 2. Caching Strategy
```python
from functools import lru_cache
from aiocache import cached

@cached(ttl=300)  # Cache for 5 minutes
async def get_quantum_state(user_id: str):
    # Expensive quantum calculation
    return await calculate_quantum_state(user_id)
```

### Flutter Optimization

#### 1. Widget Optimization
```dart
// Use const constructors
const MyWidget({super.key});

// Use const for immutable widgets
const SizedBox(height: 20),

// Use RepaintBoundary for expensive widgets
RepaintBoundary(
  child: ExpensiveWidget(),
)
```

#### 2. Image Optimization
```dart
// Use cached network images
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(color: Colors.white),
  ),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

## 📚 Resources

### Documentation
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev/)

### Tutorials
- [Building Quantum Apps Tutorial](docs/tutorials/quantum-apps.md)
- [WebSocket Implementation Guide](docs/tutorials/websocket.md)
- [AI Integration Tutorial](docs/tutorials/ai-integration.md)

### Community
- [Discord Server](https://discord.gg/aurelia-dev)
- [GitHub Discussions](https://github.com/dugadak/aurelia-mindscape/discussions)
- [Stack Overflow Tag](https://stackoverflow.com/questions/tagged/aurelia-mindscape)