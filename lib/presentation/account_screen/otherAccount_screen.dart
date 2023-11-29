import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/presentation/account_screen/controller/account_controller.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class OtherAccount extends StatelessWidget {
  OtherAccount(this.currentUser, this.otherUser, {super.key});
  final otherUser;
  final currentUser;
  AccountController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.saveUser(otherUser);
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
            Get.offAndToNamed(AppRoutes.tabbedScreen,
                arguments: {'currentUser': currentUser});
          },
          child: CustomImageView(
            svgPath: ImageConstant.imgArrow1,
            margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
          ),
        ),
        centerTitle: true,
        title: InkWell(
          onTap: () {},
          child: CustomImageView(
            imagePath: ImageConstant.imgRemoval1,
            width: 60.h,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          padding: EdgeInsets.only(
            top: 75.v,
            left: 15,
            right: 15,
          ),
          decoration: AppDecoration.gradientBlackToPrimaryContainer,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Obx(
              () => Container(
                height: mediaQueryData.size.height / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: controller.coverImageExists.value
                          ? NetworkImage(controller.coverImageToDisplay.value)
                          : AssetImage(controller.coverImageToDisplay.value)
                              as ImageProvider,
                    ),
                    color: const Color.fromARGB(255, 100, 99, 99)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(otherUser.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    StreamBuilder(
                        stream: firebaseFirestore
                            .collection('users')
                            .doc(otherUser.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error${snapshot.error}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text('Loading...');
                          var myuser = snapshot.data!.data();

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        otherUser.profileImageUrl,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(myuser!['posts'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Posts',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    children: [
                                      Text(myuser!['fans'].length.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Fans',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          myuser!['following']
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Following',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              CustomElevatedButton(
                                width: 250,
                                text: myuser!['fans'].contains(currentUser.uid)
                                    ? 'Unfollow'
                                    : 'Follow',
                                onTap: () async {
                                  if (myuser!['fans']
                                      .contains(currentUser.uid)) {
                                    var fansList = myuser!['fans'];

                                    ///fans of other user
                                    fansList.remove(currentUser.uid);
                                    await firebaseFirestore
                                        .collection('users')
                                        .doc(otherUser.uid)
                                        .update({'fans': fansList});

                                    var followingList = currentUser.following;

                                    ///followings of current user
                                    followingList.remove(otherUser.uid);
                                    await firebaseFirestore
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .update({'following': followingList});
                                  } else {
                                    var fansList = myuser!['fans'];
                                    fansList.add(currentUser.uid);
                                    await firebaseFirestore
                                        .collection('users')
                                        .doc(otherUser.uid)
                                        .update({'fans': fansList});

                                    var followingList = currentUser.following;

                                    ///followings of current user
                                    followingList.add(otherUser.uid);
                                    await firebaseFirestore
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .update({'following': followingList});
                                  }
                                },
                              )
                            ],
                          );
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Posts',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                    width: mediaQueryData.size.width,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(48, 47, 47, 1),
                              Color.fromRGBO(141, 139, 139, 0)
                            ])),
                    child: StreamBuilder(
                        stream: firebaseFirestore
                            .collection('posts')
                            .where('uid', isEqualTo: otherUser.uid)
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error${snapshot.error}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text('Loading...');
                          return GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: snapshot.data!.docs
                                .map((doc) => Container(
                                      height: 98,
                                      width: 98,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Image.network(
                                          doc.data()['postPictureUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }))))
          ]),
        ),
      ),
    ));
  }
}
