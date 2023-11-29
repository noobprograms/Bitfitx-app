import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/routes/app_routes.dart';
import 'package:bitfitx_project/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupCard extends StatelessWidget {
  GroupCard(
      {required this.gid,
      required this.adminUid,
      required this.groupName,
      required this.groupImage,
      required this.myUid,
      required this.requestingMembers,
      required this.toDisplay,
      super.key});
  String gid;
  String adminUid;
  String groupName;
  String groupImage;
  String myUid;
  List requestingMembers;
  bool toDisplay;
  var requested = false;

  @override
  Widget build(BuildContext context) {
    if (requestingMembers.contains(myUid)) requested = true;
    return GestureDetector(
      onTap: () {
        if (toDisplay) {
          Get.toNamed(AppRoutes.singleGroupView,
              arguments: {'groupName': groupName, 'gid': gid, 'myUid': myUid});
        }
      },
      child: Container(
        width: 193,
        padding: EdgeInsets.all(10),
        child: Container(
          width: 183,
          height: 110,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(groupImage),
              ),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(143, 158, 158, 158)),
                child: Text(
                  groupName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 6),
              !toDisplay
                  ? StatefulBuilder(
                      builder: (context, setState) => CustomElevatedButton(
                        onTap: () async {
                          if (requested == true) {
                            setState(() {
                              requested = false;
                            });
                            requestingMembers.remove(myUid);
                            await firebaseFirestore
                                .collection('groups')
                                .doc(gid)
                                .update(
                                    {'requestingMembers': requestingMembers});
                          } else {
                            setState(() {
                              requested = true;
                            });
                            requestingMembers.add(myUid);
                            await firebaseFirestore
                                .collection('groups')
                                .doc(gid)
                                .update(
                                    {'requestingMembers': requestingMembers});
                          }
                        },
                        text: requested ? 'Requested' : 'Join',
                        width: 100,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
