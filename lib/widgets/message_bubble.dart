import 'dart:io';

import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/image_full_screen.dart';
import 'package:bitfitx_project/presentation/chat%20utility%20screens/videoScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.document, required this.cUserId, super.key});
  final DocumentSnapshot document;
  final String cUserId;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool thisUserMessage = data['senderId'] == cUserId;

    var alignment =
        thisUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start;
    var decoration = thisUserMessage
        ? AppDecoration.gradientBlackToBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15)
        : AppDecoration.gradientBlueGrayAdToGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15);

    return !thisUserMessage
        ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignment,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Expanded(
                          child: data['type'] == 'text'
                              ? Text(
                                  data['message'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : data['type'] == 'image'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ImageFullScreen(
                                                    data['asset'])));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: data['asset'],
                                            placeholder: (_, url) =>
                                                Image.asset(
                                              ImageConstant.imageNotFound,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                  : data['type'] == 'video'
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    height: 80,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Icon(
                                                        Icons.videocam,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data['message'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 40,
                                                child: IconButton(
                                                  icon: Icon(Icons.play_arrow),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        AppRoutes
                                                            .videoFullScreen,
                                                        arguments: {
                                                          'url': data["asset"]
                                                        });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: <Widget>[
                                                  Container(
                                                    color: Colors.black,
                                                    height: 80,
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.insert_drive_file,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(data['message'],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 40,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.file_download,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () async {
                                                    var directory;
                                                    if (Platform.isIOS)
                                                      directory =
                                                          await getDownloadsDirectory();
                                                    else
                                                      directory =
                                                          '/storage/emulated/0/Download/';
                                                    if (await Directory(
                                                            directory)
                                                        .exists()) {
                                                      directory =
                                                          "/storage/emulated/0/Download/";
                                                    } else {
                                                      directory =
                                                          "/storage/emulated/0/Downloads/";
                                                    }
                                                    await FlutterDownloader
                                                        .enqueue(
                                                      url: data['asset'],
                                                      fileName: data['message'],
                                                      savedDir: directory,
                                                      showNotification: true,
                                                      // show download progress in status bar (for Android)
                                                      openFileFromNotification:
                                                          true, // click on notification to open downloaded file (for Android)
                                                    );
                                                    ;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 7.h,
                  top: 16.v,
                  bottom: 22.v,
                ),
                child: Text(
                  DateFormat.jm().format(data['timestamp'].toDate()).toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: alignment,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 7.h,
                  top: 16.v,
                  bottom: 22.v,
                ),
                child: Text(
                  DateFormat.jm().format(data['timestamp'].toDate()).toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: decoration,
                  child: Row(
                    children: [
                      Expanded(
                          child: data['type'] == 'text'
                              ? Text(
                                  data['message'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : data['type'] == 'image'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ImageFullScreen(
                                                    data['asset'])));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: data['asset'],
                                            placeholder: (_, url) =>
                                                Image.asset(
                                              ImageConstant.imageNotFound,
                                              color: Colors.white,
                                            ),
                                          )),
                                    )
                                  : data['type'] == 'video'
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    height: 80,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Icon(
                                                        Icons.videocam,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        data['message'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 40,
                                                child: IconButton(
                                                  icon: Icon(Icons.play_arrow),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        AppRoutes
                                                            .videoFullScreen,
                                                        arguments: {
                                                          'url': data["asset"]
                                                        });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: <Widget>[
                                                  Container(
                                                    color: Colors.black,
                                                    height: 80,
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.insert_drive_file,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(data['message'],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 40,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.file_download,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () async {
                                                    var directory;
                                                    if (Platform.isIOS)
                                                      directory =
                                                          await getDownloadsDirectory();
                                                    else
                                                      directory =
                                                          '/storage/emulated/0/Download/';
                                                    if (await Directory(
                                                            directory)
                                                        .exists()) {
                                                      directory =
                                                          "/storage/emulated/0/Download/";
                                                    } else {
                                                      directory =
                                                          "/storage/emulated/0/Downloads/";
                                                    }
                                                    await FlutterDownloader
                                                        .enqueue(
                                                      url: data['asset'],
                                                      fileName: data['message'],
                                                      savedDir: directory,
                                                      showNotification: true,
                                                      // show download progress in status bar (for Android)
                                                      openFileFromNotification:
                                                          true, // click on notification to open downloaded file (for Android)
                                                    );
                                                    ;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
