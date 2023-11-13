import 'package:bitfitx_project/presentation/chat%20utility%20screens/controllers/voice_call_controller.dart';
import 'package:get/get.dart';

class VoiceCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoiceCallController());
  }
}
