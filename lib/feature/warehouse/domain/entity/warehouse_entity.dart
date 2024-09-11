class WarehouseEntity {
  final String code;
  final String name;
  final String enableBinLocations;
  final String? defaultBin;
  final String inactive;
  final int? businessPlaceID;

  WarehouseEntity({
    required this.code,
    required this.name,
    required this.enableBinLocations,
    required this.defaultBin,
    required this.inactive,
    required this.businessPlaceID,
  });

  bool get isEnableBin => enableBinLocations == 'tYES';
  bool get isActive => inactive == 'tYES';
}
