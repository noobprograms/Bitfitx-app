import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class LiveUserWidget extends StatelessWidget {
  LiveUserWidget(
      {required this.coverImage,
      required this.profileImage,
      required this.name,
      required this.tokenValue,
      required this.channelName,
      super.key});
  final String coverImage;
  final String profileImage;
  final String name;
  final String tokenValue;
  final String channelName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.attendingLiveScreen,
            arguments: {'channelName': channelName, 'token': tokenValue});
      },
      child: Container(
        width: 200,
        height: 123,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(coverImage))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(144, 158, 158, 158)),
              child: Text(
                '$name is Live',
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                profileImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
