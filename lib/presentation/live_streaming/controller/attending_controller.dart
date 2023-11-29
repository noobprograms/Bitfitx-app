import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:get/get.dart';

class AttendingLiveController extends GetxController {
  //  User thisUser = Get.arguments['cUser'];
  String channelName = Get.arguments['channelName'];
  String token = Get.arguments['token'];

  late AgoraClient client;
  void onInit() async {
    super.onInit();
    print('the token in attending is$token');
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appID,
        channelName: channelName,
        tempToken: token,
      ),
      agoraChannelData: AgoraChannelData(
        channelProfileType: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleAudience,
      ),
    );
    await client.initialize().then((value) {
      client.sessionController.updateUserVideo(
        uid: client.agoraConnectionData.uid ?? 0,
        videoDisabled: true,
      );
      client.sessionController.updateUserAudio(
          uid: client.agoraConnectionData.uid ?? 0, muted: true);
    });
    client.sessionController.value.copyWith(
        isLocalVideoDisabled:
            !(client.sessionController.value.isLocalVideoDisabled));
    await client.sessionController.value.engine?.muteLocalVideoStream(
        client.sessionController.value.isLocalVideoDisabled);
  }

  @override
  void onClose() async {
    super.onClose();

    client.release();
  }
}
