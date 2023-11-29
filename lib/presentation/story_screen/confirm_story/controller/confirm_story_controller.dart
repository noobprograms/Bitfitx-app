import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/story_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmStoryController extends GetxController {
  VideoPlayerController? videoController;
  late bool isVideo;
  late File assetFile;
  late User thisUser;
  late Duration videoDuration;
  void cheker(String asset) {
    print(asset);
  }

  @override
  void onInit() {
    super.onInit();

    isVideo = Get.arguments['file']!.path.contains('.mp4');
    assetFile = File(Get.arguments['file']!.path);
    cheker(assetFile.path);
    thisUser = Get.arguments['user'];

    if (isVideo) {
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
    videoController?.dispose();
  }

  Future<String> _uploadStoryToStorage(String id, File asset) async {
    Reference ref = firebaseStorage.ref().child('stories').child(id);

    UploadTask uploadTask = ref.putFile(asset);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadStory(BuildContext context, File asset) async {
    try {
      // get id
      Get.defaultDialog(
          title: 'Uploading Story',
          content: CircularProgressIndicator(),
          barrierDismissible: false);
      var allDocs = await firebaseFirestore.collection('stories').get();
      int len = allDocs.docs.length;
      String newId = "Story $len";
      String storyUrl = await _uploadStoryToStorage(newId, asset);
      MediaType mediaType;
      Duration storyDuration = Duration(seconds: 15);
      if (isVideo) {
        mediaType = MediaType.video;
        if (videoDuration < storyDuration) storyDuration = videoDuration;
      } else
        mediaType = MediaType.image;

      Story story = Story(
          sid: newId,
          url: storyUrl,
          media: mediaType,
          duration: storyDuration,
          name: thisUser.name,
          profileImageUrl: thisUser.profileImageUrl,
          uid: thisUser.uid,
          timeUploaded: Timestamp.now());

      await firebaseFirestore.collection('stories').doc(newId).set(
            story.toJson(),
          );
      var previousStories;
      var result = await firebaseFirestore
          .collection('stories_live')
          .doc(thisUser.uid)
          .get();
      if (result.exists) {
        previousStories = result.data()!['stories'];
        previousStories.add(newId);
        await firebaseFirestore
            .collection('stories_live')
            .doc(thisUser.uid)
            .update({'stories': previousStories});
      } else {
        previousStories = [newId];
        await firebaseFirestore
            .collection('stories_live')
            .doc(thisUser.uid)
            .set({
          'name': thisUser.name,
          'profileImageUrl': thisUser.profileImageUrl,
          'uid': thisUser.uid,
          'stories': previousStories
        });
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(thisUser),
        ),
        ModalRoute.withName('/tabbed_screen'),
      );
    } catch (e) {
      Get.snackbar(
        'Error Uploading Story',
        e.toString(),
      );
    }
  }
}
