import 'dart:io';

import 'package:bitfitx_project/core/utils/chat_service.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import '../../../core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/message_model.dart' as msg;

class MediaController extends GetxController {
  VideoPlayerController? videoController;
  late bool isImage;
  late bool isVideo;
  late File assetFile;
  late User thisUser;
  late User thatUser;
  late msg.Type fileType;
  late Duration videoDuration;
  ChatService chatService = ChatService();
  @override
  void onInit() {
    super.onInit();
    fileType = Get.arguments['fileType'];
    isVideo = fileType.name == FileType.video.name;
    isImage = Get.arguments['fileType'] == FileType.image;

    assetFile = Get.arguments['theFile'];
    thisUser = Get.arguments['cUser'];
    thatUser = Get.arguments['tUser'];

    print(isVideo);
    if (isVideo) {
      print('this is a place that should be seen');
      videoController = VideoPlayerController.file(assetFile);
      videoDuration = videoController!.value.duration;
      videoController!.initialize();
      videoController!.play();
      videoController!.setVolume(1);
      videoController!.setLooping(true);
    }
  }

  @override
  void onClose() {
    super.onClose();
    super.dispose();
    videoController?.dispose();
  }

  void sendFile(File myFile) async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Sending...",
        content: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ));

    await chatService
        .sendMessage(thisUser, thatUser, basename(assetFile.path), fileType,
            assetFile.path)
        .then((value) => Get.back(closeOverlays: true));
  }
}
