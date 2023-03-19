import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/user_module/model/user_model.dart';
import 'package:sample/user_module/repository/users_local_database.dart';
import 'package:sample/user_module/repository/user_repository.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UserRepository userRepository;
  DatabaseHelper databaseHelper;
  int pageNo = 1;

  UsersCubit(this.userRepository, this.databaseHelper) : super(UsersInitial());

  Future<void> fetchUsers(Map<String, dynamic> params) async {
    try {
      if(userRepository.hasMore) {
        if (pageNo == 1) {
          emit(UsersLoading());
        } else {
          emit(UsersLoaded(users: userRepository.users, isFetchingMore: true));
        }
        List<UserModel> users = await userRepository.fetchUsers(params);
        users = await updateBookmarkedInUsersListing(users);
        emit(UsersLoaded(users: users, isFetchingMore: false));
      }
    } on Exception catch (e) {
      emit(UsersError(e.toString()));
    }

  }

  void fetchMoreUsers(){
    pageNo++;
    fetchUsers({
      'page_no': pageNo,
    });
  }

  Future<void> toggleToUserListing() async {
    try {
        emit(UsersLoaded(users: userRepository.users));
    } on Exception {
      emit(const UsersError("Something went wrong."));
    }
  }

  Future<void> fetchBookmarkUsers() async {
    try {
      List<UserModel> users = await databaseHelper.fetchBookmarkUsers();
      emit(UsersLoaded(users: users, isFetchingMore: false));
    } on Exception {
      emit(const UsersError("Something went wrong."));
    }
  }


  Future<void> addBookmark(UserModel user) async {
    user.isBookmark = true;
    await databaseHelper.add(user);
    final currentState = state as UsersLoaded;
    final updatedUsers = List<UserModel>.from(currentState.users)..add(user);
    emit(currentState.copyWith(users: updatedUsers));
  }

  Future<void> removeBookmark(UserModel user) async {
    await databaseHelper.remove(user.id!);
    final currentState = state as UsersLoaded;
    final updatedUsers = List<UserModel>.from(currentState.users);
    updatedUsers.firstWhere((element) => element.id == user.id).isBookmark = false;
    userRepository.users.firstWhere((element) => element.id == user.id).isBookmark = false;
    emit(UsersInitial());
    emit(UsersLoaded(users: updatedUsers));
  }

  Future<List<UserModel>> updateBookmarkedInUsersListing(List<UserModel> users) async {
    List<UserModel> bookmarked = await databaseHelper.fetchBookmarkUsers();
    for (UserModel user in users) {
      bool isBookmarked = bookmarked.any((bookmark) => bookmark.id == user.id);
      user.isBookmark = isBookmarked;
    }

    return users;
  }

}
