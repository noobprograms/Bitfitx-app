import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final videoUrl = Get.arguments['url'];
  RxDouble videoDuration = 0.0.obs;
  RxDouble currentDuration = 0.0.obs;
  RxString iconName = 'play'.obs;
  RxBool videoStarted = false.obs;
  @override
  void onInit() async {
    super.onInit();
    eliteVideoController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await eliteVideoController.initialize().then((value) {
      videoStarted.value = true;
      videoDuration.value =
          eliteVideoController.value.duration.inMilliseconds.toDouble();
    });
    eliteVideoController.addListener(() {
      currentDuration.value =
          eliteVideoController.value.position.inMilliseconds.toDouble();
      if (eliteVideoController.value.isCompleted) {
        iconName.value = 'replay';
      } else if (eliteVideoController.value.isPlaying)
        iconName.value = 'pause';
      else
        iconName.value = 'play';
    });
  }

  void playPauseButtonPress() {
    if (eliteVideoController.value.buffered.length != 0 &&
        eliteVideoController.value.position ==
            eliteVideoController.value.buffered[0].end) {
      eliteVideoController.seekTo(Duration(seconds: 0));

      eliteVideoController.play();
    }
    eliteVideoController.value.isPlaying
        ? eliteVideoController.pause()
        : eliteVideoController.play();
  }

  @override
  void dispose() {
    eliteVideoController.dispose();
    super.dispose();
  }

  void closeView() {
    dispose();
    Get.back(closeOverlays: true);
  }
}
