import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecase/create_local_usecase.dart';
import '../../domain/usecase/delete_all_local_usecase.dart';
import '../../domain/usecase/delete_local_usecase.dart';
import '../../domain/usecase/find_local_usecase.dart';
import '../../domain/usecase/get_local_usecase.dart';
import '../../domain/usecase/update_local_usecase.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/domain/usecase/get_usecase.dart';

part 'warehouse_state.dart';

class WarehouseCubit extends Cubit<WarehouseState> {
  GetWarehouseUseCase useCase;

  GetWarehouseLocalUseCase getLocalUseCase;
  FindWarehouseLocalUseCase findLocalUseCase;
  CreateWarehouseLocalUseCase createLocalUseCase;
  UpdateWarehouseLocalUseCase updateLocalUseCase;
  DeleteWarehouseLocalUseCase deleteLocalUseCase;
  DeleteAllWarehouseLocalUseCase deleteAllLocalUseCase;

  WarehouseCubit(
    this.useCase,
    this.getLocalUseCase,
    this.findLocalUseCase,
    this.createLocalUseCase,
    this.updateLocalUseCase,
    this.deleteLocalUseCase,
    this.deleteAllLocalUseCase,
  ) : super(WarehouseInitial());

  Future<List<WarehouseEntity>> get(String query) async {
    emit(RequestingWarehouse());
    // (await deleteAllLocalUseCase.call());
    final data = (await getLocalUseCase.call());
    if (data.isNotEmpty) {
      emit(WarehouseData(data));
      return data;
    }

    final response = await useCase.call(query);
    return response.fold((error) {
      emit(WarehouseError(error.message));
      return [];
    }, (success) async {
      for (final whs in success) {
        final exist = (await findLocalUseCase.call(whs.code));
        if (exist == null) {
          await createLocalUseCase.call(whs);
        }
      }
      emit(WarehouseData(success));
      return success;
    });
  }

  Future<List<WarehouseEntity>> next(String query) async {
    emit(RequestingPaginationWarehouse());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(WarehouseError(error.message));
      return [];
    }, (success) async {
      emit(WarehouseData([]));
      return success;
    });
  }

  Future<void> set(List<WarehouseEntity> data) async {
    emit(WarehouseInitial());
    emit(WarehouseData(data));
  }

  Future<void> deleteAll() async {}

  Future<WarehouseEntity?> find(String code) async {
    return findLocalUseCase.call(code);
  }
}
