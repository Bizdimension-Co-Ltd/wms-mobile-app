import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/middleware/data/model/login_model.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
import 'package:wms_mobile/feature/middleware/domain/repository/login_repository.dart';

import '../../../../core/error/failure.dart';
import '../data_source/login_local_data_souce.dart';
import '../data_source/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;
  final LoginLocalDataSource locale;

  LoginRepositoryImpl(this.remote, this.locale);

  @override
  Future<Either<Failure, String>> post(LoginEntity entity) async {
    try {
      final String reponse = await remote.sign(
        LoginModel.mapFromEntity(entity),
      );

      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, dynamic>> create(entity) async {
    try {
      final dynamic reponse =
          await locale.create(LoginModel.mapFromEntity(entity));

      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, dynamic>> delete(entity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> find(entity) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<dynamic>>> get() async {
    try {
      final reponse = await locale.gets();
      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, dynamic>> update(entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
