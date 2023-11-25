import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AccountController extends GetxController {
  User? currentUser;
  RxString coverImageToDisplay = ImageConstant.imageNotFound.obs;
  RxString? profileImageToDisplay;
  RxBool coverImageExists = false.obs;
  RxBool isFollowed = false.obs;
  var myUser;
  void onInit() async {
    super.onInit();
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
    print("Iam ${currentUser!.posts}");
    profileImageToDisplay?.value = currentUser!.profileImageUrl;
    if (currentUser!.coverImageUrl != '') {
      coverImageToDisplay.value = currentUser!.coverImageUrl;
      coverImageExists.value = true;
    } else {
      coverImageToDisplay.value = ImageConstant.imageNotFound;
    }
  }

  void editProfilePictures() {
    Get.bottomSheet(SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cover Image',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: coverImageExists.value
                      ? NetworkImage(coverImageToDisplay.value)
                      : AssetImage(coverImageToDisplay.value) as ImageProvider,
                )),
          ),
          SizedBox(height: 16),
          CustomElevatedButton(
            text: 'Change Cover Image',
            width: 300,
            buttonStyle: CustomButtonStyles.fillGreen,
            onTap: () {
              showFilePicker(FileType.image, 'cover');
            },
          ),
          SizedBox(height: 20),
          // Text(
          //   'Profile Image',
          //   style: TextStyle(
          //       color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          // Container(
          //   padding: EdgeInsets.only(top: 20),
          //   width: 300,
          //   height: 200,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(25),
          //       image: DecorationImage(
          //         image: NetworkImage(currentUser!.profileImageUrl),
          //       )),
          // ),
          // SizedBox(height: 16),
          // CustomElevatedButton(
          //   text: 'Change Profile Image',
          //   width: 300,
          //   buttonStyle: CustomButtonStyles.fillGreen,
          //   onTap: () {
          //     showFilePicker(FileType.image, 'profile');
          //   },
          // ),
        ],
      ),
    ));
  }

  void showFilePicker(FileType fileType, String cover) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Uploading...",
        content: Container(
            height: 100, width: 100, child: CircularProgressIndicator()));
    if (result == null) return;
    PlatformFile myFile = result!.files.first;
    File fileToUpload = File(myFile.path!);

    if (cover == 'cover') {
      Reference ref = firebaseStorage
          .ref()
          .child('pictures')
          .child(currentUser!.coverImageUrl)
          .child('coverPicture');

      // if (coverImageToDisplay.value != 'assets/images/image_not_found.png') {
      //   await firebaseStorage.refFromURL(coverImageToDisplay.value).delete();
      // }

      UploadTask uploadTask = ref.putFile(fileToUpload);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      coverImageToDisplay.value = downloadUrl;
      await firebaseFirestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'coverImageUrl': downloadUrl}).then((value) => Get.back());
    } else {
      Reference ref = firebaseStorage
          .ref()
          .child('pictures')
          .child(currentUser!.uid)
          .child('profilepicture');

      UploadTask uploadTask = ref.putFile(fileToUpload);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      profileImageToDisplay?.value = downloadUrl;
      await firebaseFirestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'profileImageUrl': downloadUrl});
    }

    ///any removing function
  }

  //to get the current user
  // void saveUser(User cUser) {
  //   currentUser = User(
  //       uid: cUser.uid,
  //       name: cUser.name,
  //       email: cUser.email,
  //       tokenValue: cUser!.tokenValue,
  //       coverImageUrl: cUser.coverImageUrl,
  //       profileImageUrl: cUser.profileImageUrl,
  //       following: cUser.following,
  //       fans: cUser.fans,
  //       posts: cUser.posts);

  //   if (currentUser?.coverImageUrl == '') {
  //     coverImageToDisplay.value = ImageConstant.imageNotFound;
  //   } else {
  //     coverImageToDisplay.value = cUser.coverImageUrl;
  //     coverImageExists = true;
  //   }
  // }
}
