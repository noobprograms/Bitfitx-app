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
                '007eJxTYAju07Uu1H/0t9Yp96efa+/NN88UlEqOrXSbuf135sUrj3sVGFKSTS0NUxMtzNJSU0wS0ywsTA1TDAxSTCwsU5MTU00NjpfFpDYEMjIcazNgZmSAQBCfhyEpsyQts6RCITkxJ4eBAQA4OCVu'));

    await client.initialize();
  }

  @override
  void onClose() {
    super.onClose();
    // dispose the client when done with it
    client.release();
  }
}
