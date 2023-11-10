import 'package:bitfitx_project/presentation/sign_up_screen/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  SignUpController controller = Get.find();

  // TextEditingController nameController = TextEditingController();

  // TextEditingController emailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();

  // TextEditingController confirmpasswordController = TextEditingController();

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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 38.v,
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgArrow1,
                      height: 18.v,
                      width: 18.h,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 6.h),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Container(
                      width: 287.h,
                      margin: EdgeInsets.only(
                        left: 31.h,
                        top: 48.v,
                        right: 30.h,
                      ),
                      child: Text(
                        LocalizationExtension("msg_start_making_new").tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                    SizedBox(height: 54.v),
                    Text(
                      LocalizationExtension("lbl_sign_up").tr,
                      style:
                          CustomTextStyles.titleLargeRobotoOnPrimaryContainer,
                    ),
                    SizedBox(height: 28.v),
                    CustomTextFormField(
                      controller: controller.nameController,
                      hintText: LocalizationExtension("lbl_name").tr,
                      textStyle: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      controller: controller.emailController,
                      hintText: LocalizationExtension("lbl_email").tr,
                      textInputType: TextInputType.emailAddress,
                      textStyle: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: LocalizationExtension("lbl_password").tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Some password';
                        }
                        return null;
                      },
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      textStyle: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 19.v),
                    CustomTextFormField(
                      controller: controller.confirmpasswordController,
                      hintText:
                          LocalizationExtension("msg_confirm_password").tr,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      textStyle: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 19.v),
                    CustomElevatedButton(
                      onTap: () {
                        controller.signUp();
                      },
                      text: LocalizationExtension("lbl_create_account").tr,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.h,
                        top: 20.v,
                        right: 20.h,
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
                    SizedBox(height: 17.v),
                    CustomElevatedButton(
                      onTap: controller.googleSignIn,
                      text: LocalizationExtension("msg_sign_up_with_google").tr,
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.h),
                          ),
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgRectangle4,
                          height: 26.v,
                          width: 24.h,
                        ),
                      ),
                      buttonStyle: CustomButtonStyles.fillSecondaryContainer,
                      buttonTextStyle: theme.textTheme.titleMedium!,
                    ),
                    SizedBox(height: 23.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocalizationExtension("msg_already_have_an2")
                                .tr,
                            style: CustomTextStyles
                                .titleMediumPoppinsOnPrimaryContainer,
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.goToSignIn();
                              },
                            text: LocalizationExtension("lbl_sign_in").tr,
                            style: CustomTextStyles.titleMediumPoppinsBlueA200,
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
      ),
    );
  }
}
