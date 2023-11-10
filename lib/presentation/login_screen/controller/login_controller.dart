import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void goToSignUp() {
    Get.toNamed(AppRoutes.signUpScreen);
  }

  void login() {
    Get.put(AuthController());
    authController.login(
        emailController.text.trim(), passwordController.text.trim());
  }

  void googleSignIn() {
    Get.put(AuthController());
    authController.signInWithGoogle();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
