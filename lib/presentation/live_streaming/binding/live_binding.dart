import 'package:bitfitx_project/presentation/live_streaming/controller/live_controller.dart';
import 'package:get/get.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveController());
  }
}
