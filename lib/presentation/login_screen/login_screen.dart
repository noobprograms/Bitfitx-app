import 'package:bitfitx_project/presentation/login_screen/controller/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  LoginController controller = Get.find();

  // TextEditingController emailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: AppDecoration.gradientBlackToPrimaryContainer.copyWith(),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 14.h,
                vertical: 45.v,
              ),
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRemoval1,
                    height: 180.adaptSize,
                    width: 180.adaptSize,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    LocalizationExtension("lbl_login").tr,
                    style: CustomTextStyles.titleLargeRobotoOnPrimaryContainer,
                  ),
                  CustomTextFormField(
                    controller: controller.emailController,
                    margin: EdgeInsets.only(
                      left: 6.h,
                      top: 28.v,
                      right: 6.h,
                    ),
                    hintText: LocalizationExtension("lbl_email").tr,
                    textInputType: TextInputType.emailAddress,
                    textStyle: theme.textTheme.headlineLarge,
                  ),
                  CustomTextFormField(
                    controller: controller.passwordController,
                    margin: EdgeInsets.only(
                      left: 6.h,
                      top: 29.v,
                      right: 6.h,
                    ),
                    hintText: LocalizationExtension("lbl_password").tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    textStyle: theme.textTheme.headlineLarge,
                  ),
                  CustomElevatedButton(
                    onTap: () {
                      controller.login();
                    },
                    text: LocalizationExtension("lbl_sign_in").tr,
                    margin: EdgeInsets.only(
                      left: 12.h,
                      top: 28.v,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 26.h,
                      top: 21.v,
                      right: 26.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.v),
                          child: SizedBox(
                            width: 127.h,
                            child: Divider(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13.h),
                          child: Text(
                            LocalizationExtension("lbl_or").tr,
                            style: CustomTextStyles.titleLargeRoboto,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 13.v,
                          ),
                          child: SizedBox(
                            width: 147.h,
                            child: Divider(
                              indent: 13.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                  SizedBox(
                    height: 50.v,
                    width: 350.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 56.h,
                              top: 4.v,
                            ),
                            child: Text(
                              LocalizationExtension("lbl_sign_in_with").tr,
                              style: CustomTextStyles.titleLargeRobotoBlack900,
                            ),
                          ),
                        ),
                        CustomElevatedButton(
                          onTap: () {
                            controller.googleSignIn();
                          },
                          width: 350.h,
                          text: LocalizationExtension("msg_sign_in_with_google")
                              .tr,
                          leftIcon: Container(
                            margin: EdgeInsets.only(right: 18.h),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.vertical(
                                //   top: Radius.circular(25.h),
                                // ),
                                ),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgRectangle4,
                              height: 30.v,
                              width: 28.h,
                            ),
                          ),
                          buttonStyle:
                              CustomButtonStyles.fillSecondaryContainer,
                          buttonTextStyle: theme.textTheme.titleMedium!,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 37.v),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: LocalizationExtension(
                                  "msg_don_t_have_an_account2")
                              .tr,
                          style:
                              CustomTextStyles.titleMediumOnPrimaryContainer_1,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.goToSignUp();
                            },
                          text: LocalizationExtension("lbl_sign_up").tr,
                          style: CustomTextStyles.titleMediumBlueA200,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
