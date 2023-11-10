import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final videoUrl = Get.arguments['url'];
  RxDouble videoDuration = 0.0.obs;
  RxDouble currentDuration = 0.0.obs;
  RxString iconName = 'play'.obs;
  RxBool videoStarted = false.obs;
  @override
  void onInit() async {
    super.onInit();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoPlayerController.initialize().then((value) {
      videoStarted.value = true;
      videoDuration.value =
          videoPlayerController.value.duration.inMilliseconds.toDouble();
    });
    videoPlayerController.addListener(() {
      currentDuration.value =
          videoPlayerController.value.position.inMilliseconds.toDouble();
      if (videoPlayerController.value.isCompleted) {
        iconName.value = 'replay';
      } else if (videoPlayerController.value.isPlaying)
        iconName.value = 'pause';
      else
        iconName.value = 'play';
    });
  }

  void playPauseButtonPress() {
    if (videoPlayerController.value.buffered.length != 0 &&
        videoPlayerController.value.position ==
            videoPlayerController.value.buffered[0].end) {
      videoPlayerController.seekTo(Duration(seconds: 0));

      videoPlayerController.play();
    }
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  void closeView() {
    dispose();
    Get.back(closeOverlays: true);
  }
}
