import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/data/model/pick_list_model.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/usecase/find_usecase.dart';
import '../../domain/usecase/post_usecase.dart';

part 'pick_list_state.dart';

class PickListCubit extends Cubit<PickListState> {
  PostPickListUseCase postUseCase;
  FindPickListUseCase findUseCase;

  PickListCubit(this.findUseCase, this.postUseCase) : super(PickListInitial());

  Future<PickListEntity> update(PickListEntity query) async {
    emit(RequestingPickList());
    final response = await postUseCase.call(query);
    return response.fold((error) {
      throw Exception(error.message);
    }, (success) async {
      return success;
    });
  }

  Future<PickListEntity> find(int pickNumber) async {
    emit(RequestingPickList());
    final response = await findUseCase.call(pickNumber);
    return response.fold((error) {
      throw Exception(error.message);
    }, (success) async {
      return success;
    });
  }
}
