import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/warehouse/domain/entity/warehouse_entity.dart';
import '../repository/warehouse_local_repository.dart';
import '../../../../../core/error/failure.dart';

class UpdateWarehouseLocalUseCase  {
  final WarehouseLocalRepository repository;

  UpdateWarehouseLocalUseCase(this.repository);

  Future<Either<Failure, void>> call(WarehouseEntity query) async {
    return await repository.update(query);
  }
}
