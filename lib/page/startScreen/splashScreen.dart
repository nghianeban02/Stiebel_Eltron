import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/screen/login/login_screen.dart';
import '../../config/color.dart';
import '../../screen/start/start_screen.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
  }
  

//Man hinh khoi dong
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: AppColors.white,
    body: Center(
      child: AnimatedSplashScreen(
        splash: Container(
          width: 500, // Adjust the width as needed
          height: 500, // Adjust the height as needed
          child: Image.asset(
            'assets/icon/logo.png',
            fit: BoxFit.cover, // Ensure the image scales correctly
          ),
        ),
        nextScreen: const StartScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.white,
        duration: 3000,
      ),
    ),
      
  );
  }
}
