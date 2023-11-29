import 'dart:convert';
import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/post_model.dart';
import 'package:bitfitx_project/data/models/reels_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:video_player/video_player.dart';

class AddContentController extends GetxController {
  var assetFile;
  RxBool pictureSelected = false.obs;
  late User currentUser;
  TextEditingController postDescription = TextEditingController();
  // VideoPlayerController? videoController;
  TextEditingController shortCaptionController = TextEditingController();
  late Duration videoDuration;
  void goToMessages(User cUser) {
    Get.toNamed(AppRoutes.chatsScreen, arguments: {'currentUser': cUser});
  }

  void saveUser(User cUser) async {
    currentUser = cUser;
    var tempData;
    await firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((value) => tempData = value.data());
    currentUser = User(
        uid: tempData['uid'],
        name: tempData['name'],
        email: tempData['email'],
        tokenValue: tempData['tokenValue'],
        profileImageUrl: tempData['profileImageUrl'],
        coverImageUrl: tempData['coverImageUrl'],
        fans: tempData['fans'],
        following: tempData['following'],
        posts: tempData['posts']);
  }

  void onInit() async {
    super.onInit();
  }

  //adding posts
  void postAdder(BuildContext context) {
    Get.bottomSheet(
        StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a picture',
                          style:
                              CustomTextStyles.headlineLargeOnPrimaryContainer),
                      IconButton(
                          onPressed: () {
                            assetFile = null;
                            pictureSelected.value = false;
                            postDescription.text = '';
                            Get.close(1);
                          },
                          icon: Icon(Icons.cancel))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: 'Select Picture',
                    width: 200,
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.image);
                      if (result == null) {
                        Get.defaultDialog(
                          title: 'No Image Selected',
                          content: Container(
                            child: Text(
                              'Please Select an Image',
                            ),
                          ),
                        );
                      } else {
                        PlatformFile myFile = result!.files.first;
                        assetFile = File(myFile.path!);
                        pictureSelected.value = true;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  assetFile != null
                      ? Container(child: Image.file(assetFile))
                      : Container(),
                  SizedBox(height: 25),
                  TextField(
                    controller: postDescription,
                    style: TextStyle(color: Colors.black),
                    decoration:
                        InputDecoration(hintText: 'Describe your post...'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: 'Add Post',
                    onTap: () {
                      if (postDescription.text != '' && pictureSelected == true)
                        addPostToCloud();
                      else
                        Get.defaultDialog(
                            title: 'Post could not be uploaded',
                            content: Container(
                              child: Text(
                                  'Either the picture is not selected or the description is not provided..'),
                            ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey);
  }

  void addPostToCloud() async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Uploading...",
      content: Container(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      ),
    );

    ///all the code that i am writing now
    var allPosts = await firebaseFirestore.collection('posts').get();

    var len = allPosts.docs.length;
    var currentPostID = 'post${len}';

    ///

    Reference ref = firebaseStorage
        .ref()
        .child('posts')
        .child(currentUser.uid)
        .child(currentPostID);

    UploadTask uploadTask = ref.putFile(assetFile!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    pictureSelected.value = true;
    final Timestamp timestamp = Timestamp.now();
    var thisPost = Post(
      pid: currentPostID,
      uid: currentUser.uid,
      postPictureUrl: downloadUrl,
      content: postDescription.text,
      dateTime: timestamp,
    );
    await firebaseFirestore
        .collection('posts')
        .doc(currentPostID)
        .set(thisPost.toJson())
        .then((value) async {
      await firebaseFirestore.collection('users').doc(currentUser.uid).update(
        {'posts': (int.parse(currentUser.posts) + 1).toString()},
      );
      assetFile = null;
      postDescription.text = '';
      pictureSelected.value = false;
      Get.close(2);
    });

    // coverImageToDisplay.value = downloadUrl;
  }

  ////////////////for shorts///////////////////////////
  ///
  ///
  void addShort() {
    Get.defaultDialog(
        backgroundColor: Colors.black,
        title: '',
        content: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              pickVideo(ImageSource.gallery);
            },
            icon: Icon(
              Icons.photo,
            ),
            label: Text('Gallery'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              pickVideo(ImageSource.camera);
            },
            icon: Icon(Icons.videocam),
            label: Text('Camera'),
          ),
        ]));
  }

  void pickVideo(ImageSource src) async {
    final video = await ImagePicker().pickVideo(
      source: src,
      maxDuration: Duration(seconds: 30),
    );
    eliteVideoController = VideoPlayerController.file(File(video!.path));
    videoDuration = eliteVideoController!.value.duration;
    eliteVideoController!.initialize();
    eliteVideoController!.play();
    eliteVideoController!.setVolume(1);
    eliteVideoController!.setLooping(true);
    if (video != null) {
      Get.bottomSheet(
          SingleChildScrollView(
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    eliteVideoController!.dispose();
                    shortCaptionController.text = '';
                    Get.close(2);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: mediaQueryData.size.height / 1.5,
                    width: mediaQueryData.size.width,
                    child: VideoPlayer(eliteVideoController!)),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextFormField(
                    autofocus: false,
                    hintText: 'Describe your reel',
                    controller: shortCaptionController,
                    width: 300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomElevatedButton(
                            text: "Upload Reel",
                            width: 150,
                            onTap: () {
                              uploadReel(video.path);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomElevatedButton(
                            text: "Cancel",
                            width: 100,
                            onTap: () {
                              eliteVideoController!.dispose();
                              shortCaptionController.text = '';
                              Get.close(2);
                            },
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          isDismissible: false,
          backgroundColor: Colors.grey,
          enableDrag: false);
    }
  }

  void uploadReel(String vidPath) async {
    Get.defaultDialog(
        title: 'Uploading',
        content: CircularProgressIndicator(),
        barrierDismissible: false);
    var allReels = await firebaseFirestore.collection('reels').get();
    int len = allReels.docs.length;
    String reelId = (len).toString();

    Reference ref = firebaseStorage.ref().child('reels').child(reelId);
    UploadTask uploadTask = ref.putFile(File(vidPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    // final thumbnail = await VideoCompress.getFileThumbnail(vidPath);
    // Reference ref1 = firebaseStorage.ref().child('thumbnails').child(reelId);
    // UploadTask uploadTask1 = ref.putFile(thumbnail);
    // TaskSnapshot snap1 = await uploadTask1;
    // String thumbnailDonwlodUrl = await snap1.ref.getDownloadURL();
    Reel newReel = Reel(
      username: currentUser.name,
      uid: currentUser.uid,
      rid: reelId,
      likes: [],
      commentCount: 0,
      shareCount: 0,
      caption: shortCaptionController.text,
      videoUrl: downloadUrl,
      profilePhoto: currentUser.profileImageUrl,
    );
    await firebaseFirestore
        .collection('reels')
        .doc(reelId)
        .set(newReel.toJson());
    eliteVideoController?.dispose();
    Get.close(3);
  }

  void goLive() async {
    print('the token is to check');
    var result =
        await get(Uri.parse('$baseUrl/bitfitx_live/publisher/userAccount/0/'));
    var extractedToken = jsonDecode(result.body)['rtcToken'];
    Get.toNamed(AppRoutes.liveScreen,
        arguments: {'cUser': currentUser, 'extractedToken': extractedToken});
  }

  @override
  void onClose() {
    super.onClose();
    eliteVideoController?.dispose();
  }
}
