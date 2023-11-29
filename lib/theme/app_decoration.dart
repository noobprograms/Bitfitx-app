import 'package:flutter/material.dart';
import 'package:bitfitx_project/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillOnSecondary => BoxDecoration(
        color: theme.colorScheme.onSecondary,
      );

  // Gradient decorations
  static BoxDecoration get gradientBlackToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(0.95, 1),
          colors: [
            appTheme.black900,
            appTheme.black900.withOpacity(1),
          ],
        ),
      );
  static BoxDecoration get gradientBlackToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.13, 0.97),
          end: Alignment(1, -0.11),
          colors: [
            appTheme.black900,
            appTheme.grayMORE,
          ],
        ),
      );
  static BoxDecoration get gradientBlackToOnError => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.12, 1.01),
          end: Alignment(0.95, -0.05),
          colors: [
            appTheme.black900,
            theme.colorScheme.onError,
          ],
        ),
      );
  static BoxDecoration get gradientBlueGrayAdToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(1.02, 0.94),
          colors: [
            appTheme.blueGray900Ad,
            appTheme.grayMORE,
          ],
        ),
      );
  static BoxDecoration get gradientBlackToPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            appTheme.black900,
            theme.colorScheme.primaryContainer,
          ],
        ),
      );
  static BoxDecoration get gradientBlueGrayAdToBlueGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.black,
            Color.fromARGB(255, 49, 49, 49),
            const Color.fromARGB(255, 27, 26, 26),
          ],
        ),
      );
  // static BoxDecoration get gradientHomeAndAbove => BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.bottomLeft,
  //         end: Alignment.topRight,
  //         colors: [
  //           appTheme.black900,
  //           theme.colorScheme.primaryContainer,
  //         ],
  //       ),
  //     );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL25 => BorderRadius.vertical(
        top: Radius.circular(25.h),
      );
  // Circle borders
  static BorderRadius get circleBorder32 => BorderRadius.circular(
        32.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25.h,
      );
}

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
