import 'package:caretutor_project/app/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/logo_path.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xffF9D2E0),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.linearGradient,
                ),
              ),
              // Animated logo
              Center(
                child: ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          LogoPath.logoPng,
                          fit: BoxFit.contain,
                          height: 150.h,
                          width: 200.w,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Notes App',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Loading indicator
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: Column(
                    children: [
                      Center(
                        child: SpinKitFadingCircle(
                          color: const Color(0xff760a13),
                          size: 50.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
