import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/bin_location/presentation/screen/bin_page.dart';
import 'package:wms_mobile/feature/lookup/bin_lookup/presentation/cubit/binlocation_lookup_cubit.dart';
import 'package:wms_mobile/utilies/dio_client.dart';
import '../../../item/presentation/cubit/item_cubit.dart';
import '/component/button/button.dart';
import '/component/form/input.dart';
import '/core/enum/global.dart';
import '/feature/item/presentation/screen/item_page.dart';
import '/helper/helper.dart';
import '/utilies/dialog/dialog.dart';
import '/utilies/storage/locale_storage.dart';
import 'package:iscan_data_plugin/iscan_data_plugin.dart';
import '../../../../constant/style.dart';

class CreateBinLookUpScreen extends StatefulWidget {
  const CreateBinLookUpScreen({super.key});

  @override
  State<CreateBinLookUpScreen> createState() => _CreateBinLookUpScreenState();
}

class _CreateBinLookUpScreenState extends State<CreateBinLookUpScreen> {
  final warehouse = TextEditingController();
  final binCode = TextEditingController();
  late BinLookUpCubit _bloc;
  List<dynamic> items = [];
  bool loading = false;
  Map<String, dynamic> detailItem = {
    "MinQty": 0.0,
    "MaxQty": 0.0,
    "NoItem": 0,
    "ItemQty": 0.0,
    "NoBatch": 0,
    "NoSerial": 0
  };
  final DioClient dio = DioClient();

  @override
  void initState() {
    init();
    _bloc = context.read<BinLookUpCubit>();

    //
    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScanResults") {
        if (loading) return;

        setState(() {
          if (call.arguments['data'] == "decode error") return;
          //
          binCode.text = call.arguments['data'];
        });
      }
    });
    super.initState();
  }

  void init() async {
    final whs = await LocalStorageManger.getString('warehouse');
    warehouse.text = whs;
  }

  void onSelectItem() async {
    goTo(context, ItemPage(type: ItemType.inventory)).then((value) {
      if (value == null) return;

      onSetItemTemp(value);
    });
  }

  void onChangeBin() async {
    goTo(context, BinPage(warehouse: warehouse.text)).then((value) {
      if (value == null) return;

      binCode.text = getDataFromDynamic(value.code);
    });
  }

  void onGetItem() async {
    try {
      MaterialDialog.loading(context);
      final response = await _bloc
          .get({"binCode": binCode.text, "warehouseCode": warehouse.text});
      final binResponse = await dio.get(
          "/BinLocations?\$filter=Warehouse eq '${warehouse.text}' and BinCode eq '${binCode.text}' & \$select=MinimumQty,MaximumQty");
      if (binResponse.statusCode == 200) {
        if (mounted) {
          setState(() {
            print(binResponse);
            items = [];
            items.addAll(response["value"]);
            detailItem["MinQty"] = binResponse.data["value"]?[0]?["MinimumQty"];
            detailItem["MaxQty"] = binResponse.data["value"]?[0]?["MaximumQty"];
            detailItem["NoItem"] = response["value"].length;
            detailItem["ItemQty"] = response["value"]
                .fold(0.0, (sum, item) => sum + item['OnHandQty'] as double);
          });
        }
      }

      MaterialDialog.close(context);
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        MaterialDialog.success(context, title: 'Error', body: e.toString());
      }
    }
  }

  void clear() {
    binCode.text = '';
  }

  void onSetItemTemp(dynamic value) {
    try {
      if (value == null) return;
      FocusScope.of(context).requestFocus(FocusNode());
      binCode.text = getDataFromDynamic(value['BinCode']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Bin Lookup',
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
          child: Column(
            children: [
              Input(
                label: 'Warehouse',
                placeholder: 'Warehouse',
                controller: warehouse,
                readOnly: true,
                onPressed: () {},
              ),

              // Input(
              //   controller: binCode,
              //   label: 'Bin.',
              //   placeholder: 'Bin Location',
              //   onPressed: onSelectItem,
              // ),
              // Input(
              //   controller: itemName,
              //   label: 'Desc.',
              //   placeholder: 'Description',
              // ),
              Input(
                controller: binCode,
                label: 'Bin.',
                placeholder: 'Bin Location',
                onPressed: onChangeBin,
              ),
              items.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("Min. Qty")),
                                Text(
                                  "${detailItem["MinQty"]}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("Max. Qty")),
                                Text("${detailItem["MaxQty"]}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              items.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("No. Items")),
                                Text("${detailItem["NoItem"]}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("Items. Qty")),
                                Text("${detailItem["ItemQty"]}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              items.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("No. Batch")),
                                Text("${detailItem["NoBatch"]}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                SizedBox(width: 90, child: Text("No. Serial")),
                                Text("${detailItem["NoSerial"]}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 40),
              ContentHeader(),
              Column(
                children: items
                    .map((item) => GestureDetector(
                          // onTap: () => onEdit(item),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.1))),
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
                                    Expanded(
                                        child: Text(getDataFromDynamic(
                                            item['InvntryUom']))),
                                    Expanded(
                                        child: Text('${item['OnHandQty']}')),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(  
                                        getDataFromDynamic(item['ItemName']),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
     bottomNavigationBar: Container(
        height: size(context).height * 0.09,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Button(
                bgColor: Colors.green.shade900,
                variant: ButtonVariant.primary,
                onPressed: onGetItem,
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(child: Container()),
            Expanded(child: Container()),
            const SizedBox(width: 12),
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
              'Items.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('UoM')),
          Expanded(child: Text('Qty')),
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
