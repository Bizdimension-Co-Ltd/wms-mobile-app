import 'package:wms_mobile/helper/helper.dart';

import '/feature/warehouse/domain/entity/warehouse_entity.dart';

class Warehouse extends WarehouseEntity {
  final String code;
  final String name;
  final String enableBinLocations;
  final String? defaultBin;
  final String inactive;
  final int? businessPlaceID;

  Warehouse({
    required this.code,
    required this.name,
    required this.enableBinLocations,
    required this.defaultBin,
    required this.inactive,
    required this.businessPlaceID,
  }) : super(
          code: code,
          name: name,
          enableBinLocations: enableBinLocations,
          inactive: inactive,
          businessPlaceID: businessPlaceID,
          defaultBin: defaultBin,
        );

  Warehouse copyWith({
    String? code,
    String? name,
    String? enableBinLocations,
    String? defaultBin,
    String? inactive,
    int? businessPlaceID,
  }) =>
      Warehouse(
        name: name ?? this.name,
        code: code ?? this.code,
        enableBinLocations: enableBinLocations ?? this.enableBinLocations,
        inactive: inactive ?? this.inactive,
        businessPlaceID: businessPlaceID ?? this.businessPlaceID,
        defaultBin: defaultBin ?? this.defaultBin,
      );

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        code: json["WarehouseCode"],
        name: getDataFromDynamic(json["WarehouseName"]),
        enableBinLocations: getDataFromDynamic(json["EnableBinLocations"]),
        inactive: getDataFromDynamic(json["Inactive"]),
        businessPlaceID: json["BusinessPlaceID"] ?? 0,
        defaultBin: getDataFromDynamic(json["DefaultBin"]),
      );

  factory Warehouse.fromDatabase(Map<String, dynamic> json) => Warehouse(
        code: json["code"],
        name: getDataFromDynamic(json["name"]),
        enableBinLocations: getDataFromDynamic(json["enableBinLocation"]),
        inactive: getDataFromDynamic(json["inactive"]),
        businessPlaceID: json["businessPlaceID"],
        defaultBin: getDataFromDynamic(json["defaultBin"]),
      );

  factory Warehouse.mapFromEntity(WarehouseEntity entity) => Warehouse(
        code: entity.code,
        name: entity.name,
        enableBinLocations: entity.enableBinLocations,
        inactive: entity.inactive,
        businessPlaceID: entity.businessPlaceID,
        defaultBin: entity.defaultBin,
      );
}
