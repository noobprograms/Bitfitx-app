import '../controller/signup_login_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SignupLoginScreen.
///
/// This class ensures that the SignupLoginController is created when the
/// SignupLoginScreen is first loaded.
class SignupLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupLoginController());
  }
}
