import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/constants/color_styles.dart';
import 'package:sample/globle_files/constants/custom_text_style.dart';
import 'package:sample/user_module/busines_logic/cubit/users/users_cubit.dart';
import 'package:sample/user_module/busines_logic/cubit/view_selection/view_selection_cubit.dart';
import 'package:sample/user_module/presentation/widgets/loading.dart';
import 'package:sample/user_module/presentation/widgets/user_list_widget.dart';

class UserList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersCubit>(context).fetchUsers({
      'page_no': BlocProvider.of<UsersCubit>(context).pageNo,
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyle.primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Stackoverflow User",
            style: CustomTextStyle.titleText(context,
                color: ColorStyle.whiteColor),
          ),
          backgroundColor: ColorStyle.accentColor,
          actions: <Widget>[
            BlocBuilder<ViewSelectionCubit, ViewSelectionState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: IconButton(
                    icon: Icon(
                      (state is Users) ? Icons.bookmark_border : Icons.bookmark,
                      color: ColorStyle.whiteColor,
                    ),
                    onPressed: () {
                      if ((state is Users)) {
                        BlocProvider.of<UsersCubit>(context).fetchBookmarkUsers();
                        BlocProvider.of<ViewSelectionCubit>(context).viewSelection(true);
                      } else {
                        BlocProvider.of<UsersCubit>(context)
                            .toggleToUserListing();
                        BlocProvider.of<ViewSelectionCubit>(context)
                            .viewSelection(false);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<UsersCubit, UsersState>(
          listener: (context, state) {},
          builder: (context, state) {
            return (Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state is UsersInitial) const SizedBox(),
                if (state is UsersLoading)
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Loading()),
                if (state is UsersLoaded)
                  Expanded(
                    child: UserListWidget(
                      users: state.users,
                      scrollController: _scrollController,
                      isFetchingMore: state.isFetchingMore,
                      scrollControllerListener: () {
                        BlocProvider.of<UsersCubit>(context).fetchMoreUsers();
                      },
                    ),
                  ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
