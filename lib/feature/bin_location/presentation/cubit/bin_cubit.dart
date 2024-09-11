import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/databases/database.dart';
import 'package:wms_mobile/feature/bin_location/data/model/bin_model.dart';
import 'package:wms_mobile/feature/bin_location/domain/usecase/bin_local_usecase.dart';

import '../../../../injector.dart';
import '../../domain/entity/bin_entity.dart';
import '../../domain/usecase/get_usecase.dart';

part 'bin_state.dart';

class BinCubit extends Cubit<BinState> {
  GetBinUseCase useCase;
  BinLocalUseCase databaseUseCase;

  BinCubit(this.useCase, this.databaseUseCase) : super(BinInitial());

  Future<List<BinEntity>> get(String query) async {
    emit(RequestingBin());

    final database = getIt<AppDatabase>();
    final bins = await database.getAll(database.binLocationTable, filters: [
      database.binLocationTable.warehouseCode.equals(query),
    ]);

    if (bins.isNotEmpty) {
      final data = bins.map((e) => BinModel.fromDatabase(e.toJson())).toList();
      emit(BinData(data));
      return data;
    }

    final response = await useCase.call(
        "?\$filter=Warehouse eq '$query'&\$select=AbsEntry,BinCode,Warehouse,Sublevel1,IsSystemBin,BatchRestrictions");
    return response.fold((error) {
      emit(BinError(error.message));
      print(error.message);
      return [];
    }, (success) async {
      emit(BinData(success));

      for (final bin in success) {
        await databaseUseCase.create(bin);
      }

      return success;
    });
  }

  Future<List<BinEntity>> next(String query) async {
    emit(RequestingPaginationBin());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(BinError(error.message));
      return [];
    }, (success) async {
      emit(BinData([]));
      return success;
    });
  }

  Future<void> set(List<BinEntity> data) async {
    emit(BinInitial());
    emit(BinData(data));
  }
}
