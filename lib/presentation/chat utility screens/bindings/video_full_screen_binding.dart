import 'package:bitfitx_project/presentation/chat%20utility%20screens/controllers/video_controller.dart';
import 'package:get/get.dart';

class VideoFullBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoController());
  }
}
