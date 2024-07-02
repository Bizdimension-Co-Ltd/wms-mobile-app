import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wms_mobile/component/button/button.dart';
import 'package:wms_mobile/component/form/input.dart';
import 'package:wms_mobile/core/enum/global.dart';
import 'package:wms_mobile/feature/item/presentation/screen/item_page.dart';
import 'package:wms_mobile/feature/unit_of_measurement/domain/entity/unit_of_measurement_entity.dart';
import 'package:wms_mobile/feature/unit_of_measurement/presentation/screen/unit_of_measurement_page.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';

import '../../../../constant/style.dart';

class CreateGoodReceiptScreen extends StatefulWidget {
  const CreateGoodReceiptScreen({super.key, this.po = null});

  final dynamic po;

  @override
  State<CreateGoodReceiptScreen> createState() =>
      _CreateGoodReceiptScreenState();
}

class _CreateGoodReceiptScreenState extends State<CreateGoodReceiptScreen> {
  final poText = TextEditingController();
  final uomText = TextEditingController();
  final quantity = TextEditingController();
  final warehouse = TextEditingController();
  final uom = TextEditingController();
  final uomAbEntry = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();
  final baseUoM = TextEditingController();
  final uoMGroupDefinitionCollection = TextEditingController();

  int isEdit = -1;

  List<dynamic> items = [];
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final whs = await LocalStorageManger.getString('warehouse');
    warehouse.text = whs;

    if (widget.po != null) {
      poText.text = getDataFromDynamic(widget.po['DocNum']);
      setState(() {
        items = widget.po['DocumentLines'] ?? [];
      });
    }
  }

  void onSelectItem() async {
    setState(() {
      isEdit = -1;
    });
    goTo(context, ItemPage(type: ItemType.purchase)).then((value) {
      if (value == null) return;

      itemCode.text = getDataFromDynamic(value['ItemCode']);
      itemName.text = getDataFromDynamic(value['ItemName']);
      quantity.text = '0';
      uom.text = getDataFromDynamic(value['InventoryUOM']);
      uomAbEntry.text = getDataFromDynamic(value['InventoryUoMEntry']);
      baseUoM.text = jsonEncode(getDataFromDynamic(value['BaseUoM']));
      // log(value.toString());
      uoMGroupDefinitionCollection.text =
          jsonEncode(value['UoMGroupDefinitionCollection'] ?? []);
    });
  }

  void onChangeUoM() async {
    try {
      final data =
          jsonDecode(uoMGroupDefinitionCollection.text) as List<dynamic>;

      goTo(
              context,
              UnitOfMeasurementPage(
                  ids: data.map((e) => e['AlternateUoM'] as int).toList()))
          .then((value) {
        if (value == null) return;

        uom.text = (value as UnitOfMeasurementEntity).code;
        uomAbEntry.text = (value).id.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  void onAddItem({bool force = false}) {
    try {
      List<dynamic> data = [...items];

      final item = {
        "ItemCode": itemCode.text,
        "ItemDescription": itemName.text,
        "Quantity": quantity.text,
        "WarehouseCode": warehouse.text,
        "UoMEntry": uomAbEntry.text,
        "UoMCode": uom.text,
      };

      if (isEdit == -1) {
        // if (!force) {
        //   final exist = items.indexWhere((row) =>
        //       row['ItemCode'] == item['ItemCode'] &&
        //       row['UoMCode'] == item['UoMCode']);

        //   if (exist >= 0) {
        //     throw Exception('${item['ItemCode']} already exist.');
        //   }
        // }

        // throw Exception('${item['ItemCode']} already exist.');

        data.add(item);
      } else {
        data[isEdit] = item;
      }

      itemCode.text = '';
      itemName.text = '';
      quantity.text = '0';
      uom.text = '';
      uomAbEntry.text = '';
      isEdit = -1;

      setState(() {
        items = data;
      });
    } catch (err) {
      if (err is Exception) {
        MaterialDialog.warning(context, title: 'Warning', body: err.toString());
      }
    }
  }

  void onEdit(dynamic item) {
    final index = items.indexWhere((e) => e['ItemCode'] == item['ItemCode']);

    if (index < 0) return;

    MaterialDialog.warning(
      context,
      title: 'Item (${item['ItemCode']})',
      confirmLabel: "Edit",
      cancelLabel: "Remove",
      onConfirm: () {
        itemCode.text = getDataFromDynamic(item['ItemCode']);
        itemName.text = getDataFromDynamic(item['ItemDescription']);
        quantity.text = getDataFromDynamic(item['Quantity']);
        uom.text = getDataFromDynamic(item['UoMCode']);
        uomAbEntry.text = getDataFromDynamic(item['UoMEntry']);
        setState(() {
          isEdit = index;
        });
      },
      onCancel: () {
        List<dynamic> data = [...items];
        data.removeAt(index);
        setState(() {
          items = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Create Good Receipt',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(
              label: 'Warehouse',
              placeholder: 'Warehouse',
              controller: warehouse,
              readOnly: true,
              onPressed: () {},
            ),
            if (widget.po != null)
              Input(
                controller: poText,
                readOnly: true,
                label: 'PO. #',
                placeholder: 'PO DocNum',
                onPressed: () {},
              ),
            Input(
              controller: itemCode,
              label: 'Item.',
              placeholder: 'Item',
              onPressed: onSelectItem,
            ),
            Input(
              controller: uom,
              label: 'UoM.',
              placeholder: 'Unit Of Measurement',
              onPressed: onChangeUoM,
            ),
            Input(
              controller: quantity,
              label: 'Quantity.',
              placeholder: 'Quantity',
            ),
            const SizedBox(height: 40),
            Text('ITEMS'),
            const SizedBox(height: 12),
            ContentHeader(),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: items
                      .map((item) => GestureDetector(
                            onTap: () => onEdit(item),
                            child: ItemRow(item: item),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: size(context).height * 0.075,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Button(
                onPressed: onAddItem,
                bgColor: Colors.green.shade900,
                child: Text(
                  isEdit >= 0 ? 'Update' : 'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Button(
                variant: ButtonVariant.primary,
                onPressed: () {},
                child: Text(
                  'Finish',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                  ),
                ),
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
              'Item No.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('UoM')),
          Expanded(child: Text('Qty/Op.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  getDataFromDynamic(item['ItemCode']),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Text(getDataFromDynamic(item['UoMCode']))),
              Expanded(child: Text('${item['Quantity']}/0')),
            ],
          ),
          SizedBox(height: 6),
          Text(getDataFromDynamic(item['ItemDescription']))
        ],
      ),
    );
  }
}
