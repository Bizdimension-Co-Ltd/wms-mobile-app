import '../repository/warehouse_local_repository.dart';

class DeleteWarehouseLocalUseCase {
  final WarehouseLocalRepository repository;

  DeleteWarehouseLocalUseCase(this.repository);

  Future<dynamic> call(String query) async {
    return await repository.delete(query);
  }
}
