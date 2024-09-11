import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entity/find_picking_list_entity.dart';

abstract class PickListRepository {
  PickListRepository(Object object);

  Future<Either<Failure, PickListEntity>> post(PickListEntity entity);

  Future<Either<Failure, PickListEntity>> find(int pickNumber);
}
