import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_version_provider.dart';
import 'package:littlehelpbook_flutter/shared/assets/assets.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _redirect();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
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

  Future<void> _redirect() async {
    // If the app has an update, redirect to App Update screen. Otherwise, go Home.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appVersionProvider.future).then(
            (value) async => await Future.delayed(
              Duration(seconds: 2),
              () => value == AppVersionEnum.current
                  ? const HomeRoute().go(context)
                  : const AppUpdateRoute().go(context),
            ),
          );
    });
  }
}
