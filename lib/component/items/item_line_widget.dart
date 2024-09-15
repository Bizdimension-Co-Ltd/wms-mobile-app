import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/component/button/button.dart';
import '/component/items/item_line_batch_serial_widget.dart';
import '/core/enum/global.dart';
import '/core/model/abstraction.dart';
import '/feature/unit_of_measurement/domain/entity/unit_of_measurement_entity.dart';
import '/feature/unit_of_measurement/presentation/screen/unit_of_measurement_page.dart';
import '/helper/helper.dart';
import '../../feature/bin_location/domain/entity/bin_entity.dart';
import '../../feature/bin_location/presentation/screen/bin_page.dart';
import '../../feature/item/presentation/screen/item_page.dart';
import '/feature/bin_location/presentation/cubit/bin_cubit.dart';
import '/feature/item/domain/entity/item_entity.dart';
import '/feature/item/presentation/cubit/item_cubit.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/presentation/cubit/warehouse_cubit.dart';
import '/utilies/dialog/dialog.dart';

import '../../../../../component/form/input.dart';
import '../../../../../constant/style.dart';

class ItemLineWidgetScreen extends StatefulWidget {
  const ItemLineWidgetScreen({
    super.key,
    this.rowIndex,
    this.item,
    required this.warehouseCode,
  });

  final int? rowIndex;
  final ItemEntity? item;
  final String warehouseCode;

  @override
  State<ItemLineWidgetScreen> createState() => _ItemLineWidgetScreenState();
}

class _ItemLineWidgetScreenState extends State<ItemLineWidgetScreen> {
  final whs = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();
  final batchSerialCode = TextEditingController();
  final binId = TextEditingController();
  final pickQty = TextEditingController();
  final binLocation = TextEditingController();
  final uom = TextEditingController();

  late WarehouseCubit whsContext;
  late BinCubit binContext;
  late ItemCubit itemContext;

  WarehouseEntity? warehouseEntity;
  ItemEntity? item;
  bool isSerialOrBatch = true;
  UnitOfMeasurementEntity? unitOfMeasurementEntity;

  List<ItemBinAllocation> allocations = [];

  @override
  void initState() {
    if (mounted) {
      whsContext = context.read<WarehouseCubit>();
      binContext = context.read<BinCubit>();
      itemContext = context.read<ItemCubit>();
    }

    init();
    super.initState();
  }

  void init() async {
    final whs = await whsContext.find(widget.warehouseCode);

    setState(() {
      warehouseEntity = whs;
    });
  }

  void clear() {
    whs.clear();
    itemCode.clear();
    batchSerialCode.clear();
    binId.clear();
    pickQty.clear();
    binLocation.clear();
    binId.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedItem() async {
    // final warehouse = await whsContext.find(entity.warehouseCode ?? "");

    // setState(() {
    //   isSerialOrBatch =
    //       (widget.item.isBatch || widget.item.isSerial) ? false : true;
    //   warehouseEntity = warehouse;
    // });

    // print("----> ${warehouse?.code}");

    // // check if warehouse is enabled bin
    // if (!warehouse!.isEnableBin) return;
    // // find exist bin records
    // if (widget.lines.documentLinesBinAllocations!.length > 0) {
    //   final bins = await binContext.get(entity.warehouseCode ?? "");
    //   final bin = bins
    //       .where(
    //         (e) =>
    //             e.binId ==
    //             widget.lines.documentLinesBinAllocations!.first.binAbsEntry,
    //       )
    //       .toList();

    //   if (bin.isEmpty) return;

    //   binId.text = bin.first.binId.toString();
    //   binLocation.text = bin.first.code.toString();
    // }
  }

  void onComplete() {
    try {
      if (binId.text == '') {
        throw Exception("Please select bin location.");
      }

      if (pickQty.text == '' || double.parse(pickQty.text) < 0) {
        throw Exception("Quantity must be positive number.");
      }

      final ItemLineEntity item = ItemLineEntity(
        itemCode: itemCode.text,
        itemName: itemName.text,
        qty: pickQty.text,
        uomId: int.tryParse(uom.text) ?? -1,
        uomCode: unitOfMeasurementEntity?.code,
      );

      // Navigator.of(context).pop();
    } on Exception catch (e) {
      MaterialDialog.warning(context, title: "Oop.", body: e.toString());
    }
  }

  void onChangeUoM() {
    if (item?.uoMGroupDefinitionCollection?.uoMGroupDefinitionCollection
            ?.length ==
        1) return;
    final ids = item?.uoMGroupDefinitionCollection?.uoMGroupDefinitionCollection
        ?.map((e) => int.tryParse(e.alternateUoM ?? '-1') ?? -1)
        .toList();
    goTo(context, UnitOfMeasurementPage(ids: ids ?? [])).then((value) {
      if (value == null) return;
      value as UnitOfMeasurementEntity;
      uom.text = value.code;
      setState(() => unitOfMeasurementEntity = value);
    });
  }

  void onSelectItem() {
    goTo(context, ItemPage(type: ItemType.purchase)).then(
      (value) {
        if (value == null) return;

        itemCode.text = (value as ItemEntity).code;
        itemName.text = value.name;
        pickQty.text = '0';
        uom.text = value.inventoryUOM;
        setState(() => item = value);
      },
    );
  }

  void onSelectBin() async {
    try {
      if (item == null) {
        throw Exception('Please select item first');
      }

      goTo(
          context,
          BinPage(
            warehouse: widget.warehouseCode,
            itemCode: itemCode.text,
          )).then(
        (val) {
          if (val != null) {
            binLocation.text = (val as BinEntity).code;
            binId.text = (val).id.toString();
          }
        },
      );
    } catch (e) {
      MaterialDialog.warning(
        context,
        title: 'Oop!',
        body: 'Please select item first',
      );
    }
  }

  void onPickBatchOrSerial({ItemBinAllocation? entity}) {
    try {
      if (item == null) {
        throw Exception("Please select item first");
      }

      goTo(
        context,
        ItemLineBatchOrSerialScreen(
          line: entity,
          item: item!,
          warehouse: warehouseEntity,
        ),
      ).then((value) {
        if (value == null) return;

        onUpdateValue(value);
      });
    } on Exception catch (e) {
      MaterialDialog.warning(
        context,
        title: 'Oop!',
        body: e.toString(),
      );
    }
  }

  void onUpdateItem(ItemBinAllocation entity, int index) async {
    try {
      if (item == null) {
        throw Exception("Please select item first");
      }

      goTo(
        context,
        ItemLineBatchOrSerialScreen(
          line: entity,
          item: item!,
          warehouse: warehouseEntity,
          rowIndex: index,
        ),
      ).then((value) {
        if (value == null) return;

        if (value is ItemBinAllocation) {
          onUpdateValue(value);
        }

        if (value is int) {
          removeItem(value);
        }
      });
    } on Exception catch (e) {
      MaterialDialog.warning(
        context,
        title: 'Oop!',
        body: e.toString(),
      );
    }
  }

  void removeItem(int index) {
    try {
      List<ItemBinAllocation> _allocations = [...allocations];
      _allocations.removeAt(index);

      setState(() => allocations = _allocations);
    } catch (e) {
      MaterialDialog.warning(
        context,
        title: 'Oop!',
        body: e.toString(),
      );
    }
  }

  void onUpdateValue(ItemBinAllocation value) {
    List<ItemBinAllocation> _allocations = [...allocations];
    final exist = allocations.indexWhere((e) =>
        e.batchOrSerialCode == value.batchOrSerialCode &&
        e.binId == value.binId);

    if (exist >= 0) {
      _allocations[exist] = _allocations[exist].copyWith(
        qty: value.qty,
        batchOrSerialCode: value.batchOrSerialCode,
        binId: value.binId,
        binCode: value.binCode,
      );
    } else {
      _allocations.add(value);
    }

    final total = _allocations.fold(
        0.00, (prev, next) => prev + (double.tryParse(next.qty ?? "") ?? 0.0));
    pickQty.text = total.toString();

    setState(() => allocations = _allocations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add Item',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
              onPressed: onComplete,
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          const SizedBox(width: 8)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Input(
              label: 'Item Code',
              placeholder: 'Item Code',
              controller: itemCode,
              onPressed: onSelectItem,
            ),
            Input(
              label: 'Item Description',
              placeholder: 'Item Description',
              readOnly: true,
              controller: itemName,
            ),
            // Input(
            //   label: widget.item?.isSerial ? 'Serial No.' : 'Batch No.',
            //   placeholder: widget.item.isSerial ? 'Serial No.' : 'Batch No.',
            //   controller: batchSerialCode,
            // ),
            Input(
              label: 'Quantity',
              placeholder: 'Quantity',
              keyboardType: TextInputType.number,
              controller: pickQty,
            ),
            Input(
              controller: uom,
              label: 'UoM.',
              placeholder: 'Unit Of Measurement',
              onPressed: onChangeUoM,
            ),
            if ((warehouseEntity != null && warehouseEntity!.isEnableBin) &&
                (item != null && !item!.isManageBatchOrSerial))
              Input(
                label: 'Bin Location.',
                placeholder: 'Bin Location',
                readOnly: true,
                controller: binLocation,
                onPressed: onSelectBin,
              ),
            const SizedBox(height: 30),

            if (item != null && item?.isManageBatchOrSerial == true)
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: size(context).height * 0.045,
                      child: Row(
                        children: [
                          Expanded(
                              child: Button(
                            child: Text('Add'),
                            onPressed: () => onPickBatchOrSerial(),
                          )),
                          const Expanded(child: SizedBox()),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ContentHeader(item: item!),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Scrollbar(
                        child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                allocations.length,
                                (index) {
                                  return GestureDetector(
                                    child: ItemRow(
                                      code: allocations[index]
                                              .batchOrSerialCode ??
                                          "",
                                      qty: allocations[index].qty.toString(),
                                      onTap: () => onUpdateItem(
                                        allocations[index],
                                        index,
                                      ),
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
      bottomNavigationBar: widget.rowIndex != null
          ? SizedBox(
              height: size(context).height * 0.06,
              child: Button(
                borderRadius: 0,
                onPressed: () => Navigator.of(context).pop(widget.rowIndex),
                bgColor: Colors.redAccent,
                child: Text(
                  'Remove',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    super.key,
    required this.item,
  });

  final ItemEntity item;

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
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item.isBatch ? "Batch Number" : "Serial No.",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('Qty.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.onTap,
    required this.code,
    required this.qty,
  });

  final String code;
  final String qty;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Expanded(child: Text(qty)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
