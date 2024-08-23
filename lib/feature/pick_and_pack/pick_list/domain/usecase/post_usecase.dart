import 'package:dartz/dartz.dart';
import '/feature/pick_and_pack/pick_list/domain/repository/pick_list_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class PostPickListUseCase
    implements UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final PickListRepository repository;

  PostPickListUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      Map<String, dynamic> query) async {
    return await repository.post(query);
  }
}
