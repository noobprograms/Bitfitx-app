import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/chats_screen/controller/chats_screen_controller.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/theme/custom_text_style.dart';
import 'package:bitfitx_project/widgets/chat_info_tile.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  ChatsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

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
            onTap: () {
              Get.offAndToNamed(AppRoutes.tabbedScreen,
                  arguments: {'currentUser': controller.currentuser});
            },
            child: CustomImageView(
              svgPath: ImageConstant.imgArrow1,
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
              onTap: () {},
              child: CustomImageView(
                color: Colors.yellow,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Chats',
                        style: CustomTextStyles.headlineLargeOnPrimaryContainer,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      leftIcon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      text: 'Create New',
                      buttonStyle: CustomButtonStyles.fillGreen,
                      onTap: () {
                        Get.bottomSheet(Container(
                          height: mediaQueryData.size.height - 20,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              TextField(
                                onChanged: (value) {
                                  controller.messageTextChanged(value);
                                  // print('I am${searchResults.length}');
                                },
                                controller: controller.searchUserInput,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter username to chat',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.h),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.h),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.h),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: Obx(() => ListView.separated(
                                      itemCount:
                                          controller.searchResults.value.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 10,
                                          ),
                                      itemBuilder: (context, index) {
                                        // print(
                                        //     'I am ${controller.searchResults.value[index]["name"]}');
                                        var instantUser = User(
                                            uid: controller.searchResults.value[index]
                                                ['uid'],
                                            name: controller.searchResults.value[index]
                                                ['name'],
                                            email: controller.searchResults
                                                .value[index]['email'],
                                            profileImageUrl:
                                                controller.searchResults.value[index]
                                                    ['profileImageUrl'],
                                            coverImageUrl: controller
                                                .searchResults
                                                .value[index]['coverImageUrl'],
                                            tokenValue: controller.searchResults
                                                .value[index]['tokenValue'],
                                            following: controller.searchResults.value[index]['following'],
                                            fans: controller.searchResults.value[index]['fans']);
                                        return GestureDetector(
                                          onTap: () {
                                            controller
                                                .goToChatRoom(instantUser);
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    controller.searchResults
                                                            .value[index]
                                                        ['profileImageUrl']),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    controller.searchResults
                                                        .value[index]['name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19)),
                                              )
                                            ],
                                          ),
                                        );
                                      })))
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                ],
              ),
              Obx(() => controller.isLoaded.value
                  ? Expanded(
                      child: ListView.separated(
                      itemCount: controller.allChatRooms.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        print(index);
                        var instantUser = User(
                            uid: controller.allChatRooms.value[index]['uid'],
                            name: controller.allChatRooms.value[index]['name'],
                            email: controller.allChatRooms.value[index]
                                ['email'],
                            profileImageUrl: controller
                                .allChatRooms.value[index]['profileImageUrl'],
                            coverImageUrl: controller.allChatRooms.value[index]
                                ['coverImageUrl'],
                            tokenValue: controller.allChatRooms.value[index]
                                ['tokenValue'],
                            following: controller.allChatRooms.value[index]
                                ['following'],
                            fans: controller.allChatRooms.value[index]['fans']);
                        return GestureDetector(
                          onTap: () {
                            controller.goToChatRoom(instantUser);
                          },
                          child:
                              ChatInfoTile(instantUser, controller.currentuser),
                        );
                      },
                    ))
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
