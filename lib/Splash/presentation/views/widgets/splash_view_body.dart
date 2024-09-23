import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/assets.dart';
import 'package:movie_app/movies/presentation/screens/movies_screen.dart';

import '../../../../curved_navigation_bar/presentaion/screens/navigation_curved_bar.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _textOpacityAnimation;
  bool _imageAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(-0.1, 0.0),
    ).animate(_controller);

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _imageAnimationCompleted = true;
        });
      }
    });

    Future.delayed(
      const Duration(milliseconds: 3300), // or any duration you want
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CurvedNavigationBarScreen(),
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation,
              child: Image.asset(
                AssetsData.logo,
                scale: 2,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _imageAnimationCompleted ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  'Your Movie',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
