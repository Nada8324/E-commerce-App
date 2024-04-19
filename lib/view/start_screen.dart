
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectx_task_shopapp/view/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../shared/styles/icon_broken.dart';
import 'onBoardingScreen.dart';

class StartScreen extends StatelessWidget {
   StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/shopping 1.png",
      nextScreen: OnBoardingScreen(),
      splashIconSize: 300.r,
      duration: 3,
      splashTransition: SplashTransition.sizeTransition,
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}
