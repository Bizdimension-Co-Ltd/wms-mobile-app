import '../../../../helper/helper.dart';
import '/feature/item/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  final String code;
  final String name;
  final int uoMGroupEntry;
  final String inventoryUOM;
  final int inventoryUoMEntry;
  final String inventoryItem;
  final String purchaseItem;
  final String saleItem;
  final String isManageBatch;
  final String isManageSerial;

  ItemModel(
      {required this.code,
      required this.name,
      required this.uoMGroupEntry,
      required this.inventoryUOM,
      required this.inventoryUoMEntry,
      required this.inventoryItem,
      required this.purchaseItem,
      required this.saleItem,
      required this.isManageBatch,
      required this.isManageSerial})
      : super(
          code: code,
          name: name,
          uoMGroupEntry: uoMGroupEntry,
          inventoryUOM: inventoryUOM,
          inventoryUoMEntry: inventoryUoMEntry,
          inventoryItem: inventoryItem,
          purchaseItem: purchaseItem,
          saleItem: saleItem,
          isManageBatch: isManageBatch,
          isManageSerial: isManageSerial,
        );

  ItemModel copyWith(
          {String? code,
          String? name,
          int? uoMGroupEntry,
          String? inventoryUOM,
          int? inventoryUoMEntry,
          String? inventoryItem,
          String? purchaseItem,
          String? saleItem,
          String? isManageBatch,
          String? isManageSerial}) =>
      ItemModel(
        code: code ?? this.code,
        name: name ?? this.name,
        uoMGroupEntry: uoMGroupEntry ?? this.uoMGroupEntry,
        inventoryUOM: inventoryUOM ?? this.inventoryUOM,
        inventoryUoMEntry: inventoryUoMEntry ?? this.inventoryUoMEntry,
        inventoryItem: inventoryItem ?? this.inventoryItem,
        purchaseItem: purchaseItem ?? this.purchaseItem,
        saleItem: saleItem ?? this.saleItem,
        isManageBatch: isManageBatch ?? this.isManageBatch,
        isManageSerial: isManageSerial ?? this.isManageSerial,
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        code: json["ItemCode"],
        name: getDataFromDynamic(json["ItemName"]),
        uoMGroupEntry: json["UoMGroupEntry"] ?? -1,
        inventoryUOM: getDataFromDynamic(json["InventoryUOM"]),
        inventoryUoMEntry: json["InventoryUoMEntry"] ?? -1,
        inventoryItem: getDataFromDynamic(json["InventoryItem"]),
        purchaseItem: getDataFromDynamic(json["PurchaseItem"]),
        saleItem: getDataFromDynamic(json["SalesItem"]),
        isManageBatch: getDataFromDynamic(json["ManageBatchNumbers"]),
        isManageSerial: getDataFromDynamic(json["ManageSerialNumbers"]),
      );

  factory ItemModel.fromDatabase(Map<String, dynamic> json) => ItemModel(
        code: json["code"],
        name: getDataFromDynamic(json["name"]),
        uoMGroupEntry: json["uoMGroupEntry"] ?? -1,
        inventoryUOM: getDataFromDynamic(json["inventoryUOM"]),
        inventoryUoMEntry: json["iunventoryUoMEntry"] ?? -1,
        inventoryItem: getDataFromDynamic(json["inventoryItem"]),
        purchaseItem: getDataFromDynamic(json["purchaseItem"]),
        saleItem: getDataFromDynamic(json["saleItem"]),
        isManageBatch: getDataFromDynamic(json["isManageBatch"]),
        isManageSerial: getDataFromDynamic(json["isManageSerial"]),
      );

  factory ItemModel.mapFromEntity(ItemEntity entity) => ItemModel(
        code: entity.code,
        name: entity.name,
        uoMGroupEntry: entity.uoMGroupEntry,
        inventoryUOM: entity.inventoryUOM,
        inventoryUoMEntry: entity.inventoryUoMEntry,
        inventoryItem: entity.inventoryItem,
        purchaseItem: entity.purchaseItem,
        saleItem: entity.saleItem,
        isManageBatch: entity.isManageBatch,
        isManageSerial: entity.isManageSerial,
      );
}
