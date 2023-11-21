import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/presentation/account_screen/account_screen.dart';
import 'package:bitfitx_project/presentation/add_content_screen.dart/add_content_screen.dart';
import 'package:bitfitx_project/presentation/groups_screen/groups_screen.dart';
import 'package:bitfitx_project/presentation/home_screen/home_screen.dart';
import 'package:bitfitx_project/presentation/reels_screen/reels_screen.dart';
import 'package:bitfitx_project/presentation/tabbedScreen/controller/tabbed_controller.dart';
import 'package:bitfitx_project/presentation/trending_screen/trending_screen.dart';
import 'package:bitfitx_project/presentation/verified_videos_screen/verified_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class TabbedScreen extends StatelessWidget {
  TabbedScreen({super.key});
  TabbedController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.tabbingIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 71, 71, 71),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(ImageConstant.trending),
                ),
                label: 'trending',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(ImageConstant.reels)),
                label: 'Reels',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                ),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(ImageConstant.verified_videos)),
                label: 'verified Vids',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'groups',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'account',
              ),
            ],
            onTap: (value) {
              controller.setTabbingIndex(value);
            },
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.tabbingIndex.value,
            children: [
              Home(controller.currentUser),
              TrendingScreen(),
              ReelsScreen(controller.currentUser),
              AddContentScreen(controller.currentUser),
              VerifiedVidScreen(),
              GroupsScreen(),
              AccountScreen(controller.currentUser),
            ],
          ),
        ));
  }
}
