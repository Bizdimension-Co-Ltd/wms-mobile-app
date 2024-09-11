import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/data/model/pick_list_model.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../domain/repository/pick_list_repository.dart';
import '../data_source/pick_list_remote_data_source.dart';

class PickListRepositoryImpl implements PickListRepository {
  final PickListRemoteDataSource remote;

  PickListRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, PickListEntity>> post(PickListEntity payload) async {
    try {
      final response = await remote.post(PickListModel.fromEntity(payload));
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, PickListEntity>> find(int pickNumber) async {
    try {
      final PickListModel reponse = await remote.find(pickNumber);
      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
