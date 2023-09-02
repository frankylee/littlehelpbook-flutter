import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/theme/lhb_colors.dart';
import 'package:littlehelpbook_flutter/ui/assets/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _redirect();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration(seconds: 2), () async {
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: darkColorScheme.background,
        child: SizedBox(
          width: 240.0,
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(Assets.whiteBirdClinicLogo),
          ),
        ),
      ),
    );
  }
}
