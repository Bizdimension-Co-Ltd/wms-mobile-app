import '../repository/bin_local_repository.dart';
import '../entity/bin_entity.dart';
import '../../../../../core/usecase/usecase.dart';

class BinLocalUseCase implements DatabseUseCase<BinEntity, int> {
  final BinLocalRepository repository;

  BinLocalUseCase(this.repository);

  @override
  Future<BinEntity> create(BinEntity entity) async {
    return await repository.create(entity);
  }

  @override
  Future<void> delete(int params) async {
    await repository.delete(params);
  }

  @override
  Future<void> deleteAll() async {
    await repository.deleteAll();
  }

  @override
  Future<BinEntity?> find(params) async {
    return await repository.find(params);
  }

  @override
  Future<List<BinEntity>> get() async {
    return await repository.get();
  }

  @override
  Future<BinEntity> update(params) async {
    return await repository.update(params);
  }
}
