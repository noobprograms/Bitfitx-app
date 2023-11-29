import 'dart:io';

import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/notification_service.dart';
import 'package:bitfitx_project/data/models/group_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/theme/custom_text_style.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';

import 'package:bitfitx_project/widgets/group_requests.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsController extends GetxController {
  var notifService = NotificationService();
  var commentController = TextEditingController();
  TextEditingController searchUserInput = TextEditingController();
  RxList searchResults = [].obs;

  RxList allUsers = [].obs;

  ///group related variables
  ///
  var assetFile;
  RxBool pictureSelected = false.obs;
  TextEditingController groupNameController = TextEditingController();

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
  }

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

  //group related stuffff/////////////////

  void createGroup(User cUser) {
    Get.bottomSheet(
        StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: groupNameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(hintText: 'Name your group'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a Group picture',
                          style:
                              CustomTextStyles.headlineLargeOnPrimaryContainer),
                      // IconButton(
                      //     onPressed: () {
                      //       assetFile = null;
                      //       pictureSelected.value = false;
                      //       postDescription.text = '';
                      //       Get.close(1);
                      //     },
                      //     icon: Icon(Icons.cancel))
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
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: 'Create Group',
                    onTap: () async {
                      if (groupNameController.text != '') {
                        var allGroups =
                            await firebaseFirestore.collection('groups').get();
                        var len = allGroups.docs.length;
                        var groupId = 'Group$len';

                        if (pictureSelected.value == false) {
                          Group newGroup = Group(
                              gid: groupId,
                              groupName: groupNameController.text,
                              adminUid: cUser.uid,
                              members: [cUser.uid],
                              requestingMembers: [],
                              posts: []);
                          await firebaseFirestore
                              .collection('groups')
                              .doc(groupId)
                              .set(newGroup.toJson());
                          groupNameController.text = '';
                          assetFile = null;
                          pictureSelected.value = false;
                          Get.close(1);
                        } else {
                          Reference ref = firebaseStorage
                              .ref()
                              .child('groups')
                              .child(groupId)
                              .child('GroupImage');

                          UploadTask uploadTask = ref.putFile(assetFile!);
                          TaskSnapshot snap = await uploadTask;
                          String downloadUrl = await snap.ref.getDownloadURL();
                          Group newGroup = Group(
                            gid: groupId,
                            groupName: groupNameController.text,
                            adminUid: cUser.uid,
                            members: [],
                            requestingMembers: [],
                            posts: [],
                            groupImageUrl: downloadUrl,
                          );
                          await firebaseFirestore
                              .collection('groups')
                              .doc(groupId)
                              .set(newGroup.toJson());
                          groupNameController.text = '';
                          assetFile = null;
                          pictureSelected.value = false;
                          Get.close(1);
                        }
                        // addPostToCloud();
                      } else
                        Get.defaultDialog(
                            title: 'Group could not be created',
                            content: Container(
                              child: Text(
                                  'Please select a valid name of your group'),
                            ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey);
  }
}
