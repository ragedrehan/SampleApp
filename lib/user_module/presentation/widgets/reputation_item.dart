import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/constants/color_styles.dart';
import 'package:sample/globle_files/constants/custom_text_style.dart';
import 'package:sample/user_module/model/repuation_model.dart';

class ReputationItem extends StatelessWidget {
  final ReputationModel reputation;

  const ReputationItem({Key? key, required this.reputation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorStyle.lineStroke,
              width: 0.5,
            ),
          ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reputation.reputationHistoryType!,
                  style: CustomTextStyle.titleText(context,
                      color: ColorStyle.txtPrimaryColor1),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  reputation.reputationChange.toString(),
                  style: CustomTextStyle.bodyText(context),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
