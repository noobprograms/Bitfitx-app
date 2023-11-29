import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/add_content_screen.dart/controller/add_content_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContentScreen extends StatelessWidget {
  AddContentScreen(this.cUser, {super.key});
  final User cUser;

  @override
  Widget build(BuildContext context) {
    AddContentController controller = Get.put(AddContentController());
    controller.saveUser(cUser);
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leadingWidth: 47.h,
        leading: InkWell(
          onTap: () {},
          child: CustomImageView(
            imagePath: ImageConstant.search,
            margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
          ),
        ),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Get.put(AuthController());
            authController.signOut();
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgRemoval1,
            width: 60.h,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              controller.goToMessages(cUser);
            },
            child: CustomImageView(
              imagePath: ImageConstant.chat,
              margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
            ),
          )
        ],
      ),
      body: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        padding: EdgeInsets.only(top: 68.v),
        decoration: AppDecoration.gradientBlackToPrimaryContainer,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Post To Bitfitx',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                CustomElevatedButton(
                  text: 'Add Post',
                  width: 100,
                  onTap: () {
                    controller.postAdder(context);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Add Video To Bitfitx',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                CustomElevatedButton(
                  width: 100,
                  text: 'Add Video',
                  onTap: () {},
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Record a short video',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                CustomElevatedButton(
                  width: 100,
                  text: 'Add short',
                  onTap: () {
                    controller.addShort();
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Go Live on Bitfitx',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                CustomElevatedButton(
                  text: 'Go Live',
                  width: 100,
                  onTap: () {
                    controller.goLive();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
