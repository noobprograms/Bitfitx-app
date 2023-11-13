import 'package:bitfitx_project/presentation/account_screen/account_screen.dart';

import 'package:bitfitx_project/presentation/add_content_screen.dart/add_content_screen.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/bindings/video_call_binding.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/bindings/voice_call_binding.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/videoCallingscreen.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/voiceCallingScreen.dart';
import 'package:bitfitx_project/presentation/chat_room/binding/chat_room_binding.dart';
import 'package:bitfitx_project/presentation/chat_room/binding/media_preview_binding.dart';
import 'package:bitfitx_project/presentation/chat_room/chat_room_screen.dart';
import 'package:bitfitx_project/presentation/chat_room/media_preview_screen.dart';
import 'package:bitfitx_project/presentation/chats_screen/chats_screen.dart';

import 'package:bitfitx_project/presentation/groups_screen/groups_screen.dart';

import 'package:bitfitx_project/presentation/home_screen/home_screen.dart';
import 'package:bitfitx_project/presentation/login_screen/binding/login_binding.dart';
import 'package:bitfitx_project/presentation/reels_screen/reels_screen.dart';
import 'package:bitfitx_project/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:bitfitx_project/presentation/signup_login_screen/binding/signup_login_binding.dart';
import 'package:bitfitx_project/presentation/splash_screen/binding/splash_binding.dart';
import 'package:bitfitx_project/presentation/story_screen/binding/story_binding.dart';
import 'package:bitfitx_project/presentation/story_screen/confirm_story/binding/confirm_story_binding.dart';
import 'package:bitfitx_project/presentation/story_screen/confirm_story/confirm_story_screen.dart';
import 'package:bitfitx_project/presentation/story_screen/story_screen.dart';
import 'package:bitfitx_project/presentation/tabbedScreen/binding/tabbed_binding.dart';
import 'package:bitfitx_project/presentation/tabbedScreen/tabbed_screen.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/bindings/video_full_screen_binding.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/videoScreen.dart';

import 'package:bitfitx_project/presentation/verified_videos_screen/verified_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitfitx_project/presentation/splash_screen/splash_screen.dart';
import 'package:bitfitx_project/presentation/signup_login_screen/signup_login_screen.dart';
import 'package:bitfitx_project/presentation/login_screen/login_screen.dart';
import 'package:bitfitx_project/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:bitfitx_project/presentation/app_navigation_screen/app_navigation_screen.dart';

import '../presentation/chats_screen/binding/chats_screen_binding.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String signupLoginScreen = '/signup_login_screen';

  static const String loginScreen = '/login_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String storyScreen = '/story_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String confirmStoryScreen = '/confirm_story_screen';

  static const String chatsScreen = '/chats_screen';
  static const String chatRoom = '/chat_room';
  static const String mediaPreview = '/media_preview';
  static const String videoFullScreen = '/video_full_screen';
  static const String videoCallScreen = '/video_call_screen';
  static const String voiceCallScreen = '/voice_call_screen';
  static const String tabbedScreen = '/tabbed_screen';
  static final routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: signupLoginScreen,
      page: () => SignupLoginScreen(),
      binding: SignupLoginBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: storyScreen,
      page: () => StoryScreen(),
      binding: StoryBinding(),
    ),
    GetPage(
      name: confirmStoryScreen,
      page: () => ConfirmStory(),
      binding: ConfirmStoryBinding(),
    ),
    GetPage(
      name: chatsScreen,
      page: () => ChatScreen(),
      binding: ChatsBinding(),
    ),
    GetPage(
      name: chatRoom,
      page: () => ChatRoom(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: mediaPreview,
      page: () => MediaPreview(),
      binding: MediaPreviewBinding(),
    ),
    GetPage(
      name: videoFullScreen,
      page: () => VideoFullScreen(),
      binding: VideoFullBinding(),
    ),
    GetPage(
      name: videoCallScreen,
      page: () => VideoCall(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: voiceCallScreen,
      page: () => VoiceCalling(),
      binding: VoiceCallBinding(),
    ),
    GetPage(
      name: tabbedScreen,
      page: () => TabbedScreen(),
      binding: TabbedBinding(),
    ),
  ];
}
