import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_to_do/featuers/auth/presentation/screens/auth_selection_screen.dart';
import 'package:how_to_do/featuers/select_lang/presentation/screens/select_language_screen.dart';

import '../../../auth/presentation/blocs/auth/bloc/auth_bloc.dart';
import '../../../home/presentation/screens/home_screen.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key, required this.child, required this.endWidget});
  final Widget child;
  final Widget endWidget;

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 3), // Duration of the animation
      vsync: this,
    );

    // Scale animation: scales from 0 to 200
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));

    // Rotation animation: Spins several times
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 10 * 3.1416,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Fade animation: Fades out the widget
    _fadeController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Start the animation when the screen is loaded
    _controller.forward(); // This will run the animation only once

    // Stop the spinning smoothly when the scale reaches 200
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () => _fadeController.forward());

        _fadeController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder:
                      (context) => BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthFirstRun) {
                            return SelectLanguageScreen();
                          } else if (state is AuthInitial) {
                            return Scaffold(body: Center(child: CircularProgressIndicator()));
                          } else if (state is Authenticated) {
                            return HomeScreen();
                          } else {
                            return AuthSelectionScreen();
                          }
                        },
                      ),
                ),
                (route) => false,
              );
            });
          }
        });

        // After the animation completes, navigate to the next screen
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: SizedBox(height: 200, width: 20)),
            Expanded(
              flex: 1,
              child: AnimatedBuilder(
                animation: _controller,

                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.identity()
                          ..scale(_scaleAnimation.value / 100) // Scaling the widget
                          ..rotateZ(_rotationAnimation.value), // Applying the rotation
                    child: widget.child,
                  );
                },
              ),
            ),

            Expanded(
              flex: 1,
              child: FadeTransition(opacity: _fadeAnimation, child: widget.endWidget),
            ),
          ],
        ),
      ),
    );
  }
}
