import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/bin_location/data/model/bin_model.dart';
import '../../domain/entity/bin_entity.dart';
import '../../domain/repository/bin_local_repository.dart';

import '../../../../../core/error/failure.dart';
import '../data_source/bin_local_data_source.dart';

class BinLocalRepositoryImpl implements BinLocalRepository {
  final BinLocalDataSource remote;

  BinLocalRepositoryImpl(this.remote);

  @override
  Future<List<BinEntity>> get() async {
    try {
      return remote.get();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BinEntity> create(BinEntity entity) async {
    try {
      return remote.create(BinModel.fromEntity(entity));
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int query) async {
    try {
      await remote.delete(query);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await remote.deleteAll();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BinEntity?> find(int query) async {
    try {
      return remote.find(query);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<BinEntity> update(BinEntity entity) {
    try {
      return remote.update(BinModel.fromEntity(entity));
    } catch (error) {
      rethrow;
    }
  }
}
