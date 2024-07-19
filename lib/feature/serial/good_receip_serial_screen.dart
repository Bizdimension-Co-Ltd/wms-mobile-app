import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/component/button/button.dart';
import '/component/form/input.dart';
import '/helper/helper.dart';
import '/utilies/dialog/dialog.dart';
import '../../constant/style.dart';
import 'package:iscan_data_plugin/iscan_data_plugin.dart';

class GoodReceiptSerialScreen extends StatefulWidget {
  const GoodReceiptSerialScreen({
    super.key,
    required this.itemCode,
    required this.quantity,
    this.serials,
  });

  final String quantity;
  final String itemCode;
  final List<dynamic>? serials;

  @override
  State<GoodReceiptSerialScreen> createState() =>
      _GoodReceiptSerialScreenState();
}

class _GoodReceiptSerialScreenState extends State<GoodReceiptSerialScreen> {
  final itemCode = TextEditingController();
  final quantity = TextEditingController();
  final totalSerial = TextEditingController();
  final textSerial = TextEditingController();
  int updateIndex = -1;

  List<dynamic> items = [];

  @override
  void initState() {
    itemCode.text = widget.itemCode;
    quantity.text = widget.quantity;
    final serials = widget.serials ?? [];
    totalSerial.text = serials.length.toString();
    setState(() {
      items = serials;
    });

    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScanResults") {
        setState(() {
          if (call.arguments['data'] == "decode error") return;
          //
          textSerial.text = call.arguments['data'];
          onEnterSerial();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    itemCode.dispose();
    quantity.dispose();
    totalSerial.dispose();
    textSerial.dispose();
  }

  void onEnterSerial() {
    try {
      if (textSerial.text == '') {
        FocusScope.of(context).requestFocus(FocusNode());
        return;
      }

      if (items.length >= int.parse(quantity.text)) {
        throw Exception(
            'Serial Number can not be greater than ${widget.quantity}.');
      }

      final index =
          items.indexWhere((e) => e['InternalSerialNumber'] == textSerial.text);

      if (index >= 0) {
        throw Exception('Duplicate serial on row $index');
      }

      items.add({"InternalSerialNumber": textSerial.text});
      totalSerial.text = items.length.toString();
      setState(() {
        items;
      });
    } catch (e) {
      MaterialDialog.success(context, title: 'Failed', body: e.toString());
    }
    textSerial.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onDelete(String serial) {
    List<dynamic> data = [...items];
    MaterialDialog.warning(
      context,
      body: 'Are you sure want to remove?',
      onConfirm: () {
        data.removeWhere((e) => e['InternalSerialNumber'] == serial);
        setState(() {
          items = data;
        });
      },
    );
  }

  void onComplete() {
    try {
      Navigator.of(context).pop({
        "items": items,
        "quantity": quantity.text,
      });
    } catch (e) {
      MaterialDialog.success(context, title: 'Failed', body: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'GRPO / Serialize',
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
                  placeholder: '0.00',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                Input(
                  controller: quantity,
                  label: 'Sn#..',
                  placeholder: '0.00',
                  readOnly: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                Input(
                  controller: totalSerial,
                  label: 'Alc.Sn',
                  placeholder: '0.00',
                  readOnly: true,
                ),
                Input(
                  controller: textSerial,
                  label: 'Serial.',
                  placeholder: 'Serial',
                  onPressed: () {},
                  icon: Icons.barcode_reader,
                  onEditingComplete: onEnterSerial,
                ),
                const SizedBox(height: 40),
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
                // Text('Serial No.'),
                const SizedBox(height: 12),
                ContentHeader(),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: items
                          .map((item) => GestureDetector(
                                onTap: () =>
                                    onDelete(item['InternalSerialNumber']),
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
              'Serial No.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Expanded(child: Text('Bin.')),
          // Expanded(child: Text('Qty/Op.')),
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
                  getDataFromDynamic(item['InternalSerialNumber']),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Expanded(child: Text(getDataFromDynamic(item['UoMCode']))),
              // Expanded(child: Text('${item['Quantity']}/0')),
            ],
          ),
          SizedBox(height: 6),
          // Text(getDataFromDynamic(item['ItemDescription']))
        ],
      ),
    );
  }
}
