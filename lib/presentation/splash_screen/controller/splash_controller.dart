import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/firebase_options.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  @override
  void onReady() async {
    await Future.delayed(Duration(milliseconds: 3000), () async {
      Get.put(AuthController());

      // Get.offNamed(AppRoutes.signupLoginScreen);
    });
  }
}
