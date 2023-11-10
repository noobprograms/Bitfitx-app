import 'package:bitfitx_project/core/utils/size_utils.dart';
import 'package:bitfitx_project/presentation/story_screen/controller/story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedBar extends StatelessWidget {
  AnimatedBar(
      {Key? key,
      required this.animationController,
      required this.position,
      required this.currentindex})
      : super(key: key);
  final AnimationController animationController;
  final int position;
  final int currentindex;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    final w = mediaQueryData.size.width;
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: <Widget>[
              _buildContainer(
                double.infinity,
                position < currentindex
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
              position == currentindex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return _buildContainer(
                            constraints.maxWidth * animationController.value,
                            Colors.white);
                      })
                  : const SizedBox.shrink(),
            ],
          );
        }),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 2.0,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black26, width: 0.8),
          borderRadius: BorderRadius.circular(3.0)),
    );
  }
}
