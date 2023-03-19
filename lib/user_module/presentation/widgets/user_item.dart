import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/constants/color_styles.dart';
import 'package:sample/globle_files/constants/custom_text_style.dart';
import 'package:sample/globle_files/utils/helper.dart';
import 'package:sample/user_module/busines_logic/cubit/user_reputation/user_reputation_cubit.dart';
import 'package:sample/user_module/busines_logic/cubit/users/users_cubit.dart';
import 'package:sample/user_module/model/user_model.dart';
import 'package:sample/user_module/presentation/screen/user_reputation.dart';
import 'package:sample/user_module/presentation/widgets/cache_image_widget.dart';
import 'package:sample/user_module/repository/user_repository.dart';

class UserItem extends StatelessWidget {
  final UserModel user;

  const UserItem({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: roundAllCorners(
        5.sp,
        bgColor: ColorStyle.whiteColor,
      ),
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: InkWell(
        onTap: () {
          pushTo(context, Builder(builder: (context) {
            return BlocProvider(
              create: (_) => UserReputationCubit(
                  RepositoryProvider.of<UserRepository>(context)),
              child: UserReputation(user: user),
            );
          }));
        },
        child: Row(
          children: [
            CacheImageWidget(
              height: 45.h,
              width: 50.w,
              imageUrl: user.avatar!,
              radius: 40.r,
            ),
            SizedBox(
              width: 10.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!,
                    style: CustomTextStyle.titleText(context,
                        color: ColorStyle.txtPrimaryColor1, font: 14),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    user.location.toString(),
                    style: CustomTextStyle.caption(context),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                (user.isBookmark) ? Icons.bookmark : Icons.bookmark_border,
                color: ColorStyle.accentColor,
              ),
              onPressed: () {
                if (user.isBookmark) {
                  BlocProvider.of<UsersCubit>(context).removeBookmark(user);
                } else {
                  BlocProvider.of<UsersCubit>(context).addBookmark(user);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
