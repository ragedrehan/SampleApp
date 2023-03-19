import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/globle_files/network/network_requests.dart';
import 'package:sample/user_module/busines_logic/cubit/user_reputation/user_reputation_cubit.dart';
import 'package:sample/user_module/busines_logic/cubit/users/users_cubit.dart';
import 'package:sample/user_module/busines_logic/cubit/view_selection/view_selection_cubit.dart';
import 'package:sample/user_module/repository/users_local_database.dart';
import 'package:sample/user_module/repository/user_repository.dart';
import 'user_module/presentation/screen/user_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_bloc/src/repository_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiRepositoryProvider(
      providers: repos,
      child: MultiBlocProvider(providers: bloc, child: MyApp())));
}

List<SingleChildWidget> get bloc {
  return [
    BlocProvider<UsersCubit>(create: (context) {
      return UsersCubit(RepositoryProvider.of<UserRepository>(context),DatabaseHelper.instance);
    }),
    BlocProvider<ViewSelectionCubit>(create: (context) {
      return ViewSelectionCubit();
    }),
    BlocProvider<UserReputationCubit>(create: (context) {
      return UserReputationCubit(
          RepositoryProvider.of<UserRepository>(context));
    }),
  ];
}

List<SingleChildWidget> get repos {
  return [
    RepositoryProvider(
      create: (context) => UserRepository(NetworkRequests()),
    ),
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: UserList());
  }
}
