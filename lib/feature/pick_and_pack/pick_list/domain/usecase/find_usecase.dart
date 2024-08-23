import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';
import '/feature/pick_and_pack/pick_list/domain/repository/pick_list_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class FindPickListUseCase implements UseCase<PickListEntity, int> {
  final PickListRepository repository;

  FindPickListUseCase(this.repository);

  @override
  Future<Either<Failure, PickListEntity>> call(int pickNumber) async {
    return await repository.find(pickNumber);
  }
}
