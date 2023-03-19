part of 'user_reputation_cubit.dart';

abstract class UserReputationState extends Equatable {

  const UserReputationState();

  @override
  List<Object> get props => [];
}

class UserReputationInitial extends UserReputationState {}

class UserReputationLoading extends UserReputationState {}

class UserReputationLoaded extends UserReputationState {
  final List<ReputationModel> reputation;

  const UserReputationLoaded({required this.reputation});

  UserReputationLoaded copyWith(List<ReputationModel> reputation) {
    return UserReputationLoaded(
        reputation: reputation
    );
  }

  @override
  List<Object> get props => [reputation];
}

class UserReputationError extends UserReputationState {
  final String errorMsg;
  const UserReputationError(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
