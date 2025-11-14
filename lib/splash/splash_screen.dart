import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;
  late final Animation<Offset> _titleOffset;
  late final Animation<double> _titleOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _titleOffset = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic)),
    );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();

    // Navigate to HomePage after a short pleasant delay
    Timer(const Duration(milliseconds: 2200), () {
      Get.off(() => const HomePage(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 300));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLogo(Color primary) {
    return ScaleTransition(
      scale: _scale,
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                primary.withOpacity(0.22),
                primary.withOpacity(0.06),
                Colors.transparent,
              ],
              stops: const [0.4, 0.7, 1.0],
            ),
            border: Border.all(color: primary.withOpacity(0.6), width: 1.2),
          ),
          child: Center(
            child: Icon(Icons.psychology_alt_rounded, color: primary, size: 40),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B1020), Color(0xFF101632)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(primary),
                const SizedBox(height: 18),
                FadeTransition(
                  opacity: _titleOpacity,
                  child: SlideTransition(
                    position: _titleOffset,
                    child: Column(
                      children: [
                        Text(
                          'Brain Denner',
                          style: TextStyle(
                            color: cs.onBackground,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Think sharper. Work smarter.',
                          style: TextStyle(
                            color: cs.onBackground.withOpacity(0.9),
                            fontSize: 14,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}