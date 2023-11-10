import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A controller class for the SignUpScreen.
///
/// This class manages the state of the SignUpScreen, including the
/// current signUpModelObj
class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  void signUp() {
    Get.put(AuthController());
    if (passwordController.text == confirmpasswordController.text)
      authController.register(
          emailController.text, passwordController.text, nameController.text);
    else
      Get.snackbar(
          'Unmatched Passwords', 'The passwords you entered do not match',
          snackPosition: SnackPosition.BOTTOM);
  }

  void goToSignIn() {
    Get.offNamed(AppRoutes.loginScreen);
  }

  void googleSignIn() {
    Get.put(AuthController());
    authController.signInWithGoogle();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }
}
