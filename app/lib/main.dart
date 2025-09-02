import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aurelia_mindscape/screens/splash_screen.dart';
import 'package:aurelia_mindscape/themes/quantum_theme.dart';
import 'package:aurelia_mindscape/services/consciousness_service.dart';
import 'package:aurelia_mindscape/providers/app_providers.dart';
import 'package:aurelia_mindscape/utils/haptic_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize quantum systems
  await _initializeQuantumCore();
  
  // Lock orientation for optimal neural interface
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(
    const ProviderScope(
      child: AureliaMindScapeApp(),
    ),
  );
}

Future<void> _initializeQuantumCore() async {
  // Initialize Hive for local consciousness storage
  await Hive.initFlutter();
  await Hive.openBox('consciousness_state');
  await Hive.openBox('emotion_cache');
  await Hive.openBox('user_preferences');
  
  // Initialize consciousness service
  await ConsciousnessService.instance.initialize();
  
  // Initialize haptic feedback engine
  HapticEngine.initialize();
}

class AureliaMindScapeApp extends ConsumerWidget {
  const AureliaMindScapeApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final quantumState = ref.watch(quantumStateProvider);
    
    return MaterialApp(
      title: 'Aurelia MindScape',
      debugShowCheckedModeBanner: false,
      theme: QuantumTheme.lightTheme(quantumState),
      darkTheme: QuantumTheme.darkTheme(quantumState),
      themeMode: themeMode,
      home: const QuantumSplashScreen(),
    );
  }
}

// Quantum Splash Screen with consciousness initialization
class QuantumSplashScreen extends StatefulWidget {
  const QuantumSplashScreen({super.key});
  
  @override
  State<QuantumSplashScreen> createState() => _QuantumSplashScreenState();
}

class _QuantumSplashScreenState extends State<QuantumSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _quantumController;
  late AnimationController _consciousnessController;
  late Animation<double> _quantumAnimation;
  late Animation<double> _consciousnessAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _bootConsciousness();
  }
  
  void _initializeAnimations() {
    // Quantum particle animation
    _quantumController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _quantumAnimation = CurvedAnimation(
      parent: _quantumController,
      curve: Curves.easeInOutQuart,
    );
    
    // Consciousness emergence animation
    _consciousnessController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _consciousnessAnimation = CurvedAnimation(
      parent: _consciousnessController,
      curve: Curves.easeInOut,
    );
    
    _quantumController.forward();
    _consciousnessController.forward();
  }
  
  Future<void> _bootConsciousness() async {
    // Simulate consciousness boot sequence
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MindScapeHome(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }
  
  @override
  void dispose() {
    _quantumController.dispose();
    _consciousnessController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Quantum field background
          _buildQuantumField(),
          
          // Logo and loading
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo
                AnimatedBuilder(
                  animation: _quantumAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _quantumAnimation.value,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.purpleAccent.withOpacity(0.8),
                              Colors.blueAccent.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            stops: const [0.3, 0.6, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.psychology_alt,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // App name with animation
                AnimatedBuilder(
                  animation: _consciousnessAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _consciousnessAnimation.value,
                      child: Column(
                        children: [
                          Text(
                            'AURELIA',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 8,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Text(
                            'MINDSCAPE',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 12,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 60),
                
                // Loading indicator
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.purpleAccent.withOpacity(0.8),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Text(
                  'Initializing Consciousness...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuantumField() {
    return AnimatedBuilder(
      animation: _quantumAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: QuantumFieldPainter(
            animation: _quantumAnimation.value,
          ),
        );
      },
    );
  }
}

// Quantum field painter for background
class QuantumFieldPainter extends CustomPainter {
  final double animation;
  
  QuantumFieldPainter({required this.animation});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    
    // Draw quantum particles
    for (int i = 0; i < 50; i++) {
      final x = (size.width * (i % 10) / 10) + 
                (size.width * 0.05 * animation);
      final y = (size.height * (i ~/ 10) / 5) + 
                (size.height * 0.1 * animation);
      
      paint.color = Colors.purpleAccent.withOpacity(0.3 * animation);
      canvas.drawCircle(
        Offset(x, y),
        3 * animation,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Main home screen placeholder
class MindScapeHome extends StatelessWidget {
  const MindScapeHome({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to Aurelia MindScape'),
      ),
    );
  }
}