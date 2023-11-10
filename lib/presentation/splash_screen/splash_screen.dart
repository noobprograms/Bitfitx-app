import 'package:bitfitx_project/presentation/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key})
      : super(
          key: key,
        );
  SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mediaQueryData.size.height,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 44.h,
            vertical: 300.v,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Text(
                    LocalizationExtension("msg_get_social_with").tr,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgRemoval1,
                height: 180.adaptSize,
                width: 180.adaptSize,
                alignment: Alignment.topCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
