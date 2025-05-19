import 'package:caretutor_project/app/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../data/common/widgets/custom_text.dart';
import '../controllers/auth_controller.dart';
import '../controllers/auth_tab_controller.dart';
import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthTabController authTabController = Get.find<AuthTabController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              CustomText(
                text: 'Notes App',
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: 'Your personal note-taking companion',
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 40.h),
              // Tabs
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: TabBar(
                  controller: authTabController.tabController,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.secondary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
                  tabs: const [
                    Tab(text: 'Log in'),
                    Tab(text: 'Sign up'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: authTabController.tabController,
                  children: [
                    LoginForm(),
                    SignupForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
