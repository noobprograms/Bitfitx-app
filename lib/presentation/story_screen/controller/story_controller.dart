import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/story_model.dart';
import 'package:bitfitx_project/data/story_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

class StoryController extends GetxController with GetTickerProviderStateMixin {
  PageController? pageController;
  PageController? childPageController;
  AnimationController? animationController;
  VideoPlayerController? videoPlayerController;
  String uid = Get.arguments['uid'];
  String name = Get.arguments['name'];
  String profileImageUrl = Get.arguments['profileImageUrl'];

  List storyListUser = Get.arguments['stories_list'];

  TextEditingController commentController = TextEditingController();

  RxInt currentIndex = 0.obs;
  late final pageNotifier;
  // List<UserStoryList> userStory = storyListUser;
  List<Story> allStories = [];
  String heroTag = 'example';
  DateTime currentTime = DateTime.now(); //change this when you are done
  @override
  void onInit() async {
    super.onInit();
    pageNotifier = ValueNotifier(0.0);
    var temp;
    pageController = PageController();
    var result = await firebaseFirestore
        .collection('stories')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => temp = value.docs);
    ;
    temp.forEach((element) {
      if (DateTime.now()
              .difference(
                  DateTime.parse(element['timeUploaded'].toDate().toString()))
              .inHours <=
          24) {
        allStories!.add(Story(
            url: element.data()['url'],
            sid: element.data()['sid'],
            media: MediaType.values.byName(element.data()['media']),
            duration: Story.parseDuration(element.data()['duration']),
            uid: element.data()['uid'],
            name: element.data()['name'],
            profileImageUrl: element.data()['profileImageUrl'],
            timeUploaded: element.data()['timeUploaded']));
        print('I am joseph$allStories');
      }
    });
    childPageController = PageController();
    animationController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController!.addListener(_listener);
    });
    final Story firstStory = allStories!.first;
    loadStory(story: firstStory, animationToPage: false);
    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.stop();
        animationController!.reset();

        if (currentIndex.value + 1 < allStories!.length) {
          /////////////
          increaseAndLoad();
        } else {
          setAndLoad(0);
        }
      }
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    pageController!.removeListener(_listener);
    pageController!.dispose();
    childPageController!.dispose();
    pageNotifier.dispose();

    super.dispose();
  }

  void _listener() {
    pageNotifier.value = pageController!.page!;
    currentIndex.value = 0;
  }

  void increaseAndLoad() {
    currentIndex.value = currentIndex.value + 1;
    loadStory(story: allStories![currentIndex.value]);
  }

  void decreaseAndLoad() {
    currentIndex.value = currentIndex.value - 1;
    loadStory(story: allStories![currentIndex.value]);
  }

  void setAndLoad(int value) {
    currentIndex.value = value;
    print(currentIndex.value);
    loadStory(
      story: allStories![currentIndex.value],
    );
    update();
  }

  void closeStories(BuildContext context) {
    // dispose();
    Navigator.pop(context);
  }

  void loadStory({required Story story, bool animationToPage = true}) {
    animationController!.stop();
    animationController!.reset();
    switch (story.media) {
      case MediaType.image:
        animationController!.duration = story.duration;

        animationController!.forward();
        break;
      case MediaType.video:
        videoPlayerController = VideoPlayerController.asset(story.url)
          ..initialize().then((value) {
            if (videoPlayerController!.value.isInitialized) {
              animationController!.duration =
                  videoPlayerController!.value.duration;
              videoPlayerController!.play();
              animationController!.forward();
            }
          });
        break;
      default:
    }
    if (animationToPage) {
      childPageController!.animateToPage(currentIndex.value,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }

  void onTapDown(TapDownDetails detalis, Story story, BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double dx = detalis.globalPosition.dx;
    if (dx < screenwidth / 3) {
      if (currentIndex.value - 1 >= 0) {
        decreaseAndLoad();
      }
    } else if (dx > 2 * screenwidth / 3) {
      if (currentIndex.value + 1 < allStories!.length) {
        increaseAndLoad();
      } else {
        setAndLoad(0);
      }
    } else {
      if (story.media == MediaType.video) {
        if (videoPlayerController!.value.isPlaying) {
          videoPlayerController!.pause();
          animationController!.stop();
        } else {
          videoPlayerController!.play();
          animationController!.forward();
        }
      }
    }
  }

  void postComment() {
    print(commentController.text);
    commentController.clear();
  }
}
