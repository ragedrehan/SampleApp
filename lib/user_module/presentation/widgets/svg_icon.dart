import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/globle_files/constants/color_styles.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.imageName,
    this.color = ColorStyle.primaryColor,
    this.width = 22,
    this.height = 22,
  }) : super(key: key);

  final String imageName;
  final Color? color;
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$imageName.svg',
      semanticsLabel: imageName,
      width: width!.w,
      height: height!.h,
      cacheColorFilter: false,
      color: color,
    );
  }
}
