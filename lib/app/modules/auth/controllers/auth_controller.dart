import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/app_colors.dart';
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

  // Store error message to display
  final errorMessage = Rx<String?>(null);

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn(BuildContext context) async {
    // Reset error message
    errorMessage.value = null;

    // Input validation
    String email = emailLoginController.text.trim();
    String password = passwordLoginController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Email and password cannot be empty.';
      return;
    }

    isLoading.value = true;

    try {
      // Show loading dialog
      Get.dialog(
        Center(
          child: SpinKitFadingCircle(
            color: AppColors.secondary,
            size: 40,
          ),
        ),
        barrierDismissible: false,
      );

      await AuthService.signInWithEmailAndPassword(email, password);

      // Close loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      // Navigate to home
      if (context.mounted) {
        GoRouter.of(context).go('/home');
      }

    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      String message = 'An error occurred during sign in.';

      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }

      errorMessage.value = message;
      print('Login error: $message');
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      print('Unexpected login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(BuildContext context) async {
    // Reset error message
    errorMessage.value = null;

    // Input validation
    String name = nameRegisterController.text.trim();
    String email = emailRegisterController.text.trim();
    String password = passwordRegisterController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = 'All fields are required.';
      return;
    }

    isLoading.value = true;

    try {
      // Show loading dialog
      Get.dialog(
        Center(
          child: SpinKitFadingCircle(
            color: AppColors.secondary,
            size: 40,
          ),
        ),
        barrierDismissible: false,
      );

      UserCredential userCredential = await AuthService.createUserWithEmailAndPassword(email, password);

      // Update user profile with name
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
      }

      // Close loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      // Navigate to home
      if (context.mounted) {
        GoRouter.of(context).go('/home');
      }

    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      String message = 'An error occurred during registration.';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }

      errorMessage.value = message;
      print('Signup error: $message');
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      print('Unexpected signup error: $e');
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