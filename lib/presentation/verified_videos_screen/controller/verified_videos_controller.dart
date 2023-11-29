import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/notification_service.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifiedVidController extends GetxController {
  var notifService = NotificationService();
  // var commentController = TextEditingController();
  TextEditingController searchUserInput = TextEditingController();
  RxList searchResults = [].obs;

  RxList allUsers = [].obs;

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
}
