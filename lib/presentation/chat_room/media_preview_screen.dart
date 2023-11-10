import 'package:bitfitx_project/presentation/chat_room/controller/chat_room_controller.dart';
import 'package:bitfitx_project/presentation/chat_room/controller/media_preview_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MediaPreview extends StatelessWidget {
  MediaPreview({super.key});
  MediaController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: controller.isVideo
                  ? VideoPlayer(controller.videoController!)
                  : Image.file(controller.assetFile),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomElevatedButton(
                onTap: () {
                  controller.sendFile(controller.assetFile);
                },
                text: 'Send Message',
                buttonStyle:
                    ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
