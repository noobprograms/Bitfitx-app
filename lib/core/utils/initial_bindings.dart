import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/network/network_info.dart';
import 'package:bitfitx_project/core/utils/pref_utils.dart';
import 'package:bitfitx_project/data/apiClient/api_client.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
