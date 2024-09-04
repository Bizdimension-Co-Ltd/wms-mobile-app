import 'package:dartz/dartz.dart';
import 'package:wms_mobile/feature/item/domain/entity/item_entity.dart';

import '../../../../../core/error/failure.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> get(String query);
  Future<Either<Failure, ItemEntity>> find(String query);
}
