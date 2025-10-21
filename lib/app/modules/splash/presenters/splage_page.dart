import 'package:flutter/material.dart';
import 'dart:async';

// IMPORTE AS DEPENDÊNCIAS NECESSÁRIAS
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Certifique-se de que o caminho para seu service locator está correto
import 'package:up_edema/app/modules/core/config/service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final supabase = getIt<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    final session = supabase.auth.currentSession;

    if (session != null) {
      Modular.to.pushReplacementNamed('/home/');
    } else {
      Modular.to.pushReplacementNamed('/landing/');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF009688);
    const backgroundColor = Color(0xFFF0F7F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 5,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _PulsatingCircle(
                      controller: _animationController,
                      size: 300,
                      delay: 0.0,
                    ),
                    _PulsatingCircle(
                      controller: _animationController,
                      size: 250,
                      delay: 0.2,
                    ),
                    _PulsatingCircle(
                      controller: _animationController,
                      size: 200,
                      delay: 0.4,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.health_and_safety,
                            size: 48,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "PPGBiotec",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Up Edema",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Cuidamos da sua saúde",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsatingCircle extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final double delay;

  const _PulsatingCircle({
    required this.controller,
    required this.size,
    this.delay = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final scaleEnd = (delay + 0.6).clamp(0.0, 1.0);
    final fadeEnd = (delay + 0.7).clamp(0.0, 1.0);

    return ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(delay, scaleEnd, curve: Curves.easeInOut),
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(delay, fadeEnd, curve: Curves.easeInOut),
          ),
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF009688).withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
