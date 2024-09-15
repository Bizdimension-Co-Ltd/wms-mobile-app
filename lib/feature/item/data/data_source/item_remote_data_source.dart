import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wms_mobile/databases/database.dart';
import 'package:wms_mobile/feature/item/data/model/item_model.dart';
import 'package:wms_mobile/feature/item/domain/entity/item_entity.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class ItemRemoteDataSource {
  Future<List<ItemEntity>> get(String query);
  Future<ItemModel> find(String query);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final DioClient dio;
  final AppDatabase db;

  ItemRemoteDataSourceImpl(this.dio, this.db);

  @override
  Future<List<ItemEntity>> get(String query) async {
    try {
      final response = await dio.get('/Items$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      final items = List.from(response.data['value'])
          .map((e) => ItemModel.fromJson(e))
          .toList();

      return items;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<ItemModel> find(String query) async {
    try {
      // final item = await db.findOne(db.itemTable, (i) => i.code.equals(query));
      // if (item != null) {
      //   return ItemModel.fromDatabase(item.toJson());
      // }

      final response = await dio.get(
          "/Items('$query')?\$select=ItemCode,ItemName,PurchaseItem,InventoryItem,SalesItem,InventoryUOM,UoMGroupEntry,InventoryUoMEntry,DefaultPurchasingUoMEntry,DefaultSalesUoMEntry,ManageSerialNumbers,ManageBatchNumbers");
      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      final uomGroup = await dio.get(
        '/UnitOfMeasurementGroups(${response.data['UoMGroupEntry']})',
      );

      final itemModel = ItemModel.fromJson(
          {...response.data, "uoMGroupDefinitionCollection": uomGroup.data});
      // await db.into(db.itemTable).insert(
      //       ItemTableCompanion(
      //         code: Value(itemModel.code),
      //         name: Value(itemModel.name),
      //         uoMGroupEntry: Value(itemModel.uoMGroupEntry),
      //         inventoryUOM: Value(itemModel.inventoryUOM),
      //         iunventoryUoMEntry: Value(itemModel.inventoryUoMEntry),
      //         isManageBatch: Value(itemModel.isManageBatch),
      //         isManageSerial: Value(itemModel.isManageSerial),
      //         inventoryItem: Value(itemModel.inventoryItem),
      //         purchaseItem: Value(itemModel.purchaseItem),
      //         saleItem: Value(itemModel.saleItem),
      //         uoMGroupDefinitionCollection: Value(jsonEncode(uomGroup.data)),
      //       ),
      //     );

      return itemModel;
    } on Failure {
      rethrow;
    }
  }
}
