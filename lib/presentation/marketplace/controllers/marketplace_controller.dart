import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:bitfitx_project/.env';
import 'package:path/path.dart';

class MarketplaceController extends GetxController {
  User currentUser = Get.arguments['cUser'];
  TextEditingController priceFieldController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
  }

  //selling your posts
  void collectPaymentInfo(BuildContext context) {
    Get.bottomSheet(
        Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Card Details',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardFormField(
                    controller: CardFormEditController(),
                    style: CardFormStyle(
                        backgroundColor: Colors.white, borderRadius: 10),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomElevatedButton(
                    text: 'Pay',
                    buttonStyle:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onTap: () {},
                  )
                ],
              ),
            )),
        backgroundColor: Color.fromARGB(255, 128, 125, 125));
  }
}
