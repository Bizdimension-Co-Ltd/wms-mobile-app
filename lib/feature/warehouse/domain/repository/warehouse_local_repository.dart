import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entity/warehouse_entity.dart';

abstract class WarehouseLocalRepository {
  Future< List<WarehouseEntity>> get();
  Future<WarehouseEntity> create(WarehouseEntity query);
  Future<WarehouseEntity?> findOne(String query);
  Future<dynamic> update(WarehouseEntity query);
  Future<dynamic> delete(String query);
  Future<dynamic> deleteAll();
}
