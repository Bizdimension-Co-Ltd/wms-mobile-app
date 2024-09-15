import 'package:equatable/equatable.dart';
import 'package:wms_mobile/feature/item/data/model/item_model.dart';

class ItemEntity extends Equatable {
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
  final UoMGroupDefinitionCollection? uoMGroupDefinitionCollection;

  const ItemEntity(
      {required this.code,
      required this.name,
      required this.uoMGroupEntry,
      required this.inventoryUOM,
      required this.inventoryUoMEntry,
      required this.inventoryItem,
      required this.purchaseItem,
      required this.saleItem,
      required this.isManageBatch,
      required this.isManageSerial,
      this.uoMGroupDefinitionCollection});

  bool get isSerial => isManageSerial == 'tYES';
  bool get isBatch => isManageBatch == 'tYES';
  bool get isInventoryItem => inventoryItem == 'tYES';
  bool get isSaleItem => saleItem == 'tYES';
  bool get isPurchaseItem => purchaseItem == 'tYES';

  bool get isManageBatchOrSerial =>
      isManageSerial == 'tYES' || isManageBatch == 'tYES';

  factory ItemEntity.mapFromEntity(ItemModel model) => ItemEntity(
        code: model.code,
        name: model.name,
        uoMGroupEntry: model.uoMGroupEntry,
        inventoryUOM: model.inventoryUOM,
        inventoryUoMEntry: model.inventoryUoMEntry,
        inventoryItem: model.inventoryItem,
        purchaseItem: model.purchaseItem,
        saleItem: model.saleItem,
        isManageBatch: model.isManageBatch,
        isManageSerial: model.isManageSerial,
        uoMGroupDefinitionCollection: model.uoMGroupDefinitionCollection,
      );

  @override
  List<Object?> get props => [code, name];
}

class UoMGroupDefinitionCollection {
  final int? absEntry;
  final String? code;
  final String? name;
  final int? baseUoM;
  final List<UoMGroupDefinitionCollectionList>? uoMGroupDefinitionCollection;

  UoMGroupDefinitionCollection({
    this.absEntry,
    this.code,
    this.name,
    this.baseUoM,
    this.uoMGroupDefinitionCollection,
  });
}

class UoMGroupDefinitionCollectionList {
  final String? alternateUoM;
  final String? alternateQuantity;
  final String? baseQuantity;
  final String? weightFactor;
  final String? udfFactor;
  final String? active;

  UoMGroupDefinitionCollectionList({
    this.alternateUoM,
    this.alternateQuantity,
    this.baseQuantity,
    this.weightFactor,
    this.udfFactor,
    this.active,
  });
}
