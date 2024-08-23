part of 'pick_list_cubit.dart';

class PickListState extends Equatable {
  const PickListState();

  @override
  List<Object> get props => [];
}

class PickListInitial extends PickListState {}

class RequestingPickList extends PickListState {}

class RequestingPaginationPickList extends PickListState {}

class FindPickingList extends PickListState {}

class PickListData extends PickListState {
  final PickListEntity entities;

  const PickListData(this.entities);
}

class PostPickListData extends PickListState {
  final PickListModel entities;

  const PostPickListData(this.entities);
}

class PickListError extends PickListState {
  final String message;

  const PickListError(this.message);
}
