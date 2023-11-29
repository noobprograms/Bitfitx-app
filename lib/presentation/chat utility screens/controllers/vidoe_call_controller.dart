import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_token_service/agora_token_service.dart';

class VideoCallController extends GetxController {
  User thisUser = Get.arguments['cUser'];
  User otherUser = Get.arguments['tUser'];
  String callToken = Get.arguments['callToken'];
  RxInt remoteUid = 101.obs;
  RxBool localUserJoined = false.obs;
  String chatRoomId = "";
  late AgoraClient client;

  @override
  void onInit() async {
    super.onInit();
    var ids = [thisUser.uid, otherUser.uid];
    ids.sort();
    chatRoomId = ids.join("-");
    final expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;
    final token = RtcTokenBuilder.build(
        appId: appID,
        appCertificate: appCertificate,
        channelName: chatRoomId,
        role: RtcRole.subscriber,
        expireTimestamp: expireTimestamp,
        uid: thisUser.uid);
    print("the token is $chatRoomId");

    print("the token is ${token}");
    // var result =
    //     await firebaseFirestore.collection('users').doc(otherUser.uid).get();
    // if (result.data()!['videoCallingToken'] == 'none') {
    //   client = AgoraClient(
    //       agoraConnectionData: AgoraConnectionData(
    //           appId: appID, channelName: 'bitfitx_call', tempToken: token));
    //   await firebaseFirestore
    //       .collection('users')
    //       .doc(thisUser.uid)
    //       .update({'videoCallingToken': token});
    // } else
    //   client = AgoraClient(
    //       agoraConnectionData: AgoraConnectionData(
    //           appId: appID,
    //           channelName: 'bitfitx_call',
    //           tempToken: result.data()!['videoCallingToken']));

    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
            appId: appID, channelName: 'bitfitx_call', tempToken: callToken));
    await client.initialize();
  }

  @override
  void onClose() async {
    super.onClose();
    // dispose the client when done with it
    await firebaseFirestore
        .collection('users')
        .doc(thisUser.uid)
        .update({'videoCallingToken': 'none'});
    await firebaseFirestore
        .collection('users')
        .doc(otherUser.uid)
        .update({'videoCallingToken': 'none'});
    client!.release();
  }
}



  // Future<void> _initEngine() async {
  //   engine = await createAgoraRtcEngine();
  //   await engine.initialize(const RtcEngineContext(
  //     appId: appID,
  //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //   ));

  //   await engine.enableVideo();
  //   await engine.startPreview();
  //   var token = await generateToken(chatRoomId, 0, 5000, 1);
  //   await engine.joinChannel(
  //       token: token,
  //       channelId: chatRoomId,
  //       uid: 0,
  //       options: const ChannelMediaOptions());

  //   engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         debugPrint("local user ${connection.localUid} joined");

  //         localUserJoined.value = true;
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteuid, int elapsed) {
  //         debugPrint("remote user $remoteuid joined");

  //         remoteUid!.value = remoteuid;
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteuid,
  //           UserOfflineReasonType reason) {
  //         debugPrint("remote user $remoteuid left channel");

  //         remoteUid!.value = 101;
  //       },
  //       onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
  //         debugPrint(
  //             '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
  //       },
  //     ),
  //   );
  // }

  // Future<void> switchCamera() async {
  //   await engine.switchCamera();
  // }

  // Future<void> leaveChannel() async {
  //   await engine.leaveChannel();
  // }

  // @override
  // void onClose() async {
  //   await engine.leaveChannel();
  //   await engine.release();
  //   super.onClose();
  // }

