import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/warehouse_entity.dart';
import '../repository/warehouse_local_repository.dart';

class CreateWarehouseLocalUseCase {
  final WarehouseLocalRepository repository;

  CreateWarehouseLocalUseCase(this.repository);

  Future<WarehouseEntity> call(WarehouseEntity entity) async {
    return await repository.create(entity);
  }
}
