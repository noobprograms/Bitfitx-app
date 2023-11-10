import 'package:get/get.dart';

import '../controller/confirm_story_controller.dart';

class ConfirmStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmStoryController());
  }
}
