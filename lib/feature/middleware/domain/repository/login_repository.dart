import 'package:dartz/dartz.dart';
import '/feature/middleware/domain/entity/login_entity.dart';

import '../../../../core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> post(LoginEntity entity);

  Future<Either<Failure, dynamic>> create(dynamic entity);
  Future<Either<Failure, List<dynamic>>> get();
  Future<Either<Failure, dynamic>> find(String username);
  Future<Either<Failure, dynamic>> delete(String username);
  Future<Either<Failure, dynamic>> update(LoginEntity entity);
}
