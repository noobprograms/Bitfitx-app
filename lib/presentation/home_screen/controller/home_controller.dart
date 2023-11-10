import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/notification_service.dart';
import 'package:bitfitx_project/data/models/user_model.dart' as userModel;
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var notifService = NotificationService();

  void openStory() {
    Get.toNamed(AppRoutes.storyScreen);
  }

  void goToMessages(User cUser) {
    Get.toNamed(AppRoutes.chatsScreen, arguments: {'currentUser': cUser});
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
}
