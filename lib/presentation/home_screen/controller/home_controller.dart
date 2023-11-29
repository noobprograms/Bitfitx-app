import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/notification_service.dart';
import 'package:bitfitx_project/data/models/comment_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart' as userModel;
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var notifService = NotificationService();
  var commentController = TextEditingController();
  TextEditingController searchUserInput = TextEditingController();
  RxList searchResults = [].obs;
  List followings = [];

  RxList allUsers = [].obs;
  void openStory(String name, String profileImageUrl, String uid,
      List stories_collection) {
    Get.toNamed(AppRoutes.storyScreen, arguments: {
      'stories_list': stories_collection,
      'name': name,
      'uid': uid,
      'profileImageUrl': profileImageUrl
    });
  }

  void goToMessages(User cUser) {
    Get.toNamed(AppRoutes.chatsScreen, arguments: {'currentUser': cUser});
  }

  void getAllUsers(User cUser) async {
    var data = await firebaseFirestore
        .collection('users')
        .where('uid', isNotEqualTo: cUser.uid)
        .get();

    data.docs.forEach(
      (element) {
        allUsers.add(element.data());
      },
    );
    followings = cUser.following;
  }

  ///////searching functionality////////
  void messageTextChanged(String value) {
    // List<Map<String, dynamic>> results = [];
    // if (value.isEmpty) results = allUsers;

    if (value.isNotEmpty) {
      searchResults.value = allUsers
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      // Filter and add users that match the search query
      searchResults.value = allUsers;
    }

    update();
  }

  void addStory(User cUser, BuildContext ctx) {
    Get.defaultDialog(
        title: "Add Story",
        content: Center(
          child: Column(
            children: [
              CustomElevatedButton(
                width: 200,
                onTap: () {
                  pickStoryFile(cUser, ImageSource.camera, ctx);
                },
                leftIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.camera_alt),
                ),
                text: 'Camera',
                buttonStyle: CustomButtonStyles.fillSecondaryContainer,
                buttonTextStyle: theme.textTheme.headlineSmall!
                    .copyWith(color: Colors.black),
              ),
              CustomElevatedButton(
                width: 200,
                onTap: () {
                  pickStoryFile(cUser, ImageSource.gallery, ctx);
                },
                leftIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.photo),
                ),
                text: 'Gallery',
                buttonStyle: CustomButtonStyles.fillSecondaryContainer,
                buttonTextStyle: theme.textTheme.headlineSmall!
                    .copyWith(color: Colors.black),
              ),
              CustomElevatedButton(
                width: 200,
                onTap: () {
                  Get.back(closeOverlays: true);
                },
                leftIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.cancel),
                ),
                text: 'Cancel',
                buttonStyle: CustomButtonStyles.fillSecondaryContainer,
                buttonTextStyle: theme.textTheme.headlineSmall!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ));
  }

  void pickStoryFile(User cUser, ImageSource src, BuildContext context) async {
    if (src == ImageSource.gallery) {
      final storyAsset = await ImagePicker().pickMedia();

      if (storyAsset != null) {
        Get.offNamed(AppRoutes.confirmStoryScreen,
            arguments: {"file": storyAsset, 'user': cUser});
      }
      ;
    } else {
      final storyAsset = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (storyAsset != null) {
        Get.offNamed(AppRoutes.confirmStoryScreen,
            arguments: {"file": storyAsset, 'user': cUser});
      }
    }
  }

/////////////////////////////post things/////////////////////////////////////////
  Future<Map<String, dynamic>> getUserCred(String uid) async {
    var result;
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => result = value.data()!);
    return result;
  }

  void increaseLikes(String pid, bool isGroup) async {
    if (!isGroup) {
      var result = await firebaseFirestore.collection('posts').doc(pid).get();
      var currentLikes = int.parse(result.data()!['likes']);
      var newLikes = currentLikes + 1;
      await firebaseFirestore
          .collection('posts')
          .doc(pid)
          .update({'likes': (newLikes).toString()});
    } else {
      var result =
          await firebaseFirestore.collection('group_posts').doc(pid).get();
      var currentLikes = int.parse(result.data()!['likes']);
      var newLikes = currentLikes + 1;
      await firebaseFirestore
          .collection('group_posts')
          .doc(pid)
          .update({'likes': (newLikes).toString()});
    }
  }

  ///live
}
