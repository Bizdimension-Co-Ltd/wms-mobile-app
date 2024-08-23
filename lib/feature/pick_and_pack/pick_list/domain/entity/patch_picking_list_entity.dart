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
}

class PickListsLineEntity {
  final int? absoluteEntry;
  final int? lineNumber;
  final int? orderEntry;
  final int? orderRowId;
  final int? pickedQuantity;
  final String? pickStatus;
  final int? releasedQuantity;
  final int? previouslyReleasedQuantity;
  final int? baseObjectType;
  final List<dynamic>? serialNumbers;
  final List<dynamic>? batchNumbers;
  final List<DocumentLinesBinAllocationEntity>? documentLinesBinAllocations;

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
  });
}

class DocumentLinesBinAllocationEntity {
  final int? binAbsEntry;
  final int? quantity;
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
