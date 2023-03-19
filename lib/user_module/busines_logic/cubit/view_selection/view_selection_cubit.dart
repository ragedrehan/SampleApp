import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_selection_state.dart';

class ViewSelectionCubit extends Cubit<ViewSelectionState> {
  ViewSelectionCubit() : super(Users());

  void viewSelection(bool showBookmarked) {
    showBookmarked ? emit(BookmarkedUsers()) : emit(Users());
  }
}
