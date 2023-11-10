import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/home_screen.dart';

class TabbedController extends GetxController with GetTickerProviderStateMixin {
  User currentUser = Get.arguments['currentUser'];
  RxInt tabbingIndex = 0.obs;

  void setTabbingIndex(int value) {
    tabbingIndex.value = value;
  }
}
