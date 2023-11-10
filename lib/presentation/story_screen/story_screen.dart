import 'dart:math';
import 'dart:ui';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/data/models/story_model.dart';
import 'package:bitfitx_project/data/story_data.dart';
import 'package:bitfitx_project/presentation/story_screen/controller/story_controller.dart';
import 'package:bitfitx_project/widgets/animation_bar.dart';
import 'package:bitfitx_project/widgets/user_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatelessWidget {
  StoryScreen({super.key});
  StoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    final Story story = controller.allStories[controller.currentIndex.value];
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: controller.pageNotifier,
        builder: (_, value, child) {
          return PageView.builder(
            controller: controller.pageController,
            physics: const ClampingScrollPhysics(),
            itemCount: storyListUser.length,
            itemBuilder: (context, index) {
              final isLeaving = (index - value) <= 0;
              final t = index - value;
              final rotationY = lerpDouble(0, 90, t);
              final opacity = lerpDouble(0, 1, t.abs())!.clamp(0.0, 1.0);
              final transform = Matrix4.identity();
              transform.setEntry(3, 2, 0.003);
              transform.rotateY(double.parse('${-degToRad(rotationY!)}'));

              return GestureDetector(
                onLongPress: () => controller.animationController!.stop(),
                onLongPressEnd: (details) =>
                    controller.animationController!.forward(),
                onTapDown: (details) =>
                    controller.onTapDown(details, story, context),
                onVerticalDragUpdate: (details) {
                  controller.closeStories(context);
                },
                child: Transform(
                  alignment:
                      isLeaving ? Alignment.centerRight : Alignment.centerLeft,
                  transform: transform,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          PageView.builder(
                              controller: controller.childPageController,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: storyListUser[index].story.length,
                              itemBuilder: (context, index) {
                                final Story story =
                                    controller.allStories[index];
                                switch (story.media) {
                                  case MediaType.image:
                                    return CachedNetworkImage(
                                      imageUrl: story.url,
                                      fit: BoxFit.cover,
                                    );
                                  case MediaType.video:
                                    if (controller.videoPlayerController!.value
                                        .isInitialized) {
                                      return FittedBox(
                                          fit: BoxFit.cover,
                                          child: SizedBox(
                                            width: controller
                                                .videoPlayerController!
                                                .value
                                                .size
                                                .width,
                                            height: controller
                                                .videoPlayerController!
                                                .value
                                                .size
                                                .height,
                                            child: VideoPlayer(controller
                                                .videoPlayerController!),
                                          ));
                                    }
                                }
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  ],
                                );
                              }),
                          Positioned(
                            top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: controller.allStories
                                        .asMap()
                                        .map((key, value) {
                                          return MapEntry(
                                              key,
                                              Obx(
                                                () => AnimatedBar(
                                                    animationController:
                                                        controller
                                                            .animationController!,
                                                    position: key,
                                                    currentindex: controller
                                                        .currentIndex.value),
                                              ));
                                        })
                                        .values
                                        .toList(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.5, vertical: 10.0),
                                    child: Hero(
                                      tag: controller.heroTag,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: UserInfo(
                                              user: storyListUser[index].user,
                                              timeUploaded: storyListUser[index]
                                                  .story[controller
                                                      .currentIndex.value]
                                                  .timeUploaded,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller
                                                    .closeStories(context);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 10,
                              child: SafeArea(
                                  child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          )),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: controller.commentController,
                                      onTap: () {
                                        controller.animationController!.stop();
                                      },
                                      onTapOutside: (event) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        controller.animationController!
                                            .forward();
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: Colors.white),
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        hintText: 'Send Message',
                                        hintStyle: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder()
                                            .copyWith(
                                                borderSide: BorderSide()
                                                    .copyWith(
                                                        color: Colors
                                                            .grey.shade300)),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: controller.postComment,
                                      icon: Icon(
                                        Icons.send_rounded,
                                        color: Colors.white,
                                      ))
                                ],
                              )))
                        ],
                      ),
                      Positioned.fill(
                          child: Opacity(
                        opacity: opacity,
                      ))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
    // return Scaffold(
    //   body: StoryView(
    //     storyItems: [
    //       StoryItem.text(title: 'hello there', backgroundColor: Colors.green),
    //       StoryItem.pageImage(
    //           url:
    //               'https://imgs.search.brave.com/MdnsiZECYarAIS5I0t7eKATcj5qM6EvJ6nmaalCnDr8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzlhL2E2/LzQ0LzlhYTY0NGFh/YzcwMjk4ODFkMzkz/NDNmZDhjMjkwNTg5/LmpwZw',
    //           controller: controller),
    //     ],
    //     controller: controller,
    //     inline: false,
    //     repeat: false,
    //     onComplete: () {
    //       Get.toNamed(AppRoutes.homeScreen);
    //     },
    //   ),
    // );
  }
}

num degToRad(num deg) => deg * (pi / 180.0);
num radToDeg(num rad) => rad * (180.0 / pi);
