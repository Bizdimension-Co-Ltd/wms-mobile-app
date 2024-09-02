import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/warehouse_entity.dart';
import '../repository/warehouse_local_repository.dart';

class GetWarehouseLocalUseCase  {
  final WarehouseLocalRepository repository;

  GetWarehouseLocalUseCase(this.repository);

  Future<List<WarehouseEntity>> call() async {
    return await repository.get();
  }
}
