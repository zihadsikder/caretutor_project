import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../data/common/widgets/app_snackber.dart';
import '../../../services/auth_services.dart';

class AuthController extends GetxController {
  // Login controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // Register controllers
  final TextEditingController nameRegisterController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController = TextEditingController();

  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn() async {
    // Input validation
    String email = emailLoginController.text.trim();
    String password = passwordLoginController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppSnackBar.showError('Email and password cannot be empty.');
      return;
    }

    isLoading.value = true;

    try {
      Get.dialog(
          Center(
            child: SpinKitFadingCircle(
              color: AppColors.secondary,
              size: 40,
            ),
          ),
          barrierDismissible: false
      );

      await AuthService.signInWithEmailAndPassword(email, password);

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      GoRouter.of(Get.context!).go('/home');

    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      String errorMessage = 'An error occurred during sign in.';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      AppSnackBar.showError(errorMessage);
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      AppSnackBar.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    // Input validation
    String name = nameRegisterController.text.trim();
    String email = emailRegisterController.text.trim();
    String password = passwordRegisterController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppSnackBar.showError('All fields are required.');
      return;
    }

    isLoading.value = true;

    try {
      Get.dialog(
          Center(
            child: SpinKitFadingCircle(
              color: AppColors.secondary,
              size: 40,
            ),
          ),
          barrierDismissible: false
      );

      await AuthService.createUserWithEmailAndPassword(email, password);

      // Update user profile with name
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      GoRouter.of(Get.context!).go('/home');

    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      String errorMessage = 'An error occurred during registration.';

      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      AppSnackBar.showError(errorMessage);
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      AppSnackBar.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    nameRegisterController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    super.onClose();
  }
}
