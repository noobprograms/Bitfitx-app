import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupRequestView extends StatelessWidget {
  GroupRequestView(this.cUser, {super.key});
  User cUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 47.h,
        leading: InkWell(
          onTap: () {
            Get.offAndToNamed(AppRoutes.tabbedScreen,
                arguments: {'currentUser': cUser});
          },
          child: CustomImageView(
            svgPath: ImageConstant.imgArrow1,
            margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text('Join Requests'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          width: mediaQueryData.size.width,
          child: StreamBuilder(
            stream: firebaseFirestore
                .collection('groups')
                .where('adminUid', isEqualTo: cUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Error${snapshot.error}');
              if (snapshot.connectionState == ConnectionState.waiting)
                return Text('Loading...');
              if (snapshot.hasData) {
                var myList = snapshot.data!.docs;
                return Column(
                  children: myList.map((element) {
                    List allrequests = element.data()['requestingMembers'];
                    if (allrequests.isEmpty) {
                      return Center(
                        child: Container(),
                      );
                    } else {
                      return StreamBuilder(
                        stream: firebaseFirestore
                            .collection('users')
                            .where('uid', whereIn: allrequests)
                            .snapshots(),
                        builder: (context, snap) {
                          if (snap.hasError) return Text('Error${snap.error}');
                          if (snap.connectionState == ConnectionState.waiting)
                            return Text('Loading...');
                          if (snap.hasData) {
                            var userList = snap.data!.docs;
                            return Column(
                              children: userList
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                e.data()['profileImageUrl']),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.data()["name"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "Wants to join ${element.data()['groupName']}")
                                              ],
                                            ),
                                          ),
                                          CustomElevatedButton(
                                            onTap: () async {
                                              allrequests
                                                  .remove(e.data()['uid']);
                                              await firebaseFirestore
                                                  .collection('groups')
                                                  .doc(element.data()['gid'])
                                                  .update({
                                                'requestingMembers': allrequests
                                              });
                                              var members =
                                                  element.data()['members'];
                                              members.add(e.data()['uid']);
                                              await firebaseFirestore
                                                  .collection('groups')
                                                  .doc(element.data()['gid'])
                                                  .update({'members': members});
                                            },
                                            text: 'Approve',
                                            width: 140,
                                          )
                                        ]),
                                      ))
                                  .toList(),
                            );
                          } else {
                            return Center(
                              child: Text('No data to show'),
                            );
                          }
                        },
                      );
                    }
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text('No data to show'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
