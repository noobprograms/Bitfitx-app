import 'package:bitfitx_project/core/app_export.dart';
import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/data/story_data.dart';
import 'package:bitfitx_project/googleauth/controller/auth_controller.dart';
import 'package:bitfitx_project/presentation/home_screen/controller/home_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home(this.cUser, {super.key});
  final cUser;
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    print('this is home ${cUser.tokenValue!}');

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
            onTap: () {},
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
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
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
                child: ListView.builder(
                  itemCount: storyListUser.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return StoryWidget(
                        goToStory: () {
                          controller.addStory(cUser, context);
                        },
                        user: cUser,
                        isEdit: true,
                      );
                    else
                      return StoryWidget(
                        goToStory: controller.openStory,
                        user: storyListUser[index - 1].user,
                      );
                  },
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
              ////////////////////////////////////////////////////////////
              ///
              ///
              ///
              ///
              ///////////////////////////////////////////////////////////
              ///
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Posts',
                      style: CustomTextStyles.headlineLargeOnPrimaryContainer,
                    ),
                    // CustomElevatedButton(text: 'Buy Posts'),
                  ],
                ),
              ),
              StreamBuilder(
                stream: firebaseFirestore.collection('posts').snapshots(),
                builder: ((context, snapshot) {
                  var myList = snapshot.data!.docs;
                  print(myList);
                  return ListView.builder(
                    itemBuilder: ((context, index) {
                      return Container(
                        width: 369,
                        height: 296,
                        color: Color.fromRGBO(47, 47, 47, 1),
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
