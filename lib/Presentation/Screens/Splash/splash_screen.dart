import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/Presentation/Screens/Onboarding/welcome_to_ncs_screen.dart';

import '../Onboarding/welcome_to_ncs_screen.dart';

/*
Title:SplashScreen
Purpose:To Show a SplashScreen 
Created On:12/06/2024
Edited On:12/06/2024
*/


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTOWelcomeScreen();
  }

  navigateTOWelcomeScreen() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeToNCSScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.blue.shade300,
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          AppImages.logoncsImg,
        ),
      ),
    );
  }
}
