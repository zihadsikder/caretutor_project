import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../services/auth_services.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    setupAnimations();
    navigateToNextScreen();
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

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    final hasToken = AuthService.hasToken();

    // Wait for Get.context to be available
    while (Get.context == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Now it's safe to navigate
    if (hasToken) {
      GoRouter.of(Get.context!).go('/home');
    } else {
      GoRouter.of(Get.context!).go('/auth');
    }
  }

    @override
    void onClose() {
      animationController.dispose();
      super.onClose();
    }
  }
