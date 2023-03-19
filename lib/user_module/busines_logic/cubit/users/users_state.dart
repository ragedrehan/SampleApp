part of 'users_cubit.dart';

abstract class UsersState extends Equatable {

  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserModel> users;
  final bool isFetchingMore;

  const UsersLoaded({required this.users,this.isFetchingMore=false});

  UsersLoaded copyWith({List<UserModel>? users, bool isFetchingMore =false}) {
    return UsersLoaded(
      users: users ?? this.users,
      isFetchingMore: this.isFetchingMore,
    );
  }

  @override
  List<Object> get props => [users, isFetchingMore];
}

class UsersError extends UsersState {
  final String errorMsg;
  const UsersError(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
