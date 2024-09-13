import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/bin_location/domain/entity/bin_entity.dart';
import '/feature/bin_location/presentation/cubit/bin_cubit.dart';
import '/feature/bin_location/presentation/screen/bin_page.dart';
import '/feature/item/domain/entity/item_entity.dart';
import '/feature/item/presentation/cubit/item_cubit.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/presentation/cubit/warehouse_cubit.dart';
import '/utilies/dialog/dialog.dart';

import '../../../../../component/button/button.dart';
import '../../../../../component/form/input.dart';
import '../../../../../constant/style.dart';
import '../../../../../helper/helper.dart';
import '../../domain/entity/find_picking_list_entity.dart';

class PickingBinItemScreen extends StatefulWidget {
  const PickingBinItemScreen({
    super.key,
    required this.lines,
    this.rowIndex,
    required this.item,
  });

  final PickListsLineEntity lines;
  final int? rowIndex;
  final ItemEntity item;

  @override
  State<PickingBinItemScreen> createState() => _PickingBinItemScreenState();
}

class _PickingBinItemScreenState extends State<PickingBinItemScreen> {
  final whs = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();
  final batchSerialCode = TextEditingController();
  final binId = TextEditingController();
  final pickQty = TextEditingController();
  final binLocation = TextEditingController();

  late WarehouseCubit whsContext;
  late BinCubit binContext;
  late ItemCubit itemContext;

  WarehouseEntity? warehouseEntity;
  bool isSerialOrBatch = true;

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
    itemCode.text = widget.lines.itemCode ?? "";
    itemName.text = widget.lines.itemDescription ?? "";

    if (widget.lines.documentLinesBinAllocations!.isNotEmpty) {
      batchSerialCode.text = widget.item.isSerial
          ? widget.lines.serialNumbers?.first.internalSerialNumber ?? ""
          : widget.lines.batchNumbers?.first.batchNumber ?? "";

      pickQty.text = widget.lines.documentLinesBinAllocations?.first.quantity
              ?.toString() ??
          "";
    }

    onPressedItem(widget.lines);
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

  void onPressedItem(PickListsLineEntity entity) async {
    final warehouse = await whsContext.find(entity.warehouseCode ?? "");

    setState(() {
      isSerialOrBatch =
          (widget.item.isBatch || widget.item.isSerial) ? false : true;
      warehouseEntity = warehouse;
    });

    print("----> ${warehouse?.code}");

    // check if warehouse is enabled bin
    if (!warehouse!.isEnableBin) return;
    // find exist bin records
    if (widget.lines.documentLinesBinAllocations!.length > 0) {
      final bins = await binContext.get(entity.warehouseCode ?? "");
      final bin = bins
          .where(
            (e) =>
                e.binId ==
                widget.lines.documentLinesBinAllocations!.first.binAbsEntry,
          )
          .toList();

      if (bin.isEmpty) return;

      binId.text = bin.first.binId.toString();
      binLocation.text = bin.first.code.toString();
    }
  }

  void onComplete() {
    try {
      if (binId.text == '') {
        throw Exception("Please select bin location.");
      }

      if (pickQty.text == '' || double.parse(pickQty.text) < 0) {
        throw Exception("Quantity must be positive number.");
      }

      // final bins = widget.lines.documentLinesBinAllocations
      //     ?.where((e) => e.binAbsEntry != int.parse(binId.text))
      //     .toList();

      // double total =
      //     bins?.fold(0, (pre, next) => pre! + (next.quantity ?? 0)) ?? 0;

      // total += double.parse(pickQty.text);

      // if (total > (widget.lines.previouslyReleasedQuantity ?? 0)) {
      //   throw Exception(
      //       "Quantity can not be greater than ${widget.lines.previouslyReleasedQuantity}");
      // }

      PickListsLineEntity pickLine = PickListsLineEntity(
        documentLinesBinAllocations: [
          DocumentLinesBinAllocationEntity(
            quantity: double.parse(pickQty.text),
            binAbsEntry: int.parse(binId.text),
            binCode: binLocation.text,
          ),
        ],
      );

      if (widget.item.isSerial) {
        pickLine = pickLine.copyWith(serialNumbers: [
          SerialNumberEntity(
            internalSerialNumber: batchSerialCode.text,
            quantity: pickQty.text,
          ),
        ]);
      } else {
        pickLine = pickLine.copyWith(batchNumbers: [
          BatchNumberEntity(
            batchNumber: batchSerialCode.text,
            quantity: pickQty.text,
          ),
        ]);
      }

      Navigator.of(context).pop(pickLine);
    } on Exception catch (e) {
      MaterialDialog.warning(context, title: "Oop.", body: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Picking / Entry (${widget.lines.absoluteEntry})',
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
            // Input(
            //   label: 'Item Code',
            //   placeholder: 'Item Code',
            //   readOnly: true,
            //   controller: itemCode,
            // ),
            // Input(
            //   label: 'Item Description',
            //   placeholder: 'Item Description',
            //   readOnly: true,
            //   controller: itemName,
            // ),
            Input(
              label: widget.item.isSerial ? 'Serial No.' : 'Batch No.',
              placeholder: widget.item.isSerial ? 'Serial No.' : 'Batch No.',
              controller: batchSerialCode,
            ),
            Input(
              label: 'Quantity',
              placeholder: 'Quantity',
              keyboardType: TextInputType.number,
              controller: pickQty,
            ),
            if (widget.lines.warehouseCode != null &&
                warehouseEntity?.isEnableBin == true)
              Input(
                label: 'Bin Location.',
                placeholder: 'Bin Location',
                readOnly: true,
                controller: binLocation,
                onPressed: () => goTo(
                    context,
                    BinPage(
                      warehouse: widget.lines.warehouseCode ?? "",
                      itemCode: widget.lines.itemCode,
                    )).then(
                  (val) {
                    if (val != null) {
                      binLocation.text = (val as BinEntity).code;
                      binId.text = (val).id.toString();
                    }
                  },
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: widget.lines.documentLinesBinAllocations!.isNotEmpty
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
              'Item Number',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('UoM.')),
          Expanded(child: Text('Qty.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({super.key, required this.item, required this.onTap});

  final PickListsLineEntity item;
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
                    getDataFromDynamic(item.itemCode),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(getDataFromDynamic(item.uomCode)),
                ),
                Expanded(
                  child:
                      Text('${item.pickedQuantity}/${item.releasedQuantity}'),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(getDataFromDynamic(item.itemDescription)),
          ],
        ),
      ),
    );
  }
}
