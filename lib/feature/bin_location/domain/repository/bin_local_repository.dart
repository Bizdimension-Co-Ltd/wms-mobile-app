import '/feature/bin_location/domain/entity/bin_entity.dart';

abstract class BinLocalRepository {
  Future<List<BinEntity>> get();
  Future<BinEntity> create(BinEntity entity);
  Future<BinEntity?> find(int query);
  Future<BinEntity> update(BinEntity entity);
  Future<void> delete(int query);
  Future<void> deleteAll();
}
