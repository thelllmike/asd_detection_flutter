import 'package:asd_detection_flutter/screens/splash_screen.dart';
import 'package:asd_detection_flutter/theme/theme.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASD Detection',
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}
