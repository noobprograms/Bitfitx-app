import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:bitfitx_project/presentation/groups_screen/controller/groups_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:bitfitx_project/widgets/group_requests.dart';
import 'package:bitfitx_project/widgets/group_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsScreen extends StatelessWidget {
  GroupsScreen(this.cUser, {super.key});

  final User cUser;

  @override
  Widget build(BuildContext context) {
    GroupsController controller = Get.put(GroupsController());
    controller.getAllUsers(cUser);
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomElevatedButton(
                        onTap: () {
                          controller.createGroup(cUser);
                        },
                        text: 'Create Group',
                        leftIcon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        width: 150,
                      ),
                      CustomElevatedButton(
                        text: "Join Requests",
                        width: 150,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GroupRequestView(cUser)));
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Group Recommendations',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 26),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder(
                      stream:
                          firebaseFirestore.collection('groups').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error${snapshot.error}');
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Text('Loading...');
                        if (snapshot.hasData) {
                          var myList = snapshot.data!.docs;
                          var joinAbleList = myList.where((element) =>
                              !element.data()['members'].contains(cUser.uid));
                          return Row(
                            children: joinAbleList
                                .map((e) => GroupCard(
                                      myUid: cUser.uid,
                                      requestingMembers:
                                          e.data()['requestingMembers'],
                                      gid: e.data()['gid'],
                                      adminUid: e.data()['adminUid'],
                                      groupName: e.data()['groupName'],
                                      groupImage: e.data()['groupImageUrl'],
                                      toDisplay: false,
                                    ))
                                .toList(),
                          );
                        } else
                          return Center(
                            child: Text('No recommendations right now'),
                          );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Joined Groups',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 26),
                  ),
                ),
                Container(
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height * 0.5,
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: StreamBuilder(
                      stream: firebaseFirestore
                          .collection('groups')
                          .where('members', arrayContains: cUser.uid)
                          .snapshots(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error${snapshot.error}');
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Text('Loading...');
                        return GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            children: snapshot.data!.docs
                                .map((e) => GroupCard(
                                      gid: e.data()['gid'],
                                      adminUid: e.data()['adminUid'],
                                      groupName: e.data()['groupName'],
                                      groupImage: e.data()['groupImageUrl'],
                                      myUid: cUser.uid,
                                      requestingMembers:
                                          e.data()['requestingMembers'],
                                      toDisplay: true,
                                    ))
                                .toList());
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
