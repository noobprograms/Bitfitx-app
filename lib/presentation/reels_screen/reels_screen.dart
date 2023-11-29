import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/comment_model.dart';
import 'package:bitfitx_project/data/models/reels_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:bitfitx_project/presentation/reels_screen/controller/reels_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:bitfitx_project/widgets/reel_player_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatelessWidget {
  ReelsScreen(this.cUser, {super.key});
  User cUser;

  @override
  Widget build(BuildContext context) {
    ReelsController controller = Get.put(ReelsController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () => PageView.builder(
              itemCount: controller.videoList.length,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Reel data = controller.videoList[index];
                return Stack(
                  children: [
                    VideoPlayerItem(
                      videoUrl: data.videoUrl,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 100),
                        Expanded(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        var result = await firebaseFirestore
                                            .collection('users')
                                            .doc(data.uid)
                                            .get();
                                        User thatUser = User(
                                            uid: result.data()!['uid'],
                                            name: result.data()!['name'],
                                            email: result.data()!['email'],
                                            profileImageUrl: result
                                                .data()!['profileImageUrl'],
                                            coverImageUrl:
                                                result.data()!['coverImageUrl'],
                                            following:
                                                result.data()!['following'],
                                            fans: result.data()!['fans'],
                                            tokenValue:
                                                result.data()!['tokenValue'],
                                            posts: result.data()!['posts']);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return OtherAccount(cUser, thatUser);
                                        }));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              backgroundImage: NetworkImage(
                                                  data.profilePhoto),
                                            ),
                                          ),
                                          Text(
                                            data.username,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      data.caption,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.likeVideo(
                                                data.rid, cUser.uid);
                                          },
                                          icon: Image.asset(
                                              ImageConstant.likeIcon,
                                              color:
                                                  data.likes.contains(cUser.uid)
                                                      ? Color.fromARGB(
                                                          255, 1, 4, 38)
                                                      : Colors.white)),
                                      const SizedBox(height: 7),
                                      Text(
                                        data.likes.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Likers',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              Container(
                                                height: 350,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomTextFormField(
                                                              width: 250,
                                                              hintText:
                                                                  'Enter a comment',
                                                              controller: controller
                                                                  .commentController,
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  var result = await firebaseFirestore
                                                                      .collection(
                                                                          'comments')
                                                                      .doc(data
                                                                          .rid)
                                                                      .collection(
                                                                          'allComments')
                                                                      .get();

                                                                  var len = result
                                                                      .docs!
                                                                      .length;
                                                                  var commentID =
                                                                      'comment${len}';
                                                                  var comment = CommentPost(
                                                                      commentID,
                                                                      controller
                                                                          .commentController
                                                                          .text,
                                                                      cUser.uid,
                                                                      cUser
                                                                          .profileImageUrl,
                                                                      cUser
                                                                          .name,
                                                                      Timestamp
                                                                          .now());
                                                                  controller
                                                                      .commentController
                                                                      .text = '';
                                                                  await firebaseFirestore
                                                                      .collection(
                                                                          'comments')
                                                                      .doc(data
                                                                          .rid)
                                                                      .collection(
                                                                          "allComments")
                                                                      .doc(
                                                                          commentID)
                                                                      .set(comment
                                                                          .toJson());

                                                                  var currentReel = await firebaseFirestore
                                                                      .collection(
                                                                          'reels')
                                                                      .doc(data
                                                                          .rid)
                                                                      .get();
                                                                  var newComments =
                                                                      1 + data.commentCount;
                                                                  await firebaseFirestore
                                                                      .collection(
                                                                          'reels')
                                                                      .doc(data
                                                                          .rid)
                                                                      .update({
                                                                    "commentCount":
                                                                        newComments
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                    Icons.send))
                                                          ],
                                                        ),
                                                      ),
                                                      StreamBuilder(
                                                          stream: firebaseFirestore
                                                              .collection(
                                                                  'comments')
                                                              .doc(data.rid)
                                                              .collection(
                                                                  'allComments')
                                                              .orderBy(
                                                                  'timestamp',
                                                                  descending:
                                                                      true)
                                                              .snapshots(),
                                                          builder: ((context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasError)
                                                              return Text(
                                                                  'Error${snapshot.error}');
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting)
                                                              return Text(
                                                                  'Loading...');
                                                            if (!snapshot
                                                                .hasData) {
                                                              print(snapshot
                                                                  .hasData);
                                                              return Container(
                                                                  child: Text(
                                                                'No Comments!!. Be the first to comment.',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        120),
                                                              ));
                                                            } else {
                                                              return ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage: NetworkImage(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['profileImageUrl']),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              snapshot.data!.docs[index].data()['name'],
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Text(snapshot.data!.docs[index].data()['content']),
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
                                              backgroundColor: Color.fromARGB(
                                                  202, 128, 144, 151),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            );
                                          },
                                          icon: Image.asset(
                                              ImageConstant.commentIcon)),
                                      const SizedBox(height: 7),
                                      Text(
                                        data.commentCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Special Comments',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ],
                );
              }),
        ));
  }
}
