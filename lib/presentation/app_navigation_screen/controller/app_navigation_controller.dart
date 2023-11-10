import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/presentation/app_navigation_screen/models/app_navigation_model.dart';
import 'package:get/get.dart';

/// A controller class for the AppNavigationScreen.
///
/// This class manages the state of the AppNavigationScreen, including the
/// current appNavigationModelObj
class AppNavigationController extends GetxController {
  Rx<AppNavigationModel> appNavigationModelObj = AppNavigationModel().obs;
}
