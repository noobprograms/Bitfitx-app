import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/controllers/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreen extends StatelessWidget {
  VideoFullScreen({super.key});

  VideoController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF737373),
          // This line set the transparent background
          child: Container(
              decoration: AppDecoration.gradientBlackToBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Container(
                        color: Theme.of(context).primaryColor,
                        constraints: BoxConstraints(maxHeight: 500),
                        child: controller.videoStarted.value
                            ? AspectRatio(
                                aspectRatio: controller
                                    .videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(
                                    controller.videoPlayerController),
                              )
                            : Container(
                                height: 200,
                                color: Colors.orange,
                              ),
                      )),
                  Container(
                      child: Obx(
                    () => Slider(
                      value: controller.currentDuration.value,
                      max: controller.videoDuration.value,
                      onChanged: (value) => controller.videoPlayerController
                          .seekTo(Duration(milliseconds: value.toInt())),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                            elevation: 0,
                            child: Container(
                                constraints: BoxConstraints.expand(),
                                decoration: AppDecoration.gradientBlackToBlack
                                    .copyWith(shape: BoxShape.circle),
                                child: Obx(
                                  () => Icon(
                                    controller.iconName.value == 'play'
                                        ? Icons.play_arrow
                                        : controller.iconName.value == 'replay'
                                            ? Icons.replay
                                            : Icons.pause,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),
                            onPressed: () {
                              controller.playPauseButtonPress();
                            }),
                        SizedBox(width: 16),
                        IconButton(
                            onPressed: () {
                              controller.closeView();
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
