// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:schedlk/layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
        splash: Image.asset('assets/111.png'),

         nextScreen: HomeLayOut(),
             splashTransition: SplashTransition.rotationTransition,
             backgroundColor: Colors.white,
          splashIconSize: 300,
    )

    );
  }
}
