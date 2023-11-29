import 'package:agora_uikit/agora_uikit.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/presentation/live_streaming/controller/attending_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendingLive extends StatelessWidget {
  AttendingLive({super.key});
  AttendingLiveController controller = Get.find();
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
    ;
  }
}
