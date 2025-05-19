import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    setupAnimations();
    //navigateToHomeScreen();

  }

  void setupAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    animationController.forward();
  }

  // void navigateToHomeScreen() async {
  //   Future.delayed(const Duration(milliseconds: 1500));
  //   await AuthService.init();
  //
  //   bool hasToken = AuthService.hasToken();
  //
  //   if (hasToken) {
  //     Get.offAllNamed(AppRoute.bottomNevScreen);
  //   } else {
  //     Get.offAllNamed(AppRoute.onboardingScreen);
  //   }
  // }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}