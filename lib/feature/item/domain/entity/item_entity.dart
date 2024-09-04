class ItemEntity {
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

  ItemEntity({
    required this.code,
    required this.name,
    required this.uoMGroupEntry,
    required this.inventoryUOM,
    required this.inventoryUoMEntry,
    required this.inventoryItem,
    required this.purchaseItem,
    required this.saleItem,
    required this.isManageBatch,
    required this.isManageSerial,
  });

  bool get isSerial => isManageSerial == 'tYES';
  bool get isBatch => isManageBatch == 'tYES';
  bool get isInventoryItem => inventoryItem == 'tYES';
  bool get isSaleItem => saleItem == 'tYES';
  bool get isPurchaseItem => purchaseItem == 'tYES';
}
