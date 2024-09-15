import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/core/model/abstraction.dart';
import '../../feature/bin_location/domain/entity/bin_entity.dart';
import '../../feature/bin_location/presentation/screen/bin_page.dart';
import '../../helper/helper.dart';
import '/feature/bin_location/presentation/cubit/bin_cubit.dart';
import '/feature/item/domain/entity/item_entity.dart';
import '/feature/item/presentation/cubit/item_cubit.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/presentation/cubit/warehouse_cubit.dart';
import '/utilies/dialog/dialog.dart';

import '../../../../../component/button/button.dart';
import '../../../../../component/form/input.dart';
import '../../../../../constant/style.dart';

class ItemLineBatchOrSerialScreen extends StatefulWidget {
  const ItemLineBatchOrSerialScreen({
    super.key,
    required this.line,
    this.rowIndex,
    required this.item,
    this.warehouse,
  });

  final ItemBinAllocation? line;
  final int? rowIndex;
  final ItemEntity item;
  final WarehouseEntity? warehouse;

  @override
  State<ItemLineBatchOrSerialScreen> createState() =>
      _ItemLineBatchOrSerialScreenState();
}

class _ItemLineBatchOrSerialScreenState
    extends State<ItemLineBatchOrSerialScreen> {
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

  late ItemBinAllocation allocation;

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
    allocation = widget.line == null ? ItemBinAllocation() : widget.line!;

    if (widget.line != null) {
      pickQty.text = widget.line?.qty ?? "";
      batchSerialCode.text = widget.line?.batchOrSerialCode ?? "";
      binId.text = widget.line?.binId?.toString() ?? "";
      binLocation.text = widget.line?.binCode?.toString() ?? "";
    }
  }

  void clear() {
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

  void onSelectBin() async {
    try {
      goTo(
          context,
          BinPage(
            warehouse: widget.warehouse?.code ?? "",
            itemCode: widget.item.code,
          )).then(
        (val) {
          if (val != null) {
            binLocation.text = (val as BinEntity).code;
            binId.text = (val).id.toString();
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void onComplete() {
    try {
      if (batchSerialCode.text == '') {
        throw Exception("Please Batch or Serial can not be empty.");
      }

      if (widget.warehouse?.isEnableBin == true && binId.text == '') {
        throw Exception("Please select bin location.");
      }

      if (widget.warehouse?.isEnableBin == true && pickQty.text == '' ||
          double.parse(pickQty.text) < 0) {
        throw Exception("Quantity must be positive number.");
      }

      allocation = allocation.copyWith(
        batchOrSerialCode: batchSerialCode.text,
        qty: pickQty.text,
        binId: int.parse(binId.text),
        binCode: binLocation.text,
      );

      Navigator.of(context).pop(allocation);
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
          'Pick Bin Allocation',
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
            if (widget.warehouse?.isEnableBin == true)
              Input(
                label: 'Bin Location.',
                placeholder: 'Bin Location',
                readOnly: true,
                controller: binLocation,
                onPressed: onSelectBin,
              ),
          ],
        ),
      ),
      bottomNavigationBar: widget.line != null
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
