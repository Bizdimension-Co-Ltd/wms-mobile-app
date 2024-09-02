import 'package:drift/drift.dart';
import 'package:wms_mobile/databases/database.dart';
import '/feature/warehouse/data/model/warehouse_model.dart';

abstract class WarehouseLocalDataSource {
  Future<List<Warehouse>> get();
  Future<Warehouse?> find(String code);
  Future<Warehouse> create(Warehouse entity);
  Future<void> update(Warehouse entity);
  Future<void> delete(String code);
  Future<void> deleteAll();
}

class WarehouseLocalDataSourceImpl implements WarehouseLocalDataSource {
  final AppDatabase database;

  WarehouseLocalDataSourceImpl(this.database);

  @override
  Future<List<Warehouse>> get() async {
    final data = await database.getAll(database.warehouseTable);
    return data.map((ele) => Warehouse.fromDatabase(ele.toJson())).toList();
  }

  @override
  Future<Warehouse> create(Warehouse entity) async {
    await database.into(database.warehouseTable).insert(WarehouseTableCompanion(
        branch: Value(0), code: Value(entity.code), name: Value(entity.name)));

    return entity;
  }

  @override
  Future<void> delete(String code) async {
    await database.deleteWhere(
        database.warehouseTable, (whs) => whs.code.equals(code));
  }

  @override
  Future<Warehouse?> find(String code) async {
    try {
      final json = await database.findOne(
          database.warehouseTable, (whs) => whs.code.equals(code));

      if (json == null) return null;

      return Warehouse.fromDatabase(json.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Warehouse entity) async {
    await database.updateWhere(database.warehouseTable,
        where: (whs) => whs.code.equals(entity.code),
        entity: WarehouseTableCompanion(
          branch: Value(0),
          code: Value(entity.code),
          name: Value(entity.name),
        ));
  }

  @override
  Future<void> deleteAll() async {
    await database.deleteAll(database.warehouseTable);
  }
}
