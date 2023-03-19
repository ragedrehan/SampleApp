import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/constants/color_styles.dart';

class Loading extends StatelessWidget {
  final Color color;
  const Loading({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/loading.gif",
        height: 22.75.h,
        width: 22.75.w,
        color: ColorStyle.accentColor,
      ),
    );
  }
}
