import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/bin_location/presentation/cubit/bin_cubit.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/presentation/pick/picking_item_screen.dart';
import 'package:wms_mobile/feature/warehouse/domain/entity/warehouse_entity.dart';
import 'package:wms_mobile/feature/warehouse/presentation/cubit/warehouse_cubit.dart';

import '../../../../../component/form/input.dart';
import '../../../../../constant/style.dart';
import '../../../../../helper/helper.dart';
import '../../domain/entity/find_picking_list_entity.dart';

class PickingScreen extends StatefulWidget {
  const PickingScreen({super.key, required this.picking});

  final PickListEntity picking;

  @override
  State<PickingScreen> createState() => _PickingScreenState();
}

class _PickingScreenState extends State<PickingScreen> {
  final whs = TextEditingController();
  final itemCode = TextEditingController();
  final itemUoM = TextEditingController();
  final openQty = TextEditingController();
  final pickQty = TextEditingController();

  late WarehouseCubit whsContext;
  late BinCubit binContext;

  PickListsLineEntity? pickingLine;
  late PickListEntity picking;
  WarehouseEntity? warehouseEntity;

  @override
  void initState() {
    if (mounted) {
      whsContext = context.read<WarehouseCubit>();
      binContext = context.read<BinCubit>();
    }

    setState(() {
      picking = widget.picking;
    });
    super.initState();
  }

  void clear() {
    whs.clear();
    itemCode.clear();
    itemUoM.clear();
    openQty.clear();
    pickQty.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    log("----> didChangeDependencies");
    super.didChangeDependencies();
  }

  void onPressedItem(PickListsLineEntity entity) async {
    whs.text = entity.warehouseCode ?? "";
    itemCode.text = entity.itemCode ?? "";
    itemUoM.text = entity.uomCode ?? "";
    openQty.text = entity.releasedQuantity?.toString() ?? "";
    pickQty.text = entity.pickedQuantity?.toString() ?? "";

    goTo(
      context,
      PickingItemScreen(
        picking: widget.picking,
        lineEntity: entity,
      ),
    ).then((value) {
      if (value == null) return;

      setState(() {
        picking = value;
      });
    });
  }

  bool isEnableBin() {
    if (pickingLine == null) return true;
    if (warehouseEntity == null) return true;

    return !warehouseEntity!.isEnableBin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Picking / Entry ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Input(
                label: 'Pick List',
                placeholder: 'Pick List',
                readOnly: true,
                initialValue: widget.picking.absoluteentry.toString(),
                // controller: totalItem,
              ),
              Input(
                label: 'Whs Code',
                placeholder: 'Whs Code',
                readOnly: true,
                controller: whs,
              ),
              const SizedBox(height: 30),
              ContentHeader(),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: picking.pickListsLines
                            ?.map(
                              (item) => GestureDetector(
                                child: ItemRow(
                                  item: item,
                                  onTap: () => onPressedItem(item),
                                ),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
              ),
            ],
          ),
        ));
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
