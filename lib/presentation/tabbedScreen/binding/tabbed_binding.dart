import 'package:bitfitx_project/presentation/account_screen/controller/account_controller.dart';
import 'package:bitfitx_project/presentation/add_content_screen.dart/controller/add_content_controller.dart';
import 'package:bitfitx_project/presentation/groups_screen/controller/groups_controller.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/presentation/reels_screen/controller/reels_controller.dart';
import 'package:bitfitx_project/presentation/tabbedScreen/controller/tabbed_controller.dart';
import 'package:bitfitx_project/presentation/trending_screen/controller/trending_controller.dart';
import 'package:bitfitx_project/presentation/verified_videos_screen/controller/verified_videos_controller.dart';
import 'package:get/get.dart';

class TabbedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabbedController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TrendingController());
    Get.lazyPut(() => ReelsController());
    Get.lazyPut(() => AddContentController());
    Get.lazyPut(() => VerifiedVidController());
    Get.lazyPut(() => GroupsController());
    Get.lazyPut(() => AccountController());
  }
}
