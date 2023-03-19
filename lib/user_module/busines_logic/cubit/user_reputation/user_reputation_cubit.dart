import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/user_module/model/repuation_model.dart';
import 'package:sample/user_module/repository/user_repository.dart';
part 'user_reputation_state.dart';

class UserReputationCubit extends Cubit<UserReputationState> {
  UserRepository userRepository;
  UserReputationCubit(this.userRepository) : super(UserReputationInitial());

  Future<void> fetchUserReputation(Map<String, dynamic> params) async {
    try {
      emit(UserReputationLoading());
      List<ReputationModel> reputation = await userRepository.fetchUserReputation(params);
      emit(UserReputationLoaded(reputation: reputation));
    } on Exception catch (e) {
      emit(UserReputationError(e.toString()));
    }
  }
}
