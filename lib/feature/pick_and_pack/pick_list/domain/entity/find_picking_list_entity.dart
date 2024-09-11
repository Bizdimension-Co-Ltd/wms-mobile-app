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

  PickListEntity copWith({
    List<PickListsLineEntity>? pickListsLines,
  }) =>
      PickListEntity(
        absoluteentry: absoluteentry,
        name: name,
        ownerCode: ownerCode,
        ownerName: ownerName,
        pickDate: pickDate,
        remarks: remarks,
        status: status,
        objectType: objectType,
        useBaseUnits: useBaseUnits,
        pickListsLines: pickListsLines ?? this.pickListsLines,
      );

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
  final List<SerialNumberEntity>? serialNumbers;
  final List<BatchNumberEntity>? batchNumbers;
  final List<DocumentLinesBinAllocationEntity>? documentLinesBinAllocations;

  final String? itemCode;
  final String? itemDescription;
  final String? warehouseCode;
  final String? uomCode;
  final String? manageBatchNumber;
  final String? manageSerialNumber;

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
    this.manageBatchNumber,
    this.manageSerialNumber,
  });

  PickListsLineEntity copyWith({
    double? pickedQuantity,
    double? releasedQuantity,
    List<SerialNumberEntity>? serialNumbers,
    List<BatchNumberEntity>? batchNumbers,
    List<DocumentLinesBinAllocationEntity>? documentLinesBinAllocations,
  }) =>
      PickListsLineEntity(
        absoluteEntry: absoluteEntry,
        lineNumber: lineNumber,
        orderEntry: orderEntry,
        orderRowId: orderRowId,
        pickedQuantity: pickedQuantity ?? this.pickedQuantity,
        pickStatus: pickStatus,
        releasedQuantity: releasedQuantity ?? this.releasedQuantity,
        previouslyReleasedQuantity: previouslyReleasedQuantity,
        baseObjectType: baseObjectType,
        serialNumbers: serialNumbers ?? this.serialNumbers,
        batchNumbers: batchNumbers ?? this.batchNumbers,
        documentLinesBinAllocations:
            documentLinesBinAllocations ?? this.documentLinesBinAllocations,
        itemCode: itemCode,
        itemDescription: itemDescription,
        warehouseCode: warehouseCode,
        uomCode: uomCode,
        manageBatchNumber: manageBatchNumber,
        manageSerialNumber: manageSerialNumber,
      );
}

class DocumentLinesBinAllocationEntity {
  final int? binAbsEntry;
  final double? quantity;
  final String? allowNegativeQuantity;
  final int? serialAndBatchNumbersBaseLine;
  final int? baseLineNumber;
  final String? binCode;

  DocumentLinesBinAllocationEntity({
    this.binAbsEntry,
    this.quantity,
    this.allowNegativeQuantity,
    this.serialAndBatchNumbersBaseLine,
    this.baseLineNumber,
    this.binCode,
  });

  DocumentLinesBinAllocationEntity copyWith({
    double? quantity,
    int? binAbsEntry,
    int? serialAndBatchNumbersBaseLine,
    int? baseLineNumber,
    String? binCode,
  }) =>
      DocumentLinesBinAllocationEntity(
        binAbsEntry: binAbsEntry ?? this.binAbsEntry,
        quantity: quantity ?? this.quantity,
        allowNegativeQuantity: allowNegativeQuantity,
        serialAndBatchNumbersBaseLine:
            serialAndBatchNumbersBaseLine ?? this.serialAndBatchNumbersBaseLine,
        baseLineNumber: baseLineNumber ?? this.baseLineNumber,
        binCode: binCode ?? this.binCode,
      );
}

class SerialNumberEntity {
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

  SerialNumberEntity({
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

  SerialNumberEntity copyWith({
    String? quantity,
    String? internalSerialNumber,
  }) =>
      SerialNumberEntity(
        manufacturerSerialNumber: manufacturerSerialNumber,
        internalSerialNumber: internalSerialNumber ?? this.internalSerialNumber,
        expiryDate: expiryDate,
        manufactureDate: manufactureDate,
        receptionDate: receptionDate,
        warrantyStart: warrantyStart,
        warrantyEnd: warrantyEnd,
        location: location,
        notes: notes,
        batchId: batchId,
        systemSerialNumber: systemSerialNumber,
        baseLineNumber: baseLineNumber,
        quantity: quantity ?? this.quantity,
        trackingNote: trackingNote,
        trackingNoteLine: trackingNoteLine,
        itemCode: itemCode,
      );
}

class BatchNumberEntity {
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

  BatchNumberEntity({
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

  BatchNumberEntity copyWith({
    String? quantity,
    String? batchNumber,
  }) =>
      BatchNumberEntity(
        batchNumber: batchNumber ?? this.batchNumber,
        manufacturerSerialNumber: manufacturerSerialNumber,
        internalSerialNumber: internalSerialNumber,
        expiryDate: expiryDate,
        manufacturingDate: manufacturingDate,
        addmisionDate: addmisionDate,
        location: location,
        notes: notes,
        quantity: quantity,
        baseLineNumber: baseLineNumber,
        trackingNote: trackingNote,
        trackingNoteLine: trackingNoteLine,
        itemCode: itemCode,
        systemSerialNumber: systemSerialNumber,
      );
}
