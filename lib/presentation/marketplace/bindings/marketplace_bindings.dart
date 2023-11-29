import 'package:get/get.dart';

import '../controllers/marketplace_controller.dart';

class MarketplaceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarketplaceController());
  }
}
