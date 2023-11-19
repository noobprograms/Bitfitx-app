import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/post_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AddContentController extends GetxController {
  var assetFile;
  RxBool pictureSelected = false.obs;
  late User currentUser;
  TextEditingController postDescription = TextEditingController();
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
    var allPosts = await firebaseFirestore
        .collection('posts')
        .doc(currentUser.uid)
        .collection('allPosts')
        .get();

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
    var thisPost = Post(
        pid: currentPostID,
        uid: currentUser.uid,
        postPictureUrl: downloadUrl,
        content: postDescription.text);
    await firebaseFirestore
        .collection('posts')
        .doc(currentUser!.uid)
        .collection('allPosts')
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
}
