import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_mobile/injector.dart';
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
import 'cubit/product_lookup_cubit.dart';

class CreateProductLookUpScreen extends StatefulWidget {
  const CreateProductLookUpScreen({super.key});

  @override
  State<CreateProductLookUpScreen> createState() =>
      _CreateProductLookUpScreenState();
}

class _CreateProductLookUpScreenState extends State<CreateProductLookUpScreen> {
  final warehouse = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();

  late ProductLookUpCubit _bloc;
  late ItemCubit _blocItem;

  List<dynamic> items = [];
  bool loading = false;

  @override
  void initState() {
    init();
    _bloc = context.read<ProductLookUpCubit>();
    _blocItem = context.read<ItemCubit>();

    //
    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScanResults") {
        if (loading) return;

        setState(() {
          if (call.arguments['data'] == "decode error") return;
          //
          itemCode.text = call.arguments['data'];
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

  // void onChangeBin() async {
  //   goTo(context, BinPage(warehouse: warehouse.text)).then((value) {
  //     if (value == null) return;

  //     binId.text = getDataFromDynamic((value as BinEntity).id);
  //     binCode.text = getDataFromDynamic(value.code);
  //   });
  // }

  void onGetItem() async {
    try {
      MaterialDialog.loading(context);
      final response = await _bloc
          .get({"itemCode": itemCode.text, "warehouseCode": warehouse.text});
      if (mounted) {
        setState(() {
          items = [];
          items.addAll(response["value"]);
        });
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
    itemCode.text = '';
    itemName.text = '';
  }

  void onSetItemTemp(dynamic value) {
    try {
      if (value == null) return;
      FocusScope.of(context).requestFocus(FocusNode());
      itemCode.text = getDataFromDynamic(value['ItemCode']);
      itemName.text = getDataFromDynamic(value['ItemName']);
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
          'Product Lookup',
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

              Input(
                controller: itemCode,
                label: 'Item.',
                placeholder: 'Item',
                onPressed: onSelectItem,
              ),
              Input(
                controller: itemName,
                label: 'Desc.',
                placeholder: 'Description',
              ),
              // Input(
              //   controller: binCode,
              //   label: 'Bin.',
              //   placeholder: 'Bin Location',
              //   onPressed: onChangeBin,
              // ),

              const SizedBox(height: 40),
              ContentHeader(),
              Column(children: [
                GestureDetector(
                  // onTap: () => onEdit(item),
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.1))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "WH03-BIN-SYSTEM",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(child: Text("TON")),
                            Expanded(child: Text('5')),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        //Serial///////////////////////////
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: SvgPicture.asset(
                                  color: Color.fromARGB(235, 183, 184, 186),
                                  "images/svg/down_right.svg",
                                  width: size(context).width * 0.06,
                                  height: size(context).width * 0.06,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Container(
                                margin: EdgeInsets.only(top: 13),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color.fromARGB(255, 243, 243, 244),
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //     color: Color.fromARGB(255, 226, 229,
                                  //         233), // Change the color as needed
                                  //     width: 1.0, // Change the width as needed
                                  //   ),
                                  // ),
                                ),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Serial Info.",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Expiry",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Text("")),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 7, 5, 10),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: const [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Serial A000001.",
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text("3-10-2000",
                                                  style:
                                                      TextStyle(fontSize: 14)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Serial A000002.",
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text("1-10-2000",
                                                  style:
                                                      TextStyle(fontSize: 14)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Serial A000003.",
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text("2-20-2000",
                                                  style:
                                                      TextStyle(fontSize: 14)))
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        //Batch1111111111
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: SvgPicture.asset(
                                  color: Color.fromARGB(235, 183, 184, 186),
                                  "images/svg/down_right.svg",
                                  width: size(context).width * 0.06,
                                  height: size(context).width * 0.06,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Container(
                                margin: EdgeInsets.only(top: 13),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color.fromARGB(255, 243, 243, 244),
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //     color: Color.fromARGB(255, 226, 229,
                                  //         233), // Change the color as needed
                                  //     width: 1.0, // Change the width as needed
                                  //   ),
                                  // ),
                                ),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Batch Info.",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Expiry",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Qty",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Text("")),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Serial Info.",
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Text("3",
                                                  style:
                                                      TextStyle(fontSize: 14))),
                                          Expanded(
                                              flex: 2,
                                              child: Text("5",
                                                  style:
                                                      TextStyle(fontSize: 14)))
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        // //End11111111111111
                      ],
                    ),
                  ),
                ),
              ]),
              Column(
                children: items
                    .map((item) => GestureDetector(
                          // onTap: () => onEdit(item),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
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
                                        getDataFromDynamic(item['BinCode']),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(getDataFromDynamic(
                                            item['UoMCode']))),
                                    Expanded(
                                        child: Text('${item['OnHandQty']}')),
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
        color: Color.fromARGB(255, 237, 238, 238),
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
              'Bin Info.',
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
