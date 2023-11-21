import 'dart:async';
import 'dart:math';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VoiceCallController extends GetxController {
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
          '007eJxTYAju07Uu1H/0t9Yp96efa+/NN88UlEqOrXSbuf135sUrj3sVGFKSTS0NUxMtzNJSU0wS0ywsTA1TDAxSTCwsU5MTU00NjpfFpDYEMjIcazNgZmSAQBCfhyEpsyQts6RCITkxJ4eBAQA4OCVu',
    ));

    await client.initialize().then((value) => client.sessionController
        .updateUserVideo(
            uid: client.agoraConnectionData.uid ?? 0, videoDisabled: true));
    client.sessionController.value.copyWith(
        isLocalVideoDisabled:
            !(client.sessionController.value.isLocalVideoDisabled));
    await client.sessionController.value.engine?.muteLocalVideoStream(
        client.sessionController.value.isLocalVideoDisabled);
  }

  @override
  void onClose() {
    super.onClose();
    // dispose the client when done with it
    client.release();
  }
}
