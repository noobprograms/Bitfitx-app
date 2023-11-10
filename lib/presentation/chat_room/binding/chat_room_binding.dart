import 'package:bitfitx_project/presentation/chat_room/controller/chat_room_controller.dart';
import 'package:get/get.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
