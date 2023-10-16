import 'dart:async';
import 'package:chatapp/ui/views/bottomnavbar/bottomnavbar.dart';
import 'package:chatapp/ui/views/introscreens/intromain.dart';
import 'package:chatapp/ui/views/proflescreens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();

    Timer(
      Duration(seconds: 4),
      () {
        // Navigate to the next screen or perform an action
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => /* OnboardingScreen() */BottomNavBar()),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36B8B8),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/splashscreen.png', // Replace with your background image
            fit: BoxFit.cover,
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset("assets/images/splashscreen1.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
