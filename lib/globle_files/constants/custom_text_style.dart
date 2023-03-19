import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_styles.dart';

class CustomTextStyle {
  static String fontFamilySelector(BuildContext context) {
    return 'Poppins';
  }

  static titleText(BuildContext context,
      {double font = 16.0, Color color = ColorStyle.txtPrimaryColor1}) {
    return TextStyle(
        fontFamily: fontFamilySelector(context),
        fontSize: font.sp,
        fontWeight: FontWeight.w500,
        color: color);
  }

  static bodyText(BuildContext context,
      {double font = 14.0, Color color = ColorStyle.txtPrimaryColor2}) {
    return TextStyle(
        fontSize: font.sp,
        fontFamily: fontFamilySelector(context),
        fontWeight: FontWeight.w400,
        color: color);
  }

  static caption(BuildContext context,
      {double font = 12.0, Color color = ColorStyle.txtPrimaryColor2}) {
    return TextStyle(
        fontSize: font.sp,
        fontFamily: fontFamilySelector(context),
        fontWeight: FontWeight.w400,
        color: color);
  }
}
