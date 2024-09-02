import 'package:dartz/dartz.dart';
import '/feature/warehouse/data/model/warehouse_model.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '../../domain/repository/warehouse_local_repository.dart';
import '../data_source/warehouse_local_data_source.dart';

import '../../../../../core/error/failure.dart';

class WarehouseLocalRepositoryImpl implements WarehouseLocalRepository {
  final WarehouseLocalDataSource remote;

  WarehouseLocalRepositoryImpl(this.remote);

  @override
  Future<List<WarehouseEntity>> get() async {
    try {
      return await remote.get();
    } on Failure catch (error) {
      return [];
    }
  }

  @override
  Future<WarehouseEntity> create(WarehouseEntity query) async {
    try {
      final WarehouseEntity reponse =
          await remote.create(Warehouse.mapFromEntity(query));
      return reponse;
    } on Failure catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(String query) async {
    try {
      await remote.delete(query);
      return 1;
    } on Failure catch (error) {
      rethrow;
    }
  }

  @override
  Future<WarehouseEntity?> findOne(String query) async {
    try {
      final whs = await remote.find(query);
      return whs;
    } on Failure catch (error) {
      return null;
    }
  }

  @override
  Future<WarehouseEntity> update(WarehouseEntity query) async {
    try {
      await remote.update(Warehouse.mapFromEntity(query));
      return query;
    } on Failure catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteAll() async {
    try {
      await remote.deleteAll();
      return 1;
    } on Failure catch (error) {
      rethrow;
    }
  }
}
