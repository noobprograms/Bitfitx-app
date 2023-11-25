import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/reels_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class ReelsController extends GetxController {
  final Rx<List<Reel>> _videoList = Rx<List<Reel>>([]);

  List<Reel> get videoList => _videoList.value;
  TextEditingController commentController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();

    _videoList.bindStream(firebaseFirestore
        .collection('reels')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Reel> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Reel.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  @override
  void onClose() {
    super.onClose();
  }

  likeVideo(String id, String uid) async {
    DocumentSnapshot doc =
        await firebaseFirestore.collection('reels').doc(id).get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFirestore.collection('reels').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebaseFirestore.collection('reels').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
