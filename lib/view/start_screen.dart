
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/onBoarding/onBoardingScreen.dart';

class StartScreen extends StatelessWidget {
  final Widget widget;
   StartScreen(this.widget);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/shopping 1.png",
      nextScreen: widget,
      splashIconSize: 300.r,
      duration: 3,
      splashTransition: SplashTransition.sizeTransition,
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}
