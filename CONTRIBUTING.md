# 🤝 Contributing to Aurelia MindScape

First off, thank you for considering contributing to Aurelia MindScape! It's people like you that make Aurelia MindScape such a great tool for emotional wellness and consciousness exploration.

## 🌟 Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct:

- **Be Respectful**: Value each other's ideas, styles, and viewpoints
- **Be Inclusive**: Welcome newcomers and help them get started
- **Be Collaborative**: Work together to solve problems
- **Be Mindful**: Consider how your words and actions affect others
- **Be Professional**: Harassment and inappropriate behavior are not tolerated

## 🎯 How Can I Contribute?

### 1. Reporting Bugs 🐛

Before creating bug reports, please check existing issues to avoid duplicates.

**When submitting a bug report, include:**
```markdown
### Bug Description
A clear and concise description of the bug

### Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

### Expected Behavior
What you expected to happen

### Actual Behavior
What actually happened

### Screenshots
If applicable, add screenshots

### Environment
- OS: [e.g., iOS 16.5, Android 13]
- App Version: [e.g., 1.0.0]
- Device: [e.g., iPhone 14, Samsung S23]

### Additional Context
Any other relevant information
```

### 2. Suggesting Enhancements ✨

Enhancement suggestions are tracked as GitHub issues.

**When creating an enhancement suggestion, provide:**
```markdown
### Feature Description
Clear description of the proposed feature

### Motivation
Why this feature would be useful

### Proposed Solution
How you envision this working

### Alternatives Considered
Other solutions you've thought about

### Additional Context
Mockups, examples, or references
```

### 3. Code Contributions 💻

#### First Time Contributors

1. **Fork the Repository**
```bash
# Fork via GitHub UI, then:
git clone https://github.com/YOUR-USERNAME/aurelia-mindscape.git
cd aurelia-mindscape
git remote add upstream https://github.com/dugadak/aurelia-mindscape.git
```

2. **Set Up Development Environment**
```bash
# Backend setup
cd server
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
pip install -r requirements-dev.txt

# Frontend setup
cd ../app
flutter pub get
```

3. **Create a Branch**
```bash
git checkout -b feature/amazing-feature
# or
git checkout -b fix/bug-description
```

#### Development Process

1. **Make Your Changes**
   - Write clean, readable code
   - Follow the style guides below
   - Add tests for new features
   - Update documentation

2. **Test Your Changes**
```bash
# Backend tests
cd server
pytest tests/
black .  # Format code
flake8   # Check style

# Frontend tests
cd app
flutter test
flutter analyze
```

3. **Commit Your Changes**
```bash
# Use conventional commits
git commit -m "feat: add quantum emotion analysis"
git commit -m "fix: resolve websocket connection issue"
git commit -m "docs: update API documentation"
```

**Commit Message Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, missing semi-colons, etc.
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

4. **Push to Your Fork**
```bash
git push origin feature/amazing-feature
```

5. **Submit a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template

## 📝 Pull Request Process

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## How Has This Been Tested?
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests
- [ ] All tests pass locally
- [ ] Any dependent changes have been merged

## Screenshots (if applicable)
Add screenshots for UI changes

## Related Issues
Closes #123
```

### Review Process

1. **Automated Checks**: CI/CD will run tests and linting
2. **Code Review**: At least one maintainer will review
3. **Feedback**: Address any requested changes
4. **Merge**: Once approved, your PR will be merged

## 💅 Style Guides

### Python Style Guide

Follow PEP 8 with these additions:

```python
# Good
class QuantumEmotionProcessor:
    """Process emotions using quantum principles."""
    
    def __init__(self, coherence_threshold: float = 0.85):
        self.coherence_threshold = coherence_threshold
    
    async def process_emotion(
        self,
        emotion_data: Dict[str, Any],
        user_id: str
    ) -> EmotionResult:
        """
        Process emotion data with quantum analysis.
        
        Args:
            emotion_data: Raw emotion input
            user_id: User identifier
            
        Returns:
            Processed emotion result with quantum state
        """
        # Implementation here
        pass
```

**Key Points:**
- Use type hints
- Write docstrings for all public methods
- Use async/await for I/O operations
- Maximum line length: 88 characters (Black formatter)

### Flutter/Dart Style Guide

Follow the official Dart style guide:

```dart
// Good
class EmotionWheel extends StatefulWidget {
  final double initialCoherence;
  final Function(EmotionState) onEmotionSelected;
  
  const EmotionWheel({
    super.key,
    required this.initialCoherence,
    required this.onEmotionSelected,
  });
  
  @override
  State<EmotionWheel> createState() => _EmotionWheelState();
}

class _EmotionWheelState extends State<EmotionWheel> {
  late final AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Widget implementation
  }
}
```

**Key Points:**
- Use `const` constructors where possible
- Prefer single quotes for strings
- Use trailing commas for better formatting
- Follow effective Dart guidelines

### Documentation Style

```markdown
# Feature Name

## Overview
Brief description of what this feature does

## Usage
```python
# Code example
result = quantum_processor.analyze(emotion_data)
```

## API Reference
Document all public APIs

## Examples
Provide practical examples

## See Also
- [Related Feature](link)
- [API Docs](link)
```

## 🧪 Testing Guidelines

### Backend Testing

```python
# tests/test_emotion_engine.py
import pytest
from services.emotion_engine import EmotionEngine

@pytest.fixture
def emotion_engine():
    return EmotionEngine()

@pytest.mark.asyncio
async def test_emotion_analysis(emotion_engine):
    """Test emotion analysis returns valid results."""
    result = await emotion_engine.analyze("I feel happy today")
    
    assert result.primary_emotion == "joy"
    assert 0 <= result.confidence <= 1
    assert result.quantum_state is not None

@pytest.mark.parametrize("input_text,expected_emotion", [
    ("I'm so excited!", "joy"),
    ("This makes me sad", "sadness"),
    ("I'm worried about tomorrow", "fear"),
])
@pytest.mark.asyncio
async def test_emotion_detection(emotion_engine, input_text, expected_emotion):
    """Test emotion detection for various inputs."""
    result = await emotion_engine.analyze(input_text)
    assert result.primary_emotion == expected_emotion
```

### Frontend Testing

```dart
// test/emotion_wheel_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:aurelia_mindscape/widgets/emotion_wheel.dart';

void main() {
  group('EmotionWheel', () {
    testWidgets('displays all emotion categories', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmotionWheel(
              initialCoherence: 0.8,
              onEmotionSelected: (_) {},
            ),
          ),
        ),
      );
      
      expect(find.text('Joy'), findsOneWidget);
      expect(find.text('Sadness'), findsOneWidget);
      expect(find.text('Fear'), findsOneWidget);
    });
    
    testWidgets('triggers callback on emotion selection', (tester) async {
      EmotionState? selectedEmotion;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmotionWheel(
              initialCoherence: 0.8,
              onEmotionSelected: (emotion) {
                selectedEmotion = emotion;
              },
            ),
          ),
        ),
      );
      
      await tester.tap(find.text('Joy'));
      await tester.pumpAndSettle();
      
      expect(selectedEmotion?.name, 'Joy');
    });
  });
}
```

## 🏗 Project Structure

When adding new features, follow this structure:

```
aurelia-mindscape/
├── server/
│   ├── api/              # API endpoints
│   │   └── your_feature.py
│   ├── services/         # Business logic
│   │   └── your_feature_service.py
│   ├── models/           # Database models
│   │   └── your_feature_model.py
│   └── tests/            # Tests
│       └── test_your_feature.py
├── app/
│   ├── lib/
│   │   ├── screens/      # Full screens
│   │   │   └── your_feature_screen.dart
│   │   ├── widgets/      # Reusable widgets
│   │   │   └── your_feature_widget.dart
│   │   ├── providers/    # State management
│   │   │   └── your_feature_provider.dart
│   │   └── services/     # API services
│   │       └── your_feature_service.dart
│   └── test/
│       └── your_feature_test.dart
└── docs/
    └── your_feature.md   # Documentation
```

## 🚀 Release Process

1. **Version Bumping**
```bash
# Backend
# Update server/version.py

# Frontend
# Update pubspec.yaml version
```

2. **Changelog Update**
```markdown
## [1.1.0] - 2024-01-15
### Added
- Quantum emotion entanglement feature
- Collective consciousness visualization

### Fixed
- WebSocket reconnection issue
- Memory leak in emotion wheel

### Changed
- Improved AI response time by 40%
```

3. **Release Notes**
   - Write user-friendly release notes
   - Highlight new features
   - Include migration guides if needed

## 🎓 Learning Resources

### Quantum Computing Concepts
- [Quantum Computing Basics](https://quantum.country/)
- [Qiskit Tutorials](https://qiskit.org/learn/)

### Emotional Intelligence
- [Emotion Recognition Papers](https://paperswithcode.com/task/emotion-recognition)
- [Affective Computing](https://affect.media.mit.edu/)

### Technologies
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Flutter Documentation](https://flutter.dev/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🏆 Recognition

### Contributors
We maintain a list of contributors in [CONTRIBUTORS.md](CONTRIBUTORS.md)

### Contributor Levels
- 🌱 **Seedling**: First PR merged
- 🌿 **Sapling**: 5 PRs merged
- 🌳 **Tree**: 10 PRs merged
- 🌲 **Forest Guardian**: 25 PRs merged
- 🏔️ **Mountain**: 50+ PRs merged

### Special Recognitions
- 🐛 **Bug Hunter**: Found and fixed critical bugs
- 📚 **Documentation Hero**: Significant documentation improvements
- 🎨 **Design Wizard**: Outstanding UI/UX contributions
- 🧪 **Test Champion**: Comprehensive test coverage
- 🌍 **Community Builder**: Helping other contributors

## 💬 Communication Channels

### Development Discussion
- **GitHub Discussions**: Technical discussions
- **Discord #dev**: Real-time development chat
- **Weekly Dev Calls**: Thursdays 3PM UTC

### Getting Help
- **Discord #help**: Quick questions
- **GitHub Issues**: Bug reports and features
- **Email**: dev@aurelia-mindscape.ai

## 📋 Maintainer Checklist

For maintainers reviewing PRs:

- [ ] Code follows project style
- [ ] Tests are included and pass
- [ ] Documentation is updated
- [ ] No security vulnerabilities
- [ ] Performance impact considered
- [ ] Breaking changes documented
- [ ] Changelog updated
- [ ] Version bumped if needed

## 🙏 Thank You!

Your contributions make Aurelia MindScape better for everyone. Whether you're fixing a typo, adding a feature, or helping others, every contribution matters.

Together, we're building something that helps people understand and improve their emotional well-being. That's pretty amazing! 🌟

---

**Questions?** Feel free to ask in Discord or open a discussion on GitHub.

**Happy Contributing!** 🚀