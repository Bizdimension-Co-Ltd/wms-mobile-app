import 'package:wms_mobile/feature/bin_location/domain/entity/bin_entity.dart';
import 'package:wms_mobile/helper/helper.dart';

class BinModel extends BinEntity {
  final int id;
  final String code;
  final String warehouse;
  final String subLevel1;

  final int binId;
  final int? isDefault;
  final String? isSystemBin;
  final String? batchRestrictions;

  BinModel({
    required this.id,
    required this.code,
    required this.warehouse,
    required this.subLevel1,
    required this.binId,
    required this.isDefault,
    required this.isSystemBin,
    required this.batchRestrictions,
  }) : super(
          code: code,
          warehouse: warehouse,
          subLevel1: subLevel1,
          id: id,
          binId: binId,
          isDefault: isDefault,
          isSystemBin: isSystemBin,
          batchRestrictions: batchRestrictions,
        );

  factory BinModel.fromJson(Map<String, dynamic> json) => BinModel(
        id: json["AbsEntry"],
        code: json["BinCode"],
        warehouse: getDataFromDynamic(json["Warehouse"]),
        subLevel1: getDataFromDynamic(json["Sublevel1"]),
        binId: json["AbsEntry"] ?? -1,
        isDefault: 0,
        isSystemBin: getDataFromDynamic(json["IsSystemBin"]),
        batchRestrictions: getDataFromDynamic(json["BatchRestrictions"]),
      );

  factory BinModel.fromDatabase(Map<String, dynamic> json) => BinModel(
        id: json["id"],
        code: json["binCode"],
        warehouse: getDataFromDynamic(json["warehouseCode"]),
        subLevel1: getDataFromDynamic(json["sublevel1"]),
        binId: json["absEntry"] ?? -1,
        isDefault: 0,
        isSystemBin: getDataFromDynamic(json["isSystemBin"]),
        batchRestrictions: getDataFromDynamic(json["batchRestrictions"]),
      );

  factory BinModel.fromEntity(BinEntity entity) => BinModel(
        id: entity.binId,
        code: entity.code,
        warehouse: entity.warehouse ?? "",
        subLevel1: entity.subLevel1 ?? "",
        binId: entity.binId,
        isDefault: 0,
        isSystemBin: entity.isSystemBin,
        batchRestrictions: entity.batchRestrictions,
      );
}
