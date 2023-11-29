import 'dart:convert';

import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LiveController extends GetxController {
  User thisUser = Get.arguments['cUser'];
  String extractedToken = Get.arguments['extractedToken'];
  // String tokenManual =
  //     '007eJxTYOBb8dTtnWUV/4Gwg/buIssyrrv0rfq688bln4vd9kje5XRUYEhJNrU0TE20MEtLTTFJTLOwMDVMMTBIMbGwTE1OTDU1CNqRmNoQyMhw0ek5MyMDBIL4PAxJmSVpmSUV8cmJOTkMDADdGySr';

  late AgoraClient client;
  void onInit() async {
    super.onInit();

    var channelName = thisUser.uid;

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
            appId: appID,
            channelName: 'bitfitx_live',
            tempToken: extractedToken));

    await client!.initialize();
    await firebaseFirestore.collection('liveusers').doc(thisUser.uid).set({
      'token': extractedToken,
      'channelName': 'bitfitx_live',
      'name': thisUser.name,
      'profileImageUrl': thisUser.profileImageUrl,
      'coverImageUrl': thisUser.coverImageUrl
    });
  }

  @override
  void onClose() async {
    super.onClose();
    // dispose the client when done with it
    await firebaseFirestore.collection('liveusers').doc(thisUser.uid).delete();

    client!.release();
  }
}
