import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/chat_service.dart';
import 'package:bitfitx_project/data/models/message_model.dart' as msg;
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  User currentUser = Get.arguments['cUser'];
  User thatUser = Get.arguments['tUser'];
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          currentUser, thatUser, messageController.text, msg.Type.text, '');
      messageController.text = '';
    }
  }

  void seeAccount(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OtherAccount(currentUser, thatUser);
    }));
  }

  void openAttachment() {
    Get.bottomSheet(Container(
      height: 100,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              showFilePicker(FileType.image);
            },
            icon: Icon(
              Icons.photo,
            ),
            label: Text('Image'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              showFilePicker(FileType.video);
            },
            icon: Icon(Icons.videocam),
            label: Text('Video'),
          ),
        ],
      ),
    ));
  }

  void showFilePicker(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);

    msg.Type fileMsgType = msg.Type.values.byName(fileType.name);
    if (result == null) return;
    PlatformFile myFile = result!.files.first;
    File fileToUpload = File(myFile.path!);
    if (fileToUpload != null)
      Get.toNamed(AppRoutes.mediaPreview, arguments: {
        'cUser': currentUser,
        'tUser': thatUser,
        'theFile': fileToUpload,
        'fileType': fileMsgType,
      });
  }
}
