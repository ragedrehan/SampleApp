import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/user_module/model/user_model.dart';
import 'package:sample/user_module/presentation/widgets/loading.dart';
import 'user_item.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel> users;
  final ScrollController scrollController;
  final Function scrollControllerListener;
  final bool isFetchingMore;

  const UserListWidget(
      {Key? key,
      required this.users,
      required this.scrollController,
      required this.scrollControllerListener, this.isFetchingMore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController
        ..addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            scrollControllerListener();
          }
        }),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      itemCount: users.length + (isFetchingMore ? 1 : 0),
      itemBuilder: (context, int index) {
        if (index < users.length) {
          return UserItem(user: users[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(child: Loading()),
          );
        }
      },
    );
  }
}
