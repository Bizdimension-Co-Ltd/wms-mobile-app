import '../repository/warehouse_local_repository.dart';
import '../entity/warehouse_entity.dart';

class FindWarehouseLocalUseCase  {
  final WarehouseLocalRepository repository;

  FindWarehouseLocalUseCase(this.repository);

  Future<WarehouseEntity?> call(String query) async {
    return await repository.findOne(query);
  }
}
