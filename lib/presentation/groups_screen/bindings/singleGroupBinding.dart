import 'package:bitfitx_project/presentation/groups_screen/controller/single_group_view_controller.dart';
import 'package:get/get.dart';

class SingleGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingleGroupViewController());
  }
}
