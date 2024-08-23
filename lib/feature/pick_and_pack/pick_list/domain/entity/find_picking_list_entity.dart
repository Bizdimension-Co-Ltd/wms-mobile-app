class PickListEntity {
  final int? absoluteentry;
  final String? name;
  final int? ownerCode;
  final dynamic ownerName;
  final DateTime? pickDate;
  final dynamic remarks;
  final String? status;
  final String? objectType;
  final String? useBaseUnits;
  final List<PickListsLineEntity>? pickListsLines;

  PickListEntity({
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

  bool get isClosed => status == 'ps_Closed';
}

class PickListsLineEntity {
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
  final List<DocumentLinesBinAllocationEntity>? documentLinesBinAllocations;

  final String? itemCode;
  final String? itemDescription;
  final String? warehouseCode;
  final String? uomCode;

  PickListsLineEntity({
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
  });
}

class DocumentLinesBinAllocationEntity {
  final int? binAbsEntry;
  final double? quantity;
  final String? allowNegativeQuantity;
  final int? serialAndBatchNumbersBaseLine;
  final int? baseLineNumber;

  DocumentLinesBinAllocationEntity({
    this.binAbsEntry,
    this.quantity,
    this.allowNegativeQuantity,
    this.serialAndBatchNumbersBaseLine,
    this.baseLineNumber,
  });
}
