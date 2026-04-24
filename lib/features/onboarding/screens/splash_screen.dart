import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/assets_icons.dart';
import 'package:tasky/core/utils/colors_app.dart';
import 'package:tasky/features/onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  //1.5s
  const SplashScreen({super.key});
  static const String routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(
        context,
      ).pushReplacementNamed(OnboardingScreen.routeName),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.primaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: .center,
          children: [
            FadeInLeft(
              duration: Duration(milliseconds: 900),
              child: Image.asset(AssetsIcons.taskIcon),
            ),
            BounceInDown(
              from: 50,
              delay: Duration(milliseconds: 900),
              duration: Duration(milliseconds: 600),
              child: Image.asset(AssetsIcons.yIcon),
            ),
          ],
        ),
      ),
    );
  }
}
