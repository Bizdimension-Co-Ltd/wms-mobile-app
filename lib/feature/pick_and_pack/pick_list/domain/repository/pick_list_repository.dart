import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entity/find_picking_list_entity.dart';

abstract class PickListRepository {
  PickListRepository(Object object);

  Future<Either<Failure, Map<String, dynamic>>> post(
      Map<String, dynamic> entity);

  Future<Either<Failure, PickListEntity>> find(int pickNumber);
}
