class BinEntity {
  final int id;
  final int binId;
  final String code;
  final String? warehouse;
  final String? subLevel1;
  final int? isDefault;
  final String? isSystemBin;
  final String? batchRestrictions;

  BinEntity({
    required this.id,
    required this.code,
    required this.warehouse,
    required this.subLevel1,
    required this.binId,
    this.isDefault,
    this.isSystemBin,
    this.batchRestrictions,
  });
}

class BinItemEntity {
  final String? itemCode;
  final String? itemName;
  final String? whsCode;
  final double? onHandQty;
  final String? binCode;
  final int? binId;
  final String? isSerial;
  final String? isBatch;
  final dynamic baseUnit;
  final String? invntryUom;
  final int? id;

  BinItemEntity({
    this.itemCode,
    this.itemName,
    this.whsCode,
    this.onHandQty,
    this.binCode,
    this.binId,
    this.isSerial,
    this.isBatch,
    this.baseUnit,
    this.invntryUom,
    this.id,
  });
}
