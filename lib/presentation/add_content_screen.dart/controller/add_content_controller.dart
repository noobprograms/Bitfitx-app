import 'dart:io';

import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContentController extends GetxController {
  File? assetFile;
  bool pictureSelected = false;
  void goToMessages(User cUser) {
    Get.toNamed(AppRoutes.chatsScreen, arguments: {'currentUser': cUser});
  }

  //adding posts
  void postAdder() {
    Get.bottomSheet(Column(
      children: [
        Text('Add a picture'),
        CustomElevatedButton(
          text: 'Select Picture',
          width: 100,
        ),
        pictureSelected ? Image.file(assetFile!) : null,
      ],
    ));
  }
}
