class Warehouse {
  String? warehouseCode;
  String? warehouseName;

  Warehouse({this.warehouseCode, this.warehouseName});

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      warehouseCode: json['WarehouseCode'] ?? '',
      warehouseName: json['WarehouseName'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'WarehouseCode': warehouseCode,
      'WarehouseName': warehouseName,
    };
  }

  // Additional methods for creating and updating data if needed
}
