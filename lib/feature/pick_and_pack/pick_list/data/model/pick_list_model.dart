import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';

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
  @override
  final String? itemCode;
  @override
  final String? itemDescription;
  @override
  final String? warehouseCode;
  @override
  final String? uomCode;

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
    this.warehouseCode,
    this.itemCode,
    this.itemDescription,
    this.uomCode,
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
  final List<dynamic>? serialNumbers;
  final List<dynamic>? batchNumbers;
  final List<DocumentLinesBinAllocationModel>? documentLinesBinAllocations;
  final String? itemCode;
  final String? itemDescription;
  final String? warehouseCode;
  final String? uomCode;

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
    List<dynamic>? serialNumbers,
    List<dynamic>? batchNumbers,
    List<DocumentLinesBinAllocationModel>? documentLinesBinAllocations,
    String? itemCode,
    String? itemDescription,
    String? warehouseCode,
    String? uomCode,
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
            : List<dynamic>.from(json["SerialNumbers"]!.map((x) => x)),
        batchNumbers: json["BatchNumbers"] == null
            ? []
            : List<dynamic>.from(json["BatchNumbers"]!.map((x) => x)),
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
