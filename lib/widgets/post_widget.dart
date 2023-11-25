import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/comment_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatelessWidget {
  PostCard(
      {this.currentUser,
      this.postImageUrl,
      this.postID,
      this.description,
      this.likes,
      this.comments,
      this.time,
      this.uid,
      super.key});
  final postImageUrl;
  final currentUser;
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
                          backgroundImage: NetworkImage(
                            myuser!['profileImageUrl'],
                          ),
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
                                height: 350,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomTextFormField(
                                              width: 250,
                                              hintText: 'Enter a comment',
                                              controller:
                                                  controller.commentController,
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  var result =
                                                      await firebaseFirestore
                                                          .collection(
                                                              'comments')
                                                          .doc(postID)
                                                          .collection(
                                                              'allComments')
                                                          .get();

                                                  var len = result.docs!.length;
                                                  var commentID =
                                                      'comment${len}';
                                                  var comment = CommentPost(
                                                      commentID,
                                                      controller
                                                          .commentController
                                                          .text,
                                                      uid,
                                                      currentUser
                                                          .profileImageUrl,
                                                      currentUser.name,
                                                      Timestamp.now());
                                                  controller.commentController
                                                      .text = '';
                                                  await firebaseFirestore
                                                      .collection('comments')
                                                      .doc(postID)
                                                      .collection("allComments")
                                                      .doc(commentID)
                                                      .set(comment.toJson());

                                                  var currentPost =
                                                      await firebaseFirestore
                                                          .collection('posts')
                                                          .doc(postID)
                                                          .get();
                                                  var newComments = 1 +
                                                      int.parse(currentPost
                                                          .data()!['comments']);
                                                  await firebaseFirestore
                                                      .collection('posts')
                                                      .doc(postID)
                                                      .update({
                                                    "comments":
                                                        newComments.toString()
                                                  });
                                                },
                                                icon: Icon(Icons.send))
                                          ],
                                        ),
                                      ),
                                      StreamBuilder(
                                          stream: firebaseFirestore
                                              .collection('comments')
                                              .doc(postID)
                                              .collection('allComments')
                                              .orderBy('timestamp',
                                                  descending: true)
                                              .snapshots(),
                                          builder: ((context, snapshot) {
                                            if (snapshot.hasError)
                                              return Text(
                                                  'Error${snapshot.error}');
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting)
                                              return Text('Loading...');
                                            if (!snapshot.hasData) {
                                              print(snapshot.hasData);
                                              return Container(
                                                  child: Text(
                                                'No Comments!!. Be the first to comment.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 120),
                                              ));
                                            } else {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'profileImageUrl']),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .data()['name'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'content']),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          }))
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor:
                                  Color.fromARGB(202, 128, 144, 151),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            );
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
