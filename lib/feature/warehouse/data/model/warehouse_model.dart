import 'package:wms_mobile/helper/helper.dart';

import '/feature/warehouse/domain/entity/warehouse_entity.dart';

class Warehouse extends WarehouseEntity {
  @override
  final String code;
  @override
  final String name;

  Warehouse({required this.code, required this.name})
      : super(code: code, name: name);

  Warehouse copyWith({
    String? code,
    String? name,
  }) =>
      Warehouse(
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        code: json["WarehouseCode"],
        name: getDataFromDynamic(json["WarehouseName"]),
      );
}
