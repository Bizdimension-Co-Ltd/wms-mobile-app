import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../domain/repository/put_away_repository.dart';
import '../data_source/put_away_remote_data_source.dart';

class PutAwayRepositoryImpl implements PutAwayRepository {
  final PutAwayRemoteDataSource remote;

  PutAwayRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Map<String, dynamic>>> post(
      Map<String, dynamic> payload) async {
    try {
      final Map<String, dynamic> reponse = await remote.post(payload);
      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
