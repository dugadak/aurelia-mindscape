import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:aurelia_mindscape/widgets/emotion_wheel.dart';
import 'package:aurelia_mindscape/widgets/mood_particles.dart';
import 'package:aurelia_mindscape/widgets/quantum_card.dart';
import 'package:aurelia_mindscape/screens/journal_screen.dart';
import 'package:aurelia_mindscape/screens/story_screen.dart';
import 'package:aurelia_mindscape/screens/acoustic_screen.dart';
import 'package:aurelia_mindscape/screens/aria_chat_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> 
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const DashboardPage(),
    const JournalScreen(),
    const StoryScreen(),
    const AcousticScreen(),
    const AriaChatScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A0E21),
                  const Color(0xFF1A1E3A),
                  Colors.deepPurple.shade900.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          // Mood particles background
          const MoodParticles(),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Custom app bar
                _buildAppBar(),
                
                // Page content
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile avatar
          GestureDetector(
            onTap: () => _showProfile(),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.purpleAccent,
                    Colors.blueAccent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
          ).animate().fadeIn().scale(),
          
          // App title
          Text(
            'AURELIA',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w200,
              letterSpacing: 4,
              color: Colors.white.withOpacity(0.9),
            ),
          ).animate().fadeIn(delay: 200.ms).slideX(),
          
          // Notifications
          GestureDetector(
            onTap: () => _showNotifications(),
            child: Stack(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(
                                0.5 + 0.5 * _pulseController.value
                              ),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return GlassContainer.frostedGlass(
      height: 85,
      width: double.infinity,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.05),
          Colors.white.withOpacity(0.02),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: Colors.white.withOpacity(0.1),
      blur: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.dashboard_outlined, 'Home', 0),
          _buildNavItem(Icons.book_outlined, 'Journal', 1),
          _buildNavItem(Icons.auto_stories, 'Story', 2),
          _buildNavItem(Icons.music_note_outlined, 'Sound', 3),
          _buildNavItem(Icons.chat_bubble_outline, 'ARIA', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.purpleAccent.withOpacity(0.2),
                    Colors.blueAccent.withOpacity(0.2),
                  ],
                ),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? Colors.purpleAccent 
                  : Colors.white.withOpacity(0.5),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected 
                    ? Colors.purpleAccent 
                    : Colors.white.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ).animate(target: isSelected ? 1 : 0)
     .scaleXY(end: 1.1, duration: 200.ms);
  }

  void _showProfile() {
    // Navigate to profile
  }

  void _showNotifications() {
    // Show notifications
  }
}

// Dashboard main page
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
            ),
          ).animate().fadeIn().slideX(),
          
          const SizedBox(height: 8),
          
          Text(
            'How are you feeling today?',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(),
          
          const SizedBox(height: 30),
          
          // Emotion wheel
          Center(
            child: const EmotionWheel()
                .animate()
                .fadeIn(delay: 200.ms)
                .scale(),
          ),
          
          const SizedBox(height: 30),
          
          // Quick actions
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ).animate().fadeIn(delay: 300.ms),
          
          const SizedBox(height: 20),
          
          // Action cards grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: [
              _buildActionCard(
                'Record Mood',
                Icons.mic_outlined,
                Colors.purpleAccent,
                () {},
              ).animate().fadeIn(delay: 400.ms).scale(),
              
              _buildActionCard(
                'AI Story',
                Icons.auto_stories,
                Colors.blueAccent,
                () {},
              ).animate().fadeIn(delay: 500.ms).scale(),
              
              _buildActionCard(
                'Meditation',
                Icons.self_improvement,
                Colors.tealAccent,
                () {},
              ).animate().fadeIn(delay: 600.ms).scale(),
              
              _buildActionCard(
                'Chat with ARIA',
                Icons.psychology,
                Colors.pinkAccent,
                () {},
              ).animate().fadeIn(delay: 700.ms).scale(),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Recent insights
          Text(
            'Recent Insights',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ).animate().fadeIn(delay: 800.ms),
          
          const SizedBox(height: 20),
          
          _buildInsightCard().animate().fadeIn(delay: 900.ms).slideY(),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: GlassContainer.frostedGlass(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderColor: color.withOpacity(0.2),
        blur: 10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard() {
    return GlassContainer.frostedGlass(
      height: 120,
      width: double.infinity,
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          Colors.purpleAccent.withOpacity(0.1),
          Colors.blueAccent.withOpacity(0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: Colors.white.withOpacity(0.1),
      blur: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insights,
                  color: Colors.purpleAccent,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'Emotional Pattern Detected',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Your mood tends to improve after morning meditation sessions. Consider making it a daily habit.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}