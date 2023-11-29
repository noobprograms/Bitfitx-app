import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/account_screen/otherAccount_screen.dart';
import 'package:bitfitx_project/presentation/verified_videos_screen/controller/verified_videos_controller.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/theme/custom_text_style.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:bitfitx_project/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/auth_constants.dart';

class VerifiedVidScreen extends StatelessWidget {
  VerifiedVidScreen(this.cUser, {super.key});
  final User cUser;

  @override
  Widget build(BuildContext context) {
    // VerifiedVidController controller = Get.put(VerifiedVidController());
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Colors.black,
    //     extendBody: true,
    //     extendBodyBehindAppBar: true,
    //     appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent,
    //       titleSpacing: 0,
    //       leadingWidth: 47.h,
    //       leading: InkWell(
    //         onTap: () {
    //           Get.bottomSheet(Container(
    //             height: mediaQueryData.size.height - 20,
    //             child: Column(
    //               children: [
    //                 SizedBox(
    //                   height: 16,
    //                 ),
    //                 TextField(
    //                   onChanged: (value) {
    //                     controller.messageTextChanged(value);
    //                     // print('I am${searchResults.length}');
    //                   },
    //                   controller: controller.searchUserInput,
    //                   decoration: InputDecoration(
    //                     filled: true,
    //                     fillColor: Colors.white,
    //                     hintText: 'Search',
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(25.h),
    //                       borderSide: BorderSide.none,
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(25.h),
    //                       borderSide: BorderSide.none,
    //                     ),
    //                     focusedBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(25.h),
    //                       borderSide: BorderSide.none,
    //                     ),
    //                   ),
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Expanded(
    //                     child: Obx(() => ListView.separated(
    //                         itemCount: controller.searchResults.value.length,
    //                         separatorBuilder: (context, index) => SizedBox(
    //                               height: 10,
    //                             ),
    //                         itemBuilder: (context, index) {
    //                           // print(
    //                           //     'I am ${controller.searchResults.value[index]["name"]}');
    //                           var instantUser = User(
    //                               uid: controller.searchResults.value[index]
    //                                   ['uid'],
    //                               name: controller.searchResults.value[index]
    //                                   ['name'],
    //                               email: controller.searchResults.value[index]
    //                                   ['email'],
    //                               profileImageUrl: controller.searchResults
    //                                   .value[index]['profileImageUrl'],
    //                               coverImageUrl: controller.searchResults
    //                                   .value[index]['coverImageUrl'],
    //                               tokenValue: controller
    //                                   .searchResults.value[index]['tokenValue'],
    //                               following: controller
    //                                   .searchResults.value[index]['following'],
    //                               fans: controller.searchResults.value[index]
    //                                   ['fans']);
    //                           return GestureDetector(
    //                             onTap: () {
    //                               Navigator.push(context,
    //                                   MaterialPageRoute(builder: (context) {
    //                                 return OtherAccount(cUser, instantUser);
    //                               }));
    //                             },
    //                             child: Row(
    //                               children: [
    //                                 CircleAvatar(
    //                                   backgroundImage: NetworkImage(controller
    //                                       .searchResults
    //                                       .value[index]['profileImageUrl']),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 16,
    //                                 ),
    //                                 Expanded(
    //                                   child: Text(
    //                                       controller.searchResults.value[index]
    //                                           ['name'],
    //                                       overflow: TextOverflow.ellipsis,
    //                                       style: TextStyle(
    //                                           color: Colors.white,
    //                                           fontWeight: FontWeight.bold,
    //                                           fontSize: 19)),
    //                                 )
    //                               ],
    //                             ),
    //                           );
    //                         })))
    //               ],
    //             ),
    //           ));
    //         },
    //         child: CustomImageView(
    //           imagePath: ImageConstant.search,
    //           margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
    //         ),
    //       ),
    //       centerTitle: true,
    //       title: InkWell(
    //         onTap: () {
    //           Get.put(AuthController());
    //           authController.signOut();
    //         },
    //         child: CustomImageView(
    //           imagePath: ImageConstant.imgRemoval1,
    //           width: 60.h,
    //         ),
    //       ),
    //       actions: [
    //         InkWell(
    //           onTap: () {
    //             controller.goToMessages(cUser);
    //           },
    //           child: CustomImageView(
    //             imagePath: ImageConstant.chat,
    //             margin: EdgeInsets.fromLTRB(11.h, 19.v, 11.h, 15.v),
    //           ),
    //         )
    //       ],
    //     ),
    //     body: SingleChildScrollView(
    //       child: Container(
    //         width: mediaQueryData.size.width,
    //         // height: mediaQueryData.size.height,
    //         padding: EdgeInsets.only(top: 68.v),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text(
    //                 'Verified Videos',
    //                 style: CustomTextStyles.headlineLargeOnPrimaryContainer,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: StreamBuilder(
    //                 stream: firebaseFirestore
    //                     .collection('videos')
    //                     .orderBy('dateTime', descending: true)
    //                     .snapshots(),
    //                 builder: (context, snapshot) {
    //                   if (snapshot.hasError)
    //                     return Text('Error${snapshot.error}');
    //                   if (snapshot.connectionState == ConnectionState.waiting)
    //                     return Text('Loading...');
    //                   if (snapshot.hasData) {
    //                     var myList = snapshot.data!.docs;
    //                     print(myList.length);
    //                     return Expanded(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         // shrinkWrap: true,
    //                         children: myList.map((doc) {
    //                           return VideoCard(
    //                             currentUser: cUser,
    //                             vid: doc.data()['vid'],
    //                             videoUrl: doc.data()['videoUrl'],
    //                             description: doc.data()['content'],
    //                             time: doc.data()['dateTime'],
    //                             likes: doc.data()['likes'],
    //                             comments: doc.data()['comments'],
    //                             uid: doc.data()['uid'],
    //                             interact: true,
    //                           );
    //                         }).toList(),
    //                       ),
    //                     );
    //                   } else {
    //                     return Center(child: Text('No videos to display'));
    //                   }
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset(ImageConstant.commingSoon)],
      ),
    );
  }
}
