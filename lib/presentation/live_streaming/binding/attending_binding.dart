import 'package:bitfitx_project/presentation/live_streaming/controller/attending_controller.dart';
import 'package:get/get.dart';

class AttendingLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendingLiveController());
  }
}
