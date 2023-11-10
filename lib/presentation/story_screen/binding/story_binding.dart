import 'package:bitfitx_project/presentation/story_screen/controller/story_controller.dart';
import 'package:get/get.dart';

class StoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoryController());
  }
}
