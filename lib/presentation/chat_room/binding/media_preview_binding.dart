import 'package:bitfitx_project/presentation/chat_room/controller/media_preview_controller.dart';
import 'package:get/get.dart';

class MediaPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MediaController());
  }
}
