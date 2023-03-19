part of 'view_selection_cubit.dart';

abstract class ViewSelectionState extends Equatable {
  const ViewSelectionState();

  @override
  List<Object> get props => [];
}

class BookmarkedUsers extends ViewSelectionState {}

class Users extends ViewSelectionState {}
