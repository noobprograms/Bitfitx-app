import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/controllers/vidoe_call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCall extends StatelessWidget {
  VideoCall({super.key});
  VideoCallController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            AgoraVideoViewer(
              client: controller.client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: controller.client,
              enabledButtons: [
                BuiltInButtons.toggleCamera,
                BuiltInButtons.toggleMic,
                BuiltInButtons.callEnd
              ],
            )
          ],
        )),
      ),
    );
  }
}
