import 'package:caretutor_project/app/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/validators/app_validator.dart';
import '../../../data/common/widgets/custom_text_filed.dart';
import '../controllers/auth_controller.dart';

class SignupForm extends GetView<AuthController> {
  SignupForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final RxString _password = ''.obs;
  final RxInt _strength = 0.obs;

  String get _strengthText {
    if (_password.isEmpty) {
      return 'Very Weak';
    }
    switch (_strength.value) {
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Moderate';
      case 4:
        return 'Strong';
      case 5:
        return 'Very Strong';
      default:
        return 'Very Weak';
    }
  }

  void _updatePasswordStrength(String password) {
    _password.value = password;

    if (password.isEmpty) {
      _strength.value = 0;
    } else if (password.length < 4) {
      _strength.value = 1;
    } else if (password.length < 8) {
      _strength.value = 2;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      _strength.value = 3;
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      _strength.value = 4;
    } else {
      _strength.value = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            hintText: 'Full Name',
            prefixIcon: Icons.person_outline,
            controller: controller.nameRegisterController,
            validator: (value) => AppValidator.validateRequired(value, 'Name'),
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
            controller: controller.emailRegisterController,
            validator: AppValidator.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.h),
          CustomTextField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: controller.passwordRegisterController,
            validator: AppValidator.validatePassword,
            onChanged: _updatePasswordStrength,
          ),
          SizedBox(height: 10.h),
          Obx(() {
            if (_password.isEmpty) {
              return const SizedBox.shrink();
            }
            return Row(
              children: [
                Text(
                  _strengthText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Container(
                        width: 45.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: index < _strength.value
                              ? AppColors.secondary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 30.h),
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () {
              if (_formKey.currentState!.validate()) {
                controller.signUp(context); // Pass context
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
              controller.isLoading.value ? 'Signing up...' : 'Sign up',
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