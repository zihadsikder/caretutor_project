import 'package:caretutor_project/app/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/validators/app_validator.dart';
import '../../../data/common/widgets/custom_text_filed.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends GetView<AuthController> {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
            controller: controller.emailLoginController,
            validator: AppValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.h),
          Obx(() => CustomTextField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            isPassword: controller.isPasswordVisible.value,
            controller: controller.passwordLoginController,
            validator: AppValidator.validatePassword,
            suffixIcon: controller.isPasswordVisible.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          )),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () {
              if (_formKey.currentState!.validate()) {
                controller.signIn();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBackgroundColor: AppColors.secondary.withOpacity(0.5),
            ),
            child: Text(
              controller.isLoading.value ? 'Logging in...' : 'Log in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
