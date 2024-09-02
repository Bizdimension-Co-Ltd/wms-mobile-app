import 'package:dartz/dartz.dart';
import '/feature/middleware/domain/repository/login_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetUserUseCase implements GetUseCase<List<dynamic>> {
  final LoginRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, List<dynamic>>> call() async {
    return await repository.get();
  }
}
