import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:bitfitx_project/presentation/trending_screen/controller/trending_controller.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:bitfitx_project/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen(this.cUser, {super.key});
  final User cUser;

  @override
  Widget build(BuildContext context) {
    TrendingController controller = Get.put(TrendingController());
    controller.getAllUsers(cUser);
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(188, 4, 4, 4),
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
            padding: EdgeInsets.only(top: 68.v),
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending Posts',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 170, 15, 4),
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('posts')
                        .orderBy('likes', descending: true)
                        .limit(2)
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
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Trending Videos',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 170, 15, 4),
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
