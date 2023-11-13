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
            tempToken:
                '007eJxTYLj84OFy8RvTlRdpf9/nEfx9uag8U3C/1P/ZUlyigkzpmyMUGFKSTS0NUxMtzNJSU0wS0ywsTA1TDAxSTCwsU5MTU00NHtzxTW0IZGRozl3BzMgAgSA+D0NSZklaZkmFQnJiTg4DAwA8MyI3'));

    await client.initialize();
  }

  @override
  void onClose() {
    super.onClose();
    // dispose the client when done with it
    client.release();
  }
}
