import 'package:bitfitx_project/core/app_export.dart';
import 'package:get/get.dart';

/// A controller class for the SignupLoginScreen.
///
/// This class manages the state of the SignupLoginScreen, including the
/// current signupLoginModelObj
class SignupLoginController extends GetxController {
  void switchScreen(int k) {
    if (k == 1)
      Get.toNamed(AppRoutes.loginScreen);
    else
      Get.toNamed(AppRoutes.signUpScreen);
  }
}
