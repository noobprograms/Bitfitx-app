import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/presentation/chat_room/controller/chat_room_controller.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:bitfitx_project/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({super.key});
  ChatRoomController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Get.offAndToNamed(AppRoutes.chatsScreen,
                    arguments: {'currentUser': controller.currentUser}),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    controller.seeAccount(context);
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.thatUser.profileImageUrl),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                controller.thatUser.name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        titleSpacing: 0,
        leadingWidth: 300.h,
        shadowColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.voiceCallScreen, arguments: {
                    'cUser': controller.currentUser,
                  });
                },
                icon: Icon(
                  Icons.call,
                  color: Colors.yellow,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.videoCallScreen, arguments: {
                    'cUser': controller.currentUser,
                    'tUser': controller.thatUser
                  });
                },
                icon: Icon(Icons.video_call, color: Colors.yellow)),
          )
        ],
      ),
      body: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        padding: EdgeInsets.only(top: 68.v),
        decoration: AppDecoration.gradientBlackToPrimaryContainer,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.chatService.getChatsForUser(
                    controller.currentUser.uid, controller.thatUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Error${snapshot.error}');
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Text('Loading...');
                  return ListView(
                    children: snapshot.data!.docs
                        .map((doc) => MessageBubble(
                            document: doc, cUserId: controller.currentUser.uid))
                        .toList(),
                  );
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        )),
                    child: IconButton(
                      onPressed: controller.openAttachment,
                      icon: Icon(
                        Icons.attachment,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: controller.messageController,
                    hintText: 'Send Message',
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.green,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
