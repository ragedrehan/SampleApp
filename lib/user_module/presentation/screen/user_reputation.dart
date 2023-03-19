import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/constants/color_styles.dart';
import 'package:sample/globle_files/constants/custom_text_style.dart';
import 'package:sample/user_module/busines_logic/cubit/user_reputation/user_reputation_cubit.dart';
import 'package:sample/user_module/model/user_model.dart';
import 'package:sample/user_module/presentation/widgets/loading.dart';
import 'package:sample/user_module/presentation/widgets/reputation_item.dart';

class UserReputation extends StatelessWidget {
  final UserModel user;
  const UserReputation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserReputationCubit>(context).fetchUserReputation({
      'user_id': user.id,
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyle.primaryColor,
        body: BlocConsumer<UserReputationCubit, UserReputationState>(
            listener: (context, state) {
              print("REHAN");
              print(state);

            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200.0,
                    backgroundColor: ColorStyle.accentColor,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(user.name!,style: CustomTextStyle.titleText(context,color: Colors.white,font: 18.sp),),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            user.avatar!,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is UserReputationInitial)
                    const SliverToBoxAdapter(),
                  if (state is UserReputationLoading)
                     SliverToBoxAdapter(child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child:const Loading())),
                  if (state is UserReputationLoaded)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ReputationItem(
                            reputation: state.reputation[index],
                          );
                        },
                        childCount: state.reputation.length,
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
