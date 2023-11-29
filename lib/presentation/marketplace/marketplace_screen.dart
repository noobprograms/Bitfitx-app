import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/image_constant.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/presentation/marketplace/controllers/marketplace_controller.dart';
import 'package:bitfitx_project/presentation/marketplace/post_view_select.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/theme/app_decoration.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_image_view.dart';
import 'package:bitfitx_project/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../googleauth/controller/auth_controller.dart';

class Marketplace extends StatelessWidget {
  Marketplace({super.key});
  MarketplaceController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 32, 32),
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
                arguments: {'currentUser': controller.currentUser});
          },
          child: CustomImageView(
            svgPath: ImageConstant.imgArrow1,
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
      ),
      body: SingleChildScrollView(
          child: Container(
        width: mediaQueryData.size.width,
        padding: EdgeInsets.only(top: 68.v),
        decoration: AppDecoration.gradientBlackToPrimaryContainer,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bitfitx Marketplace',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  CustomElevatedButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => PostSelect(
                            currentUser: controller.currentUser,
                          ),
                        ),
                      );
                    },
                    text: 'Sell Post',
                    width: 123,
                    buttonStyle:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: firebaseFirestore
                      .collection('posts')
                      .where('onSale', isEqualTo: 'true')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error${snapshot.error}');
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Text('Loading...');
                    if (!snapshot.hasData) {
                      return Expanded(
                          child: Container(
                        child: const Center(
                          child: Text('No Posts on Sale'),
                        ),
                      ));
                    } else {
                      var myList = snapshot.data!.docs;
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // shrinkWrap: true,
                          children: myList.map((doc) {
                            return Column(
                              children: [
                                PostCard(
                                  currentUser: controller.currentUser,
                                  postID: doc.data()['pid'],
                                  postImageUrl: doc.data()['postPictureUrl'],
                                  description: doc.data()['content'],
                                  time: doc.data()['dateTime'],
                                  likes: doc.data()['likes'],
                                  comments: doc.data()['comments'],
                                  uid: doc.data()['uid'],
                                  interact: false,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(181, 181, 181, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$${doc.data()['price']}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      CustomElevatedButton(
                                        onTap: () {
                                          controller
                                              .collectPaymentInfo(context);
                                        },
                                        width: 141,
                                        text: 'Buy Post',
                                        buttonStyle: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      )),
    ));
  }
}
