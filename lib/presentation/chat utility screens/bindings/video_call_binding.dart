import 'package:bitfitx_project/presentation/chat%20utility%20screens/controllers/vidoe_call_controller.dart';
import 'package:get/get.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoCallController());
  }
}
