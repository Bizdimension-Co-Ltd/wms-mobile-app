import 'package:drift/drift.dart';
import 'package:wms_mobile/databases/database.dart';

import '../model/bin_model.dart';
import '../../../../../core/error/failure.dart';

abstract class BinLocalDataSource {
  Future<List<BinModel>> get();
  Future<BinModel> create(BinModel entity);
  Future<BinModel?> find(int id);
  Future<BinModel> update(BinModel entity);
  Future<void> delete(int id);
  Future<void> deleteAll();
}

class BinLocalDataSourceImpl implements BinLocalDataSource {
  final AppDatabase database;

  BinLocalDataSourceImpl(this.database);

  @override
  Future<List<BinModel>> get() async {
    try {
      final response = await database.getAll(database.binLocationTable);

      return List.from(response)
          .map((e) => BinModel.fromJson(e?.toJson()))
          .toList();
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<BinModel> create(BinModel entity) async {
    try {
      await database.into(database.binLocationTable).insert(
            BinLocationTableCompanion(
              absEntry: Value(entity.binId),
              binCode: Value(entity.code),
              warehouseCode: Value(entity.warehouse),
              batchRestrictions: Value(entity.batchRestrictions),
              isSystemBin: Value(entity.isSystemBin),
              isDefault: Value(0),
            ),
          );
      return entity;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await database.deleteWhere(
          database.binLocationTable, (e) => e.absEntry.equals(id));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await database.deleteAll(database.binLocationTable);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BinModel?> find(int id) async {
    try {
      final data = await database.findOne(
          database.binLocationTable, (e) => e.absEntry.equals(id));

      if (data == null) return null;

      return BinModel.fromDatabase(data.toJson());
    } catch (e) { 
      rethrow;
    }
  }

  @override
  Future<BinModel> update(BinModel entity) async {
    try {
      await database.updateWhere(
        database.binLocationTable,
        where: (e) => e.absEntry.equals(entity.id),
        entity: BinLocationTableCompanion(
          absEntry: Value(entity.binId),
          binCode: Value(entity.code),
          warehouseCode: Value(entity.warehouse),
          batchRestrictions: Value(entity.batchRestrictions),
          isSystemBin: Value(entity.isSystemBin),
          isDefault: Value(0),
        ),
      );

      return entity;
    } catch (e) {
      rethrow;
    }
  }
}
