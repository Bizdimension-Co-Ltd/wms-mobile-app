import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/item/domain/entity/item_entity.dart';
import '/feature/item/presentation/cubit/item_cubit.dart';
import '/feature/pick_and_pack/pick_list/presentation/cubit/pick_list_cubit.dart';
import '/feature/pick_and_pack/pick_list/presentation/pick/picking_item_bin_screen.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/presentation/cubit/warehouse_cubit.dart';
import '/utilies/dialog/dialog.dart';

import '../../../../../component/button/button.dart';
import '../../../../../component/form/input.dart';
import '../../../../../constant/style.dart';
import '../../../../../helper/helper.dart';
import '../../domain/entity/find_picking_list_entity.dart';

class PickingItemBatchScreen extends StatefulWidget {
  const PickingItemBatchScreen(
      {super.key, required this.picking, required this.lineEntity});

  final PickListEntity picking;
  final PickListsLineEntity lineEntity;

  @override
  State<PickingItemBatchScreen> createState() => _PickingItemBatchScreenState();
}

class _PickingItemBatchScreenState extends State<PickingItemBatchScreen> {
  final whs = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();
  final itemUoM = TextEditingController();
  final openQty = TextEditingController();
  final pickQty = TextEditingController();
  final binLocation = TextEditingController();

  late WarehouseCubit whsContext;
  late PickListCubit pickingListContext;
  late ItemCubit itemContext;

  late PickListsLineEntity pickingLine;
  WarehouseEntity? warehouseEntity;
  bool isSerialOrBatch = true;
  bool loading = true;
  bool isItemBatchOrSerial = false;
  late ItemEntity _item;

  @override
  void initState() {
    if (mounted) {
      whsContext = context.read<WarehouseCubit>();
      pickingListContext = context.read<PickListCubit>();
      itemContext = context.read<ItemCubit>();
    }

    pickingLine = widget.lineEntity;
    whs.text = widget.lineEntity.warehouseCode ?? "";
    itemCode.text = widget.lineEntity.itemCode ?? "";
    itemName.text = widget.lineEntity.itemDescription ?? "";
    itemUoM.text = widget.lineEntity.uomCode ?? "";
    openQty.text = widget.lineEntity.releasedQuantity?.toString() ?? "";
    pickQty.text = widget.lineEntity.pickedQuantity?.toString() ?? "";

    onPressedItem(widget.lineEntity);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void clear() {
    whs.clear();
    itemCode.clear();
    itemUoM.clear();
    openQty.clear();
    pickQty.clear();
    binLocation.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedItem(PickListsLineEntity entity) async {
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) MaterialDialog.loading(context, barrierDismissible: true);

    ItemEntity item = await itemContext.find(entity.itemCode ?? "");
    final warehouse = await whsContext.find(entity.warehouseCode ?? "");

    setState(() {
      isSerialOrBatch = (item.isBatch || item.isSerial) ? false : true;
      pickingLine = entity;
      warehouseEntity = warehouse;
      loading = false;
      isItemBatchOrSerial = item.isBatch || item.isSerial;
      item = item;
      print(isItemBatchOrSerial);
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) MaterialDialog.close(context);
  }

  void onRemoveItem(int index) {
    MaterialDialog.warning(
      context,
      title: 'Remove',
      body: 'Are you sure want to remove',
      onConfirm: () {
        removeItemByIndex(index);
      },
    );
  }

  void removeItemByIndex(int index) {
    List<DocumentLinesBinAllocationEntity> entities = [
      ...pickingLine.documentLinesBinAllocations ?? []
    ];

    final removed = entities.elementAtOrNull(index);
    if (removed == null) return;

    entities.removeAt(index);
    final total =
        entities.fold(0.00, (prev, next) => prev + (next.quantity ?? 0.00));

    final batchTotal = entities
        .where((e) =>
            e.serialAndBatchNumbersBaseLine ==
            removed.serialAndBatchNumbersBaseLine)
        .toList()
        .fold(0.00, (prev, next) => prev + (next.quantity ?? 0.00));

    final serialMultipleBins = pickingLine.documentLinesBinAllocations?.where(
        (e) =>
            e.serialAndBatchNumbersBaseLine ==
            removed.serialAndBatchNumbersBaseLine);

    var batches = [...pickingLine.batchNumbers ?? []];
    batches[removed.serialAndBatchNumbersBaseLine ?? 0] =
        batches[removed.serialAndBatchNumbersBaseLine ?? 0]
            .copyWith(quantity: batchTotal.toString());

    // remove if serial if it have only bin otherwise it will not remove
    if (serialMultipleBins?.length == 1) {
      batches.removeAt(removed.serialAndBatchNumbersBaseLine ?? -1);
    } else {
      // otherwise it will update quantity to serials
      batches[removed.serialAndBatchNumbersBaseLine ?? 0] =
          batches[removed.serialAndBatchNumbersBaseLine ?? 0]
              .copyWith(quantity: batchTotal.toString());
    }

    for (var row = 0; row < batches.length; row++) {
      entities[row] =
          entities[row].copyWith(serialAndBatchNumbersBaseLine: row);
    }

    pickingLine = pickingLine.copyWith(
      pickedQuantity: total,
      documentLinesBinAllocations: entities,
      // ignore: unnecessary_cast
      batchNumbers: batches as List<BatchNumberEntity>,
    );

    pickQty.text = total.toString();
    openQty.text = ((widget.lineEntity.previouslyReleasedQuantity ?? 0) - total)
        .toString();
    setState(() {
      pickingLine;
    });
  }

  void onUpdateItem(
    BatchNumberEntity entity,
    DocumentLinesBinAllocationEntity allocation,
    int index,
  ) {
    PickListsLineEntity line = pickingLine.copyWith(
      batchNumbers: [entity],
      documentLinesBinAllocations: [allocation],
    );

    goTo(
        context,
        PickingBinItemScreen(
          lines: line,
          rowIndex: index,
          item: _item,
        )).then(
      (onValue) {
        if (onValue is int) {
          removeItemByIndex(index);
          return;
        }

        if (onValue == null) return;

        onCompleteUpdateInput(onValue as PickListsLineEntity, isUpdate: true);
      },
    );
  }

  void onAddItem() {
    PickListsLineEntity line = pickingLine.copyWith(
      batchNumbers: [],
      documentLinesBinAllocations: [],
    );

    goTo(context, PickingBinItemScreen(lines: line, item: _item)).then(
      (onValue) {
        if (onValue == null) return;
        onCompleteAddInput(onValue as PickListsLineEntity);
      },
    );
  }

  void onCompleteAddInput(PickListsLineEntity value) {
    final index = pickingLine.batchNumbers?.indexWhere(
        (e) => e.batchNumber == value.batchNumbers?.first.batchNumber);

    final itemIndex =
        index != null && index != -1 ? index : pickingLine.batchNumbers!.length;

    List<BatchNumberEntity> batches = [...pickingLine.batchNumbers ?? []];
    List<DocumentLinesBinAllocationEntity> allocations = [
      ...pickingLine.documentLinesBinAllocations ?? []
    ];

    batches.add(
      BatchNumberEntity(
        quantity: value.documentLinesBinAllocations?.first.quantity?.toString(),
        batchNumber: value.batchNumbers?.first.batchNumber,
      ),
    );

    // add bin allocations
    allocations.add(DocumentLinesBinAllocationEntity(
      quantity: value.documentLinesBinAllocations?.first.quantity,
      binAbsEntry: value.documentLinesBinAllocations?.first.binAbsEntry,
      serialAndBatchNumbersBaseLine: itemIndex,
    ));

    pickingLine = pickingLine.copyWith(
      batchNumbers: batches,
      documentLinesBinAllocations: allocations,
    );

    updateCurrenState(pickingLine);
  }

  void onCompleteUpdateInput(PickListsLineEntity value,
      {bool isUpdate = false}) {
    final index = pickingLine.documentLinesBinAllocations?.indexWhere((e) =>
        e.binAbsEntry == value.documentLinesBinAllocations?.first.binAbsEntry);

    if (index == null || index == -1) return;

    // if index is null or -1 then skip process below
    List<BatchNumberEntity> batches = [...pickingLine.batchNumbers ?? []];
    List<DocumentLinesBinAllocationEntity> allocations = [
      ...pickingLine.documentLinesBinAllocations ?? []
    ];

    // update bin allocations by index
    allocations[index] = allocations[index].copyWith(
      quantity: value.documentLinesBinAllocations?.first.quantity,
      binAbsEntry: value.documentLinesBinAllocations?.first.binAbsEntry,
    );

    final batchIndex = batches.indexWhere(
        (e) => e.batchNumber == value.batchNumbers?.first.batchNumber);

    if (batchIndex == -1) return;

    final totalQty = allocations
        .where((e) => e.serialAndBatchNumbersBaseLine == batchIndex)
        .toList()
        .fold(0.00, (prev, next) => prev + (next.quantity ?? 0.00));

    batches[batchIndex] =
        batches[batchIndex].copyWith(quantity: totalQty.toString());

    pickingLine = pickingLine.copyWith(
      batchNumbers: batches,
      documentLinesBinAllocations: allocations,
      pickedQuantity: totalQty,
    );

    //  calculate total item qty
    updateCurrenState(pickingLine);
  }

  void updateCurrenState(PickListsLineEntity entity) {
    final total = entity.documentLinesBinAllocations
        ?.fold(0.00, (pre, cur) => pre + (cur.quantity ?? 0));

    pickQty.text = total.toString();
    openQty.text =
        ((pickingLine.previouslyReleasedQuantity ?? 0) - (total ?? 0.00))
            .toString();

    pickingLine = pickingLine.copyWith(
      pickedQuantity: double.tryParse(pickQty.text),
      releasedQuantity: double.tryParse(openQty.text),
    );

    setState(() {
      pickingLine;
    });
  }

  Future<void> onFinish() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        MaterialDialog.loading(context, barrierDismissible: false);
      }

      PickListEntity entity = widget.picking;
      final index = entity.pickListsLines
          ?.indexWhere((e) => e.lineNumber == pickingLine.lineNumber);
      if (index == null || index == 1) return;

      List<PickListsLineEntity> line = [...entity.pickListsLines ?? []];

      if (!isItemBatchOrSerial) {
        line[index] = pickingLine.copyWith(
          pickedQuantity: double.tryParse(pickQty.text) ?? 0.00,
          releasedQuantity: (pickingLine.previouslyReleasedQuantity ?? 0) -
              (double.tryParse(pickQty.text) ?? 0.00),
        );
      } else {
        line[index] = pickingLine;
      }

      entity = entity.copWith(pickListsLines: line);
      await pickingListContext.update(entity);
      if (mounted) {
        MaterialDialog.close(context);
        MaterialDialog.warning(
          context,
          title: "Updated",
          body: 'Data sync to SAP',
          onConfirm: () {
            Navigator.of(context).pop(entity);
          },
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        MaterialDialog.close(context);
        MaterialDialog.warning(context, title: 'Oop!', body: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Picking / Entry (${widget.picking.absoluteentry})',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Input(
              label: 'Item Code',
              placeholder: 'Item Code',
              readOnly: true,
              controller: itemCode,
            ),
            Input(
              label: 'Item Description',
              placeholder: 'Item Description',
              readOnly: true,
              controller: itemName,
            ),
            Input(
              label: 'Item UoM',
              placeholder: 'Item UoM',
              readOnly: true,
              controller: itemUoM,
            ),
            Input(
              label: 'Open Qty.',
              placeholder: 'Open Qty.',
              keyboardType: TextInputType.number,
              readOnly: true,
              controller: openQty,
            ),
            Input(
              label: 'Pick Qty. ',
              placeholder: 'Pick Qty.',
              keyboardType: TextInputType.number,
              readOnly: isItemBatchOrSerial,
              controller: pickQty,
              onChange: (value) {
                if (value == "") {
                  openQty.text = widget.lineEntity.previouslyReleasedQuantity
                          ?.toString() ??
                      "";
                } else {
                  openQty.text =
                      ((widget.lineEntity.previouslyReleasedQuantity ?? 0) -
                              (double.tryParse(value) ?? 0))
                          .toString();
                }

                pickQty.text = value;
              },
            ),
            Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    if (isItemBatchOrSerial)
                      Expanded(
                        child: Button(
                          onPressed: onAddItem,
                          disabled: isSerialOrBatch ||
                              pickingLine.releasedQuantity == 0,
                          child: Text(
                            'Add Item',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (isItemBatchOrSerial) const SizedBox(width: 10),
                    // Expanded(
                    //   child: Button(
                    //     onPressed: () {},
                    //     disabled: isSerialOrBatch,
                    //     child: Text(
                    //       'Edit',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Button(
                        onPressed: onFinish,
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (isItemBatchOrSerial)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ContentHeader(),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Scrollbar(
                        child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                pickingLine
                                        .documentLinesBinAllocations?.length ??
                                    0,
                                (index) {
                                  final allocation = pickingLine
                                      .documentLinesBinAllocations![index];
                                  final batch = pickingLine.batchNumbers![
                                      allocation
                                              .serialAndBatchNumbersBaseLine ??
                                          0];

                                  return GestureDetector(
                                    child: ItemRow(
                                      code: batch.batchNumber ?? "",
                                      allocation: allocation,
                                      onTap: () => onUpdateItem(
                                          batch, allocation, index),
                                      onLongTap: () => onRemoveItem(index),
                                    ),
                                  );
                                },
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          bottom: BorderSide(width: 0.1),
          top: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Batch Number.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Expanded(child: Text('UoM.')),
          Expanded(child: Text('Qty.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow(
      {super.key,
      required this.code,
      required this.allocation,
      required this.onTap,
      this.onLongTap});

  final String code;
  final DocumentLinesBinAllocationEntity allocation;
  final Function() onTap;
  final Function()? onLongTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onLongPress: onLongTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    code,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('${allocation.quantity}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
