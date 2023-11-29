import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/presentation/groups_screen/controller/single_group_view_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleGroupView extends StatelessWidget {
  SingleGroupView({super.key});
  SingleGroupViewController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(controller.groupName),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: mediaQueryData.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    text: 'Add Post',
                    buttonStyle:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    width: 100,
                    onTap: () {
                      controller.postAdder(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection('group_posts')
                        .where('gid', isEqualTo: controller.gid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error${snapshot.error}');
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text('Loading...');
                      if (snapshot.hasData) {
                        var myList = snapshot.data!.docs;
                        print(myList.length);
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // shrinkWrap: true,
                            children: myList.map((doc) {
                              return PostCard(
                                currentUser: controller.currentUser,
                                postID: doc.data()['pid'],
                                postImageUrl: doc.data()['postPictureUrl'],
                                description: doc.data()['content'],
                                time: doc.data()['dateTime'],
                                likes: doc.data()['likes'],
                                comments: doc.data()['comments'],
                                uid: doc.data()['uid'],
                                interact: true,
                                groupPost: true,
                              );
                            }).toList(),
                          ),
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
