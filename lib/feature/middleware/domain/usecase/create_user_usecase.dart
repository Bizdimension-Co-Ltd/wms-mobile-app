import 'package:dartz/dartz.dart';
import '/feature/middleware/domain/entity/login_entity.dart';
import '/feature/middleware/domain/repository/login_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class CreateUserUseCase implements UseCase<dynamic, LoginEntity> {
  final LoginRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(LoginEntity entity) async {
    return await repository.create(entity);
  }
}
