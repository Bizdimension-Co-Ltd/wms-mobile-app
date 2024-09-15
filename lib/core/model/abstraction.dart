import 'package:equatable/equatable.dart';

class ItemLineEntity extends Equatable {
  final String? itemCode;
  final String? itemName;
  final String? qty;
  final int? uomId;
  final String? uomCode;
  final List<ItemBinAllocation>? allocations;

  const ItemLineEntity({
    this.itemCode,
    this.itemName,
    this.qty,
    this.uomId,
    this.uomCode,
    this.allocations,
  });

  ItemLineEntity copyWith({
    List<ItemBinAllocation>? allocations,
  }) =>
      ItemLineEntity(
        itemCode: itemCode,
        itemName: itemName,
        qty: qty,
        uomId: uomId,
        allocations: allocations ?? this.allocations,
      );

  @override
  List<Object?> get props => [itemCode, itemName, uomId];
}

class ItemBinAllocation extends Equatable {
  final int? baseLineNo;
  final String? qty;
  final int? binId;
  final String? binCode;
  final String? batchOrSerialCode;
  final int? serialOrBatchLineNo;

  const ItemBinAllocation({
    this.baseLineNo,
    this.qty,
    this.serialOrBatchLineNo,
    this.binId,
    this.binCode,
    this.batchOrSerialCode,
  });

  ItemBinAllocation copyWith({
    String? batchOrSerialCode,
    String? qty,
    int? binId,
    String? binCode,
  }) =>
      ItemBinAllocation(
        baseLineNo: baseLineNo,
        qty: qty ?? this.qty,
        serialOrBatchLineNo: serialOrBatchLineNo,
        binId: binId ?? this.binId,
        binCode: binCode ?? this.binCode,
        batchOrSerialCode: batchOrSerialCode ?? this.batchOrSerialCode,
      );

  @override
  List<Object?> get props =>
      [baseLineNo, qty, serialOrBatchLineNo, batchOrSerialCode];
}
