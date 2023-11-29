import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/agora_appID.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/data/story_data.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/live_user_widget.dart';
import 'package:bitfitx_project/widgets/post_widget.dart';
import 'package:bitfitx_project/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  Home(this.cUser, {super.key});
  final cUser;

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    mediaQueryData = MediaQuery.of(context);
    print('this is home ${cUser.tokenValue!}');
    controller.getAllUsers(cUser);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leadingWidth: 47.h,
          leading: InkWell(
            onTap: () {
              Get.bottomSheet(Container(
                height: mediaQueryData.size.height - 20,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (value) {
                        controller.messageTextChanged(value);
                        // print('I am${searchResults.length}');
                      },
                      controller: controller.searchUserInput,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.h),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.h),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.h),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Obx(() => ListView.separated(
                            itemCount: controller.searchResults.value.length,
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemBuilder: (context, index) {
                              // print(
                              //     'I am ${controller.searchResults.value[index]["name"]}');
                              var instantUser = User(
                                  uid: controller.searchResults.value[index]
                                      ['uid'],
                                  name: controller.searchResults.value[index]
                                      ['name'],
                                  email: controller.searchResults.value[index]
                                      ['email'],
                                  profileImageUrl: controller.searchResults
                                      .value[index]['profileImageUrl'],
                                  coverImageUrl: controller.searchResults
                                      .value[index]['coverImageUrl'],
                                  tokenValue: controller
                                      .searchResults.value[index]['tokenValue'],
                                  following: controller
                                      .searchResults.value[index]['following'],
                                  fans: controller.searchResults.value[index]
                                      ['fans']);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OtherAccount(cUser, instantUser);
                                  }));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(controller
                                          .searchResults
                                          .value[index]['profileImageUrl']),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Text(
                                          controller.searchResults.value[index]
                                              ['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19)),
                                    )
                                  ],
                                ),
                              );
                            })))
                  ],
                ),
              ));
            },
            child: CustomImageView(
              imagePath: ImageConstant.search,
              margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
            ),
          ),
          centerTitle: true,
          title: InkWell(
            onTap: () {
              Get.put(AuthController());
              authController.signOut();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgRemoval1,
              width: 60.h,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                controller.goToMessages(cUser);
              },
              child: CustomImageView(
                imagePath: ImageConstant.chat,
                margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: mediaQueryData.size.width,
            // height: mediaQueryData.size.height,
            padding: EdgeInsets.only(top: 68.v),
            decoration: AppDecoration.gradientBlackToPrimaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Stories',
                    style: CustomTextStyles.headlineLargeOnPrimaryContainer,
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.addStory(cUser, context);
                            },
                            child: Padding(
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
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                          cUser.profileImageUrl,
                                        ),
                                        child: Center(child: Icon(Icons.add)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Your Story',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      StreamBuilder(
                          stream: firebaseFirestore
                              .collection('stories_live')
                              .where('uid', isNotEqualTo: cUser.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text('Error${snapshot.error}');
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Text('Loading...');
                            if (snapshot.hasData) {
                              return Row(
                                children: snapshot.data!.docs
                                    .map((e) => GestureDetector(
                                          onTap: () {
                                            controller.openStory(
                                                e.data()!['name'],
                                                e.data()!['profileImageUrl'],
                                                e.data()!['uid'],
                                                snapshot.data!.docs);
                                          },
                                          child: StoryWidget(
                                            name: e.data()!['name'],
                                            profileImageUrl:
                                                e.data()!['profileImageUrl'],
                                            uid: e.data()!['uid'],
                                            isEdit: false,
                                          ),
                                        ))
                                    .toList(),
                              );
                            } else
                              return Container();
                          })
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    'Live Now',
                    style: CustomTextStyles.headlineLargeOnPrimaryContainer,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder(
                        stream: firebaseFirestore
                            .collection('liveusers')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error${snapshot.error}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text('Loading...');
                          if (snapshot.hasData) {
                            var myList = snapshot.data!.docs;
                            return Row(
                              children: myList
                                  .map((e) => LiveUserWidget(
                                      coverImage: e['coverImageUrl'],
                                      profileImage: e['profileImageUrl'],
                                      name: e['name'],
                                      tokenValue: e['token'],
                                      channelName: e['channelName']))
                                  .toList(),
                            );
                          } else
                            return Center(
                              child: Text(
                                'No one is live right now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                        }),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Posts',
                        style: CustomTextStyles.headlineLargeOnPrimaryContainer,
                      ),
                      CustomElevatedButton(
                        onTap: () async {
                          // Get.toNamed(AppRoutes.marketplace,
                          //     arguments: {'cUser': cUser});

                          Get.dialog(Container(
                              height: 200,
                              width: mediaQueryData.size.width / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage(ImageConstant.commingSoon)),
                              )));
                        },
                        text: 'Buy Posts',
                        width: 141,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('posts')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error${snapshot.error}');
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text('Loading...');
                      if (snapshot.hasData) {
                        var myList = snapshot.data!.docs;
                        print(myList.length);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // shrinkWrap: true,
                          children: myList.map((doc) {
                            return PostCard(
                              currentUser: cUser,
                              postID: doc.data()['pid'],
                              postImageUrl: doc.data()['postPictureUrl'],
                              description: doc.data()['content'],
                              time: doc.data()['dateTime'],
                              likes: doc.data()['likes'],
                              comments: doc.data()['comments'],
                              uid: doc.data()['uid'],
                              interact: true,
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(child: Text('No posts to display'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
