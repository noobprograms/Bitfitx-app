import 'package:bitfitx_project/presentation/signup_login_screen/controller/signup_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';

class SignupLoginScreen extends StatelessWidget {
  SignupLoginScreen({Key? key})
      : super(
          key: key,
        );
  SignupLoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: double.maxFinite,
          child: SizedBox(
            height: mediaQueryData.size.height,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgJedvillejopum,
                  height: 478.v,
                  width: 390.h,
                  alignment: Alignment.topCenter,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 65.h,
                      vertical: 45.v,
                    ),
                    decoration:
                        AppDecoration.gradientBlackToPrimaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 256.h,
                          child: Text(
                            LocalizationExtension("msg_connect_with_millions")
                                .tr,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles
                                .headlineLargeOnPrimaryContainer,
                          ),
                        ),
                        SizedBox(height: 62.v),
                        CustomElevatedButton(
                          onTap: () {
                            controller.switchScreen(1);
                          },
                          width: 150.h,
                          text: LocalizationExtension("lbl_login").tr,
                          buttonTextStyle: CustomTextStyles
                              .titleLargeRobotoOnPrimaryContainer,
                        ),
                        SizedBox(height: 16.v),
                        CustomElevatedButton(
                          onTap: () {
                            controller.switchScreen(0);
                          },
                          width: 150.h,
                          text: LocalizationExtension("lbl_sign_up").tr,
                          buttonStyle: CustomButtonStyles.fillBlueGray,
                          buttonTextStyle:
                              CustomTextStyles.titleLargeRobotoOnPrimary,
                        ),
                        SizedBox(height: 10.v),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
