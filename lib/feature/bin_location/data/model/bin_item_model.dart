import 'package:wms_mobile/feature/bin_location/domain/entity/bin_entity.dart';

class BinItemModel extends BinItemEntity {
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

  BinItemModel({
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
  }) : super(
          itemCode: itemCode,
          itemName: itemName,
          whsCode: whsCode,
          binCode: binCode,
          onHandQty: onHandQty,
          binId: binId,
          isSerial: isSerial,
          isBatch: isBatch,
          invntryUom: invntryUom,
          baseUnit: baseUnit,
          id: id,
        );

  factory BinItemModel.fromJson(Map<String, dynamic> json) => BinItemModel(
        itemCode: json["ItemCode"],
        itemName: json["ItemName"],
        whsCode: json["WhsCode"],
        onHandQty: json["OnHandQty"],
        binCode: json["BinCode"],
        binId: json["BinID"],
        isSerial: json["IsSerial"],
        isBatch: json["IsBatch"],
        baseUnit: json["BaseUnit"],
        invntryUom: json["InvntryUom"],
        id: json["id__"],
      );
}
