import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscan_data_plugin/iscan_data_plugin.dart';
import 'package:wms_mobile/feature/list_batch/presentation/screen/batch_list_page.dart';
import 'package:wms_mobile/utilies/formart.dart';

import '../../form/datePicker.dart';
import '/component/button/button.dart';
import '/component/form/input.dart';
import '/helper/helper.dart';
import '/utilies/dialog/dialog.dart';

import '../../constant/style.dart';

class GoodReceiptBatchScreen extends StatefulWidget {
  const GoodReceiptBatchScreen({
    super.key,
    required this.itemCode,
    required this.quantity,
    this.serials,
    this.isEdit,
    this.listAllBatch,
  });

  final String quantity;
  final dynamic listAllBatch;
  final String itemCode;
  final List<dynamic>? serials;
  final dynamic isEdit;
  @override
  State<GoodReceiptBatchScreen> createState() => _GoodReceiptBatchScreenState();
}

class _GoodReceiptBatchScreenState extends State<GoodReceiptBatchScreen> {
  final itemCode = TextEditingController();
  final quantity = TextEditingController();
  final totalSerial = TextEditingController();
  final textSerial = TextEditingController();
  final quantityPerBatch = TextEditingController();
  DateTime? expDate;
  List<dynamic> items = [];
  int updateIndex = -1;

  @override
  void initState() {
    itemCode.text = widget.itemCode;
    quantity.text = widget.quantity;
    quantityPerBatch.text = widget.quantity;
    if (widget.isEdit >= 0) {
      setState(() {
        items = widget.serials ?? [];
      });
    } else {
      setState(() {
        items = [];
      });
    }

    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScanResults") {
        setState(() {
          if (call.arguments['data'] == "decode error") return;
          //
          textSerial.text = call.arguments['data'];
          // onEnterSerial();
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
    });

    super.initState();
  }

  void onEnterSerial() {
    try {
      if (textSerial.text == '') return;
      final index =
          items.indexWhere((e) => e['BatchNumber'] == textSerial.text);
      // Calculate the total added quantity so far
      int totalAddedQuantity = items.fold(
          0, (sum, item) => sum + double.parse(item['Quantity']).toInt());

      // Check if the current quantityPerBatch exceeds the remaining quantity
      int currentQuantity = double.parse(quantityPerBatch.text).toInt();
      if (currentQuantity <= 0) {
        throw Exception('Quantity must be greater than 0 on row $index.');
      }
      if (totalAddedQuantity + currentQuantity >
              double.parse(widget.quantity).toInt() &&
          updateIndex < 0) {
        throw Exception(
            'Quantity exceeds available. Remaining quantity is ${double.parse(widget.quantity).toInt() - totalAddedQuantity}.');
      }

      if (updateIndex < 0) {
        items.add({
          "BatchNumber": textSerial.text,
          "Quantity": quantityPerBatch.text,
          "ExpiryDate": expDate.toString()=="null" ? "": expDate.toString()
        });
      } else {
        final temps = [...items];

        temps[updateIndex] = {
          "BatchNumber": textSerial.text,
          "Quantity": quantityPerBatch.text,
          "ExpiryDate": expDate.toString() == "null" ? "" : expDate.toString()
        };
        items = temps;
        if (items.fold(
                    0,
                    (sum, item) =>
                        sum + double.parse(item['Quantity']).toInt()) >
                double.parse(widget.quantity).toInt() &&
            updateIndex >= 0) {
          updateIndex = -1;
          quantityPerBatch.text = widget.quantity;
          textSerial.text = "";
          items = [];
          throw Exception(
              'Quantity exceeds available. Remaining quantity is ${double.parse(widget.quantity).toInt() - totalAddedQuantity}.');
        }
      }

      totalSerial.text = items.length.toString();
      textSerial.text = "";
      quantityPerBatch.text = "";
      // quantity.text = "";
      setState(() {
        items;
        updateIndex = -1;
      });
      FocusScope.of(context).requestFocus(FocusNode());
    } catch (e) {
      FocusScope.of(context).requestFocus(FocusNode());
      MaterialDialog.success(context, title: 'Failed', body: e.toString());
    }
  }

  void onEditOrDelete(String serial) {
    List<dynamic> data = [...items];
    MaterialDialog.warning(
      context,
      body: 'Are you sure want to remove?',
      confirmLabel: 'Edit',
      onConfirm: () {
        final index = data.indexWhere((e) => e['BatchNumber'] == serial);

        updateIndex = index;

        if (index < 0) return;

        textSerial.text = items[index]['BatchNumber'];
        quantityPerBatch.text = items[index]['Quantity'];
        setState(() {
          updateIndex;
        });
      },
      cancelLabel: 'Remove',
      onCancel: () {
        data.removeWhere((e) => e['BatchNumber'] == serial);
        setState(() {
          items = data;
        });
      },
    );
  }

  void onComplete() {
    try {
      final qty = double.parse(quantity.text).toInt();

      if (qty == 0) {
        throw Exception("Quantity must be greater than 0.");
      }
      int totalAddedQuantity = items.fold(
          0, (sum, item) => sum + double.parse(item['Quantity']).toInt());
      if (totalAddedQuantity < qty) {
        throw Exception("Can't generate document without complete batch.");
      }
      Navigator.of(context)
          .pop({"items": items, "quantity": quantity.text, "expDate": expDate});
    } catch (e) {
      MaterialDialog.success(context, title: 'Failed', body: e.toString());
    }
  }

  void onNavigateBatchList() async {
    goTo(
        context,
        BatchListPage(
          itemCode: itemCode.text,
        )).then((value) async {
      if (value == null) return;

      for (var element in value) {
        items.add({
          "BatchNumber": element['Batch_Serial'] ?? "",
          "Quantity": element['PickQty'] ?? "0",
          "ExpiryDate": element["ExpDate"] ?? ""
        });
      }
      int totalAddedQuantity = items.fold(
          0, (sum, item) => sum + double.parse(item['Quantity']).toInt());
      if (totalAddedQuantity > double.parse(widget.quantity).toInt()) {
        items = [];
        MaterialDialog.success(context,
            title: 'Failed',
            body:
                'Quantity exceeds available. Remaining quantity is ${double.parse(widget.quantity).toInt() - totalAddedQuantity}.');
      }
      setState(() {
        items;
      });
    });
  }

  void _selectPostingDate(DateTime date) async {
    setState(() {
      expDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Batch',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size(context).height,
              maxHeight: size(context).height,
              minWidth: size(context).width,
              maxWidth: size(context).width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  label: 'Item.',
                  placeholder: 'Item',
                  readOnly: true,
                  controller: itemCode,
                  // onPressed: onSelectItem,
                ),
                Input(
                  controller: quantity,
                  label: 'Qty.',
                  placeholder: '0',
                  readOnly: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                Input(
                  controller: quantityPerBatch,
                  label: 'Alc.Bt',
                  placeholder: '0',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                Input(
                  controller: textSerial,
                  label: 'Batch.',
                  placeholder: 'Batch',
                  onPressed: () async {
                    if (widget.listAllBatch == null) return;
                    onNavigateBatchList();
                  },
                  icon: Icons.barcode_reader,
                  onEditingComplete: onEnterSerial,
                ),
                DatePicker(
                  title: "Expiry Date",
                  restorationId: 'main_date_picker',
                  req: 'true',
                  onDateSelected: _selectPostingDate,
                  defaultValue: expDate,
                ),
                const SizedBox(height: 12),
                // Text('Batch No.'),
                Button(
                  bgColor: Colors.green.shade700,
                  onPressed: onEnterSerial,
                  child: Text(
                    updateIndex == -1 ? "Add" : "Update",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ContentHeader(),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: items
                          .map((item) => GestureDetector(
                                onTap: () =>
                                    onEditOrDelete(item['BatchNumber']),
                                child: ItemRow(item: item),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size(context).height * 0.09,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Button(
                onPressed: onComplete,
                bgColor: Colors.green.shade900,
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Button(
                variant: ButtonVariant.outline,
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
              'Batch No.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('Qty')),
          Expanded(child: Text('Expiry')),
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
                  getDataFromDynamic(item['BatchNumber']),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Text(getDataFromDynamic(item['Quantity']))),
              Expanded(child: Text(splitDate2(item['ExpiryDate']) )),
            ],
          ),
          SizedBox(height: 6),
          // Text(getDataFromDynamic(item['ItemDescription']))
        ],
      ),
    );
  }
}
