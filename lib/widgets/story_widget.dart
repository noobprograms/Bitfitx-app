import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/data/story_data.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/utils/auth_constants.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget(
      {this.isEdit = false,
      required this.uid,
      required this.name,
      required this.profileImageUrl,
      super.key});

  final bool isEdit;
  final String uid;
  final String name;

  final String profileImageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(3),
        height: 90,
        width: 60,
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   color: Colors.green,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: !isEdit
                      ? Border.all(color: Colors.green, width: 2)
                      : null),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: isEdit
                    ? NetworkImage(
                        profileImageUrl,
                      )
                    : NetworkImage(
                        profileImageUrl,
                      ),
                child: isEdit ? Center(child: Icon(Icons.add)) : null,
              ),
            ),
            isEdit
                ? Expanded(
                    child: Text(
                    'Your Story',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ))
                : Expanded(
                    child: Text(
                    name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  )),
          ],
        ),
      ),
    );
  }
}
