import 'dart:io';

import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/group_post_model.dart';
import 'package:bitfitx_project/data/models/post_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/theme/custom_text_style.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleGroupViewController extends GetxController {
  var groupName = Get.arguments['groupName'];
  var currentUserId = Get.arguments['myUid'];
  var gid = Get.arguments['gid'];
  late User currentUser;
  var assetFile;
  RxBool pictureSelected = false.obs;
  TextEditingController postDescription = TextEditingController();
  void onInit() async {
    super.onInit();
    var result =
        await firebaseFirestore.collection('users').doc(currentUserId).get();
    currentUser = User(
        uid: result.data()!['uid'],
        name: result.data()!['name'],
        email: result.data()!['email'],
        following: result.data()!['following'],
        fans: result.data()!['fans'],
        tokenValue: result.data()!['tokenValue'],
        posts: result.data()!['posts'],
        wallet: result.data()!['wallet'],
        profileImageUrl: result.data()!['profileImageUrl'],
        coverImageUrl: result.data()!['coverImageUrl']);
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
    var allPosts = await firebaseFirestore.collection('group_posts').get();

    var len = allPosts.docs.length;
    var currentPostID = 'post${len}';

    ///

    Reference ref =
        firebaseStorage.ref().child('posts').child(gid).child(currentPostID);

    UploadTask uploadTask = ref.putFile(assetFile!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    pictureSelected.value = true;
    final Timestamp timestamp = Timestamp.now();
    var thisPost = GroupPost(
      pid: currentPostID,
      uid: currentUserId,
      postPictureUrl: downloadUrl,
      content: postDescription.text,
      dateTime: timestamp,
      gid: gid,
    );
    await firebaseFirestore
        .collection('group_posts')
        .doc(currentPostID)
        .set(thisPost.toJson())
        .then((value) async {
      var res = await firebaseFirestore.collection('groups').doc(gid).get();
      List temp = res.data()!['posts'];
      temp.add(currentPostID);
      await firebaseFirestore
          .collection('groups')
          .doc(gid)
          .update({'posts': temp});
      assetFile = null;
      postDescription.text = '';
      pictureSelected.value = false;
      Get.close(2);
    });

    // coverImageToDisplay.value = downloadUrl;
  }
}
