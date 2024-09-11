import '../repository/warehouse_local_repository.dart';

class DeleteAllWarehouseLocalUseCase {
  final WarehouseLocalRepository repository;

  DeleteAllWarehouseLocalUseCase(this.repository);

  Future<dynamic> call() async {
    return await repository.deleteAll();
  }
}
