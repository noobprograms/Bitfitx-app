import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatelessWidget {
  PostCard(
      {this.postImageUrl,
      this.postID,
      this.description,
      this.likes,
      this.comments,
      this.time,
      this.uid,
      super.key});
  final postImageUrl;
  final description;
  final likes;
  final comments;
  final time;
  final uid;
  final postID;

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firebaseFirestore.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Text('Loading...');
          var myuser = snapshot.data!.data();
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 369,
              height: 296,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 71, 71, 71),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 333,
                      height: 187,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: NetworkImage(postImageUrl),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(myuser!['profileImageUrl']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(myuser!['name'],
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat.yMd()
                                    .format(time.toDate())
                                    .toString(),
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(128, 128, 128, 1),
                                    fontSize: 14))
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          icon: Image.asset(
                            ImageConstant.likeIcon,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            controller.increaseLikes(postID);
                          },
                        ),
                        Column(
                          children: [
                            Text(likes,
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 12,
                                )),
                            const SizedBox(
                              width: 32,
                              child: AutoSizeText('Likers',
                                  wrapWords: false,
                                  maxLines: 2,
                                  minFontSize: 8,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )),
                            )
                          ],
                        ),
                        IconButton(
                          icon: Image.asset(
                            ImageConstant.commentIcon,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                                Container(
                                  height: 150,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextFormField(
                                              width: 300,
                                              hintText: 'Enter a comment',
                                              controller:
                                                  controller.commentController,
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.send))
                                          ],
                                        ),
                                        Column()
                                      ],
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.blueGrey);
                          },
                        ),
                        Column(
                          children: [
                            Text(comments,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 12,
                                )),
                            const SizedBox(
                              width: 32,
                              child: AutoSizeText('Special Comment',
                                  maxLines: 2,
                                  wrapWords: false,
                                  minFontSize: 5,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
