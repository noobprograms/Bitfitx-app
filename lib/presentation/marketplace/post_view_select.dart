import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/presentation/marketplace/controllers/marketplace_controller.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:bitfitx_project/widgets/custom_text_form_field.dart';
import 'package:bitfitx_project/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSelect extends StatelessWidget {
  PostSelect({required this.currentUser, super.key});
  final User currentUser;
  MarketplaceController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firebaseFirestore
            .collection('posts')
            .where('uid', isEqualTo: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Text('Loading...');
          if (snapshot.hasData) {
            var myList = snapshot.data!.docs;
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // shrinkWrap: true,
                children: myList.map((doc) {
                  return GestureDetector(
                    onTap: () async {
                      Get.defaultDialog(
                          title: 'Enter the selling price',
                          content: Column(
                            children: [
                              Text('\$0.5 will be charged on each sale'),
                              CustomTextFormField(
                                width: 150,
                                textInputType: TextInputType.number,
                                hintText: 'Enter a comment',
                                controller: controller.priceFieldController,
                              ),
                              CustomElevatedButton(
                                text: 'Place on marketplace',
                                onTap: () async {
                                  await firebaseFirestore
                                      .collection('posts')
                                      .doc(doc.data()['pid'])
                                      .update({
                                    'onSale': 'true',
                                    'price':
                                        controller.priceFieldController.text
                                  });
                                  controller.priceFieldController.text = "";
                                  Get.close(2);
                                },
                              )
                            ],
                          ));
                    },
                    child: PostCard(
                      currentUser: currentUser,
                      postID: doc.data()['pid'],
                      postImageUrl: doc.data()['postPictureUrl'],
                      description: doc.data()['content'],
                      time: doc.data()['dateTime'],
                      likes: doc.data()['likes'],
                      comments: doc.data()['comments'],
                      uid: doc.data()['uid'],
                      interact: false,
                    ),
                  );
                }).toList(),
              ),
            );
          } else
            return Center(
              child: Text('No posts to sell'),
            );
        });
  }
}
