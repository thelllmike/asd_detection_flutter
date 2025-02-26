import 'package:asd_detection_flutter/screens/home_screen.dart';
import 'package:asd_detection_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/logo.png', width: constraints.maxWidth * 0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: loadingColor,
                      valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                      strokeCap: StrokeCap.round,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Loading',
                      style: loadingTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}