import 'package:dartz/dartz.dart';
import '../../domain/entity/bin_entity.dart';
import '../../domain/repository/bin_repository.dart';

import '../../../../../core/error/failure.dart';
import '../data_source/bin_remote_data_source.dart';

class BinRepositoryImpl implements BinRepository {
  final BinRemoteDataSource remote;

  BinRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<BinEntity>>> get(String query) async {
    try {
      final List<BinEntity> reponse = await remote.get(query);
      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
