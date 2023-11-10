import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:get/get.dart';
import 'package:agora_uikit/agora_uikit.dart';

class VideoCallController extends GetxController {
  String thisUser = Get.arguments['cUser'].uid;
  String otherUser = Get.arguments['tUser'].uid;
  String chatRoomId = "";

  late AgoraClient client;
  @override
  void onInit() async {
    super.onInit();

    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
      appId: appID,
      channelName: 'bitfitx call',
    ));

    await client.initialize();
  }

  @override
  void onClose() {
    super.onClose();
    // dispose the client when done with it
    client.release();
  }
}
