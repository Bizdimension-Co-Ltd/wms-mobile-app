import 'package:dartz/dartz.dart';
import '../entity/find_picking_list_entity.dart';
import '/feature/pick_and_pack/pick_list/domain/repository/pick_list_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class PostPickListUseCase implements UseCase<PickListEntity, PickListEntity> {
  final PickListRepository repository;

  PostPickListUseCase(this.repository);

  @override
  Future<Either<Failure, PickListEntity>> call(PickListEntity query) async {
    return await repository.post(query);
  }
}
