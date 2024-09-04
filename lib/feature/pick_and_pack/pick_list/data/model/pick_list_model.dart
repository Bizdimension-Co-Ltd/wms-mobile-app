import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';
import 'package:wms_mobile/helper/helper.dart';

class PickListModel extends PickListEntity {
  @override
  final int? absoluteentry;
  @override
  final String? name;
  @override
  final int? ownerCode;
  @override
  final dynamic ownerName;
  @override
  final DateTime? pickDate;
  @override
  final dynamic remarks;
  @override
  final String? status;
  @override
  final String? objectType;
  @override
  final String? useBaseUnits;
  @override
  final List<PickListsLineModel>? pickListsLines;

  PickListModel({
    this.absoluteentry,
    this.name,
    this.ownerCode,
    this.ownerName,
    this.pickDate,
    this.remarks,
    this.status,
    this.objectType,
    this.useBaseUnits,
    this.pickListsLines,
  });

  PickListModel copyWith({
    int? absoluteentry,
    String? name,
    int? ownerCode,
    dynamic ownerName,
    DateTime? pickDate,
    dynamic remarks,
    String? status,
    String? objectType,
    String? useBaseUnits,
    List<PickListsLineModel>? pickListsLines,
  }) =>
      PickListModel(
        absoluteentry: absoluteentry ?? this.absoluteentry,
        name: name ?? this.name,
        ownerCode: ownerCode ?? this.ownerCode,
        ownerName: ownerName ?? this.ownerName,
        pickDate: pickDate ?? this.pickDate,
        remarks: remarks ?? this.remarks,
        status: status ?? this.status,
        objectType: objectType ?? this.objectType,
        useBaseUnits: useBaseUnits ?? this.useBaseUnits,
        pickListsLines: pickListsLines ?? this.pickListsLines,
      );

  factory PickListModel.fromJson(Map<String, dynamic> json) => PickListModel(
        absoluteentry: json["Absoluteentry"],
        name: json["Name"],
        ownerCode: json["OwnerCode"],
        ownerName: json["OwnerName"],
        pickDate:
            json["PickDate"] == null ? null : DateTime.parse(json["PickDate"]),
        remarks: json["Remarks"],
        status: json["Status"],
        objectType: json["ObjectType"],
        useBaseUnits: json["UseBaseUnits"],
        pickListsLines: json["PickListsLines"] == null
            ? []
            : List<PickListsLineModel>.from(json["PickListsLines"]!
                .map((x) => PickListsLineModel.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "Absoluteentry": absoluteentry,
        "Name": name,
        "OwnerCode": ownerCode,
        "OwnerName": ownerName,
        "PickDate": pickDate?.toIso8601String(),
        "Remarks": remarks,
        "Status": status,
        "ObjectType": objectType,
        "UseBaseUnits": useBaseUnits,
        "PickListsLines": pickListsLines == null
            ? []
            : List<dynamic>.from(pickListsLines!.map((x) => x.toJson())),
      };
}

class PickListsLineModel extends PickListsLineEntity {
  final int? absoluteEntry;
  final int? lineNumber;
  final int? orderEntry;
  final int? orderRowId;
  final double? pickedQuantity;
  final String? pickStatus;
  final double? releasedQuantity;
  final double? previouslyReleasedQuantity;
  final dynamic baseObjectType;
  final List<SerialNumberModel>? serialNumbers;
  final List<BatchNumberModel>? batchNumbers;
  final List<DocumentLinesBinAllocationModel>? documentLinesBinAllocations;
  final String? itemCode;
  final String? itemDescription;
  final String? warehouseCode;
  final String? uomCode;
  final String? manageSerialNumber;
  final String? manageBatchNumber;

  PickListsLineModel({
    this.absoluteEntry,
    this.lineNumber,
    this.orderEntry,
    this.orderRowId,
    this.pickedQuantity,
    this.pickStatus,
    this.releasedQuantity,
    this.previouslyReleasedQuantity,
    this.baseObjectType,
    this.serialNumbers,
    this.batchNumbers,
    this.documentLinesBinAllocations,
    this.itemCode,
    this.itemDescription,
    this.warehouseCode,
    this.uomCode,
    this.manageBatchNumber,
    this.manageSerialNumber,
  }) : super(
          absoluteEntry: absoluteEntry,
          lineNumber: lineNumber,
          orderEntry: orderEntry,
          orderRowId: orderRowId,
          pickedQuantity: pickedQuantity,
          pickStatus: pickStatus,
          releasedQuantity: releasedQuantity,
          previouslyReleasedQuantity: previouslyReleasedQuantity,
          baseObjectType: baseObjectType,
          serialNumbers: serialNumbers,
          batchNumbers: batchNumbers,
          documentLinesBinAllocations: documentLinesBinAllocations,
          itemCode: itemCode,
          itemDescription: itemDescription,
          warehouseCode: warehouseCode,
          uomCode: uomCode,
          manageBatchNumber: manageBatchNumber,
          manageSerialNumber: manageSerialNumber,
        );

  PickListsLineModel copyWith({
    int? absoluteEntry,
    int? lineNumber,
    int? orderEntry,
    int? orderRowId,
    double? pickedQuantity,
    String? pickStatus,
    double? releasedQuantity,
    double? previouslyReleasedQuantity,
    dynamic baseObjectType,
    List<SerialNumberModel>? serialNumbers,
    List<BatchNumberModel>? batchNumbers,
    List<DocumentLinesBinAllocationModel>? documentLinesBinAllocations,
    String? itemCode,
    String? itemDescription,
    String? warehouseCode,
    String? uomCode,
    String? manageBatchNumber,
    String? manageSerialNumber,
  }) {
    final line = PickListsLineModel(
      absoluteEntry: absoluteEntry ?? this.absoluteEntry,
      lineNumber: lineNumber ?? this.lineNumber,
      orderEntry: orderEntry ?? this.orderEntry,
      orderRowId: orderRowId ?? this.orderRowId,
      pickedQuantity: pickedQuantity ?? this.pickedQuantity,
      pickStatus: pickStatus ?? this.pickStatus,
      releasedQuantity: releasedQuantity ?? this.releasedQuantity,
      previouslyReleasedQuantity:
          previouslyReleasedQuantity ?? this.previouslyReleasedQuantity,
      baseObjectType: baseObjectType ?? this.baseObjectType,
      serialNumbers: serialNumbers ?? this.serialNumbers,
      batchNumbers: batchNumbers ?? this.batchNumbers,
      documentLinesBinAllocations:
          documentLinesBinAllocations ?? this.documentLinesBinAllocations,
      itemCode: itemCode ?? this.itemCode,
      itemDescription: itemDescription ?? this.itemDescription,
      warehouseCode: warehouseCode ?? this.warehouseCode,
      uomCode: uomCode ?? this.uomCode,
      manageBatchNumber: manageBatchNumber ?? this.manageBatchNumber,
      manageSerialNumber: manageSerialNumber ?? this.manageSerialNumber,
    );
    return line;
  }

  factory PickListsLineModel.fromJson(Map<String, dynamic> json) =>
      PickListsLineModel(
        absoluteEntry: json["AbsoluteEntry"],
        lineNumber: json["LineNumber"],
        orderEntry: json["OrderEntry"],
        orderRowId: json["OrderRowID"],
        pickedQuantity: json["PickedQuantity"],
        pickStatus: json["PickStatus"],
        releasedQuantity: json["ReleasedQuantity"],
        previouslyReleasedQuantity: json["PreviouslyReleasedQuantity"],
        baseObjectType: json["BaseObjectType"],
        serialNumbers: json["SerialNumbers"] == null
            ? []
            : List<SerialNumberModel>.from(json["SerialNumbers"]!
                .map((x) => SerialNumberModel.fromJson(x))).toList(),
        batchNumbers: json["BatchNumbers"] == null
            ? []
            : List<BatchNumberModel>.from(json["BatchNumbers"]!
                .map((x) => BatchNumberModel.fromJson(x))).toList(),
        documentLinesBinAllocations: json["DocumentLinesBinAllocations"] == null
            ? []
            : List<DocumentLinesBinAllocationModel>.from(
                json["DocumentLinesBinAllocations"]!
                    .map((x) => DocumentLinesBinAllocationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AbsoluteEntry": absoluteEntry,
        "LineNumber": lineNumber,
        "OrderEntry": orderEntry,
        "OrderRowID": orderRowId,
        "PickedQuantity": pickedQuantity,
        "PickStatus": pickStatus,
        "ReleasedQuantity": releasedQuantity,
        "PreviouslyReleasedQuantity": previouslyReleasedQuantity,
        "BaseObjectType": baseObjectType,
        "SerialNumbers": serialNumbers == null
            ? []
            : List<dynamic>.from(serialNumbers!.map((x) => x)),
        "BatchNumbers": batchNumbers == null
            ? []
            : List<dynamic>.from(batchNumbers!.map((x) => x)),
        "DocumentLinesBinAllocations": documentLinesBinAllocations == null
            ? []
            : List<dynamic>.from(
                documentLinesBinAllocations!.map((x) => x.toJson())),
      };
}

class DocumentLinesBinAllocationModel extends DocumentLinesBinAllocationEntity {
  @override
  final int? binAbsEntry;
  @override
  final double? quantity;
  @override
  final String? allowNegativeQuantity;
  @override
  final int? serialAndBatchNumbersBaseLine;
  @override
  final int? baseLineNumber;

  DocumentLinesBinAllocationModel({
    this.binAbsEntry,
    this.quantity,
    this.allowNegativeQuantity,
    this.serialAndBatchNumbersBaseLine,
    this.baseLineNumber,
  });

  factory DocumentLinesBinAllocationModel.fromJson(Map<String, dynamic> json) =>
      DocumentLinesBinAllocationModel(
        binAbsEntry: json["BinAbsEntry"],
        quantity: json["Quantity"],
        allowNegativeQuantity: json["AllowNegativeQuantity"],
        serialAndBatchNumbersBaseLine: json["SerialAndBatchNumbersBaseLine"],
        baseLineNumber: json["BaseLineNumber"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "BinAbsEntry": binAbsEntry,
        "Quantity": quantity,
        "AllowNegativeQuantity": allowNegativeQuantity,
        "SerialAndBatchNumbersBaseLine": serialAndBatchNumbersBaseLine ?? -1,
        "BaseLineNumber": baseLineNumber ?? 0,
      };
}

class SerialNumberModel extends SerialNumberEntity {
  final dynamic manufacturerSerialNumber;
  final String? internalSerialNumber;
  final dynamic expiryDate;
  final dynamic manufactureDate;
  final String? receptionDate;
  final dynamic warrantyStart;
  final dynamic warrantyEnd;
  final dynamic location;
  final dynamic notes;
  final dynamic batchId;
  final int? systemSerialNumber;
  final int? baseLineNumber;
  final String? quantity;
  final dynamic trackingNote;
  final dynamic trackingNoteLine;
  final String? itemCode;

  SerialNumberModel({
    this.manufacturerSerialNumber,
    this.internalSerialNumber,
    this.expiryDate,
    this.manufactureDate,
    this.receptionDate,
    this.warrantyStart,
    this.warrantyEnd,
    this.location,
    this.notes,
    this.batchId,
    this.systemSerialNumber,
    this.baseLineNumber,
    this.quantity,
    this.trackingNote,
    this.trackingNoteLine,
    this.itemCode,
  });

  factory SerialNumberModel.fromJson(Map<String, dynamic> json) =>
      SerialNumberModel(
        manufacturerSerialNumber: json["ManufacturerSerialNumber"],
        internalSerialNumber: json["InternalSerialNumber"],
        expiryDate: json["ExpiryDate"],
        manufactureDate: json["ManufactureDate"],
        receptionDate: getDataFromDynamic(json["ReceptionDate"]),
        warrantyStart: json["WarrantyStart"],
        warrantyEnd: json["WarrantyEnd"],
        location: json["Location"],
        notes: json["Notes"],
        batchId: json["BatchID"],
        systemSerialNumber: json["SystemSerialNumber"],
        baseLineNumber: json["BaseLineNumber"],
        quantity: getDataFromDynamic(json["Quantity"]),
        trackingNote: json["TrackingNote"],
        trackingNoteLine: json["TrackingNoteLine"],
        itemCode: json["ItemCode"],
      );

  Map<String, dynamic> toJson() => {
        "ManufacturerSerialNumber": manufacturerSerialNumber,
        "InternalSerialNumber": internalSerialNumber,
        "ExpiryDate": expiryDate,
        "ManufactureDate": manufactureDate,
        "ReceptionDate": receptionDate,
        "WarrantyStart": warrantyStart,
        "WarrantyEnd": warrantyEnd,
        "Location": location,
        "Notes": notes,
        "BatchID": batchId,
        "SystemSerialNumber": systemSerialNumber,
        "BaseLineNumber": baseLineNumber,
        "Quantity": quantity,
        "TrackingNote": trackingNote,
        "TrackingNoteLine": trackingNoteLine,
        "ItemCode": itemCode,
      };
}

class BatchNumberModel extends BatchNumberEntity {
  final String? batchNumber;
  final dynamic manufacturerSerialNumber;
  final dynamic internalSerialNumber;
  final String? expiryDate;
  final String? manufacturingDate;
  final String? addmisionDate;
  final String? location;
  final dynamic notes;
  final String? quantity;
  final int? baseLineNumber;
  final dynamic trackingNote;
  final dynamic trackingNoteLine;
  final String? itemCode;
  final int? systemSerialNumber;

  BatchNumberModel({
    this.batchNumber,
    this.manufacturerSerialNumber,
    this.internalSerialNumber,
    this.expiryDate,
    this.manufacturingDate,
    this.addmisionDate,
    this.location,
    this.notes,
    this.quantity,
    this.baseLineNumber,
    this.trackingNote,
    this.trackingNoteLine,
    this.itemCode,
    this.systemSerialNumber,
  });

  factory BatchNumberModel.fromJson(Map<String, dynamic> json) =>
      BatchNumberModel(
        batchNumber: json["BatchNumber"],
        manufacturerSerialNumber: json["ManufacturerSerialNumber"],
        internalSerialNumber: json["InternalSerialNumber"],
        expiryDate: getDataFromDynamic(json["ExpiryDate"]),
        manufacturingDate: getDataFromDynamic(json["ManufacturingDate"]),
        addmisionDate: getDataFromDynamic(json["AddmisionDate"]),
        location: json["Location"],
        notes: json["Notes"],
        quantity: getDataFromDynamic(json["Quantity"]),
        baseLineNumber: json["BaseLineNumber"],
        trackingNote: json["TrackingNote"],
        trackingNoteLine: json["TrackingNoteLine"],
        itemCode: json["ItemCode"],
        systemSerialNumber: json["SystemSerialNumber"],
      );

  Map<String, dynamic> toJson() => {
        "BatchNumber": batchNumber,
        "ManufacturerSerialNumber": manufacturerSerialNumber,
        "InternalSerialNumber": internalSerialNumber,
        "ExpiryDate": expiryDate,
        "ManufacturingDate": manufacturingDate,
        "AddmisionDate": addmisionDate,
        "Location": location,
        "Notes": notes,
        "Quantity": quantity,
        "BaseLineNumber": baseLineNumber,
        "TrackingNote": trackingNote,
        "TrackingNoteLine": trackingNoteLine,
        "ItemCode": itemCode,
        "SystemSerialNumber": systemSerialNumber,
      };
}
