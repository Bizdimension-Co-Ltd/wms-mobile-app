import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/item_by_code/presentation/screen/item_page.dart';
import 'package:wms_mobile/feature/warehouse/presentation/screen/warehouse_page.dart';
import 'package:wms_mobile/utilies/dio_client.dart';
import '/feature/batch/good_receip_batch_screen.dart';
import '/feature/serial/good_receip_serial_screen.dart';
import '/feature/bin_location/domain/entity/bin_entity.dart';
import '/feature/bin_location/presentation/screen/bin_page.dart';
import '../../../../core/error/failure.dart';
import '../../../item/presentation/cubit/item_cubit.dart';
import '/component/button/button.dart';
import '/component/form/input.dart';
import '/core/enum/global.dart';
import '/feature/item/presentation/screen/item_page.dart';
import '/feature/unit_of_measurement/domain/entity/unit_of_measurement_entity.dart';
import '/feature/unit_of_measurement/presentation/screen/unit_of_measurement_page.dart';
import '/helper/helper.dart';
import '/utilies/dialog/dialog.dart';
import '/utilies/storage/locale_storage.dart';
import 'package:iscan_data_plugin/iscan_data_plugin.dart';
import '../../../../constant/style.dart';
import 'cubit/quick_count_cubit.dart';

class CreateQuickCountScreen extends StatefulWidget {
  const CreateQuickCountScreen({super.key});

  @override
  State<CreateQuickCountScreen> createState() => _CreateQuickCountScreenState();
}

class _CreateQuickCountScreenState extends State<CreateQuickCountScreen> {
  final uomText = TextEditingController();
  final quantity = TextEditingController();
  final ref = TextEditingController();
  final warehouse = TextEditingController();
  final uom = TextEditingController();
  final uomAbEntry = TextEditingController();
  final itemCode = TextEditingController();
  final itemName = TextEditingController();
  final baseUoM = TextEditingController();
  final uoMGroupDefinitionCollection = TextEditingController();
  final binId = TextEditingController();
  final binCode = TextEditingController();

  final serialsInput = TextEditingController();
  final batchesInput = TextEditingController();
  final docEntry = TextEditingController();
  final refLineNo = TextEditingController();
  final inWhsQty = TextEditingController();

  //
  final isBatch = TextEditingController();
  final isSerial = TextEditingController();

  late QuickCountCubit _bloc;
  late ItemCubit _blocItem;
  final barCode = TextEditingController();
  final DioClient dio = DioClient();
  List<dynamic> itemCodeFilter = [];
  int isEdit = -1;
  bool isSerialOrBatch = false;
  List<dynamic> items = [];
  bool loading = false;

  @override
  void initState() {
    init();
    _bloc = context.read<QuickCountCubit>();
    _blocItem = context.read<ItemCubit>();

    //
    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      try {
        IscanDataPlugin.methodChannel
            .setMethodCallHandler((MethodCall call) async {
          if (call.method == "onScanResults") {
            if (loading) return;

            setState(() {
              if (call.arguments['data'] == "decode error") return;
              barCode.text = call.arguments['data'];
              onCompleteTextEditItem();
            });
          }
        });
      } catch (e) {
        print("Error setting method call handler: $e");
      }
    });
    super.initState();
  }

  void init() async {
    final whs = await LocalStorageManger.getString('warehouse');
    warehouse.text = whs;
  }

  void onSelectItem() async {
    setState(() {
      isEdit = -1;
    });
    goTo(context, ItemPage(type: ItemType.inventory)).then((value) {
      if (value == null) return;

      onSetItemTemp(value);
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

      if (itemCode.text == '') {
        throw Exception('Item is missing.');
      }

      final item = {
        "ItemCode": itemCode.text,
        "ItemDescription": itemName.text,
        "Quantity": quantity.text,
        "WarehouseCode": warehouse.text,
        "UoMEntry": uomAbEntry.text,
        "UoMCode": uom.text,
        "BaseEntry": docEntry.text,
        "BaseLine": refLineNo.text,
        "UoMGroupDefinitionCollection":
            jsonDecode(uoMGroupDefinitionCollection.text) ?? [],
        "BaseUoM": baseUoM.text,
        "BinId": binId.text,
        "BinCode": binCode.text,
        "InWhsQty": inWhsQty.text,
        "ManageSerialNumbers": isSerial.text,
        "ManageBatchNumbers": isBatch.text,
        "Serials":
            serialsInput.text == "" ? [] : jsonDecode(serialsInput.text) ?? [],
        "Batches":
            batchesInput.text == "" ? [] : jsonDecode(batchesInput.text) ?? [],
      };

      if (isEdit == -1) {
        data.add(item);
      } else {
        data[isEdit] = item;
      }
      clear();
      setState(() {
        items = data;
        isSerialOrBatch = false;
      });
    } catch (err) {
      if (err is Exception) {
        MaterialDialog.success(context, title: 'Warning', body: err.toString());
      }
    }
  }

  void onEdit(dynamic item, int index) {
    // final index = items.indexWhere((e) => e['ItemCode'] == item['ItemCode']);

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
        binCode.text = getDataFromDynamic(item['BinCode']);
        binId.text = getDataFromDynamic(item['BinId']);
        baseUoM.text = getDataFromDynamic(item['BaseUoM']);
        docEntry.text = getDataFromDynamic(item['DocEntry']);
        refLineNo.text = getDataFromDynamic(item['BaseLine']);
        uoMGroupDefinitionCollection.text = jsonEncode(
          item['UoMGroupDefinitionCollection'],
        );
        isSerial.text = getDataFromDynamic(item['ManageSerialNumbers']);
        isBatch.text = getDataFromDynamic(item['ManageBatchNumbers']);
        batchesInput.text = jsonEncode(item['Batches'] ?? []);
        serialsInput.text = jsonEncode(item['Serials'] ?? []);
        inWhsQty.text = getDataFromDynamic(item["InWhsQty"]);
        setState(() {
          isEdit = index;

          if (getDataFromDynamic(item['ManageSerialNumbers']) == 'tYES' ||
              getDataFromDynamic(item['ManageBatchNumbers']) == 'tYES') {
            isSerialOrBatch = true;
          }
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

  void onChangeBin() async {
    goTo(context, BinPage(warehouse: warehouse.text, itemCode: itemCode.text))
        .then((value) {
      if (value == null) return;

      binId.text = getDataFromDynamic((value as BinEntity).id);
      binCode.text = getDataFromDynamic(value.code);
      dio
          .get(
              "/sml.svc/ITEM?\$filter=ItemCode eq '${itemCode.text}' and WhsCode eq '${warehouse.text}' and BinCode eq '${binCode.text}'")
          .then((e) {
        final data = e.data["value"];
        if (data != null && data.isNotEmpty) {
          final onHandQty = data[0]["OnHandQty"] ?? 0;
          setState(() {
            if (onHandQty != null && onHandQty.toString().isNotEmpty) {
              inWhsQty.text = onHandQty.toString();
            } else {
              inWhsQty.text = "0";
            }
          });
        } else {
          setState(() {
            inWhsQty.text = "0";
          });
        }
      });
    });
  }

  void onChangeWhs() async {
    goTo(context, WarehousePage()).then((value) {
      if (value == null) return;
      warehouse.text = getDataFromDynamic(value);
    });
  }

  void onPostToSAP() async {
    try {
      MaterialDialog.loading(context);
      Map<String, dynamic> data = {
        // "BranchID": 1,
        "Reference2": ref.text,
        "InventoryPostingLines": items.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> item = entry.value;
          List<dynamic> inventoryPostingLineUoMs = [
            // {
            //   "LineNumber": index + 1,
            //   "ChildNumber": 1,
            //   "UoMCountedQuantity": item["Quantity"],
            //   "CountedQuantity": item["Quantity"],
            //   "UoMCode": item['UoMCode']
            // }
          ];

          bool isBatch = item['ManageBatchNumbers'] == 'tYES';
          bool isSerial = item['ManageSerialNumbers'] == 'tYES';

          if (isBatch || isSerial) {
            inventoryPostingLineUoMs = [];
          }

          return {
            "ItemCode": item['ItemCode'],
            "ItemDescription": item['ItemDescription'],
            "UoMCode": item['UoMCode'],
            "BinEntry": item["BinId"],
            "Price": 1,
            "Variance": double.parse(item["Quantity"]).toInt() -
                double.parse(item["InWhsQty"]).toInt(),
            "CountedQuantity": item["Quantity"],
            "WarehouseCode": warehouse.text,
            "InventoryPostingSerialNumbers":
                (item['Serials'] as List<dynamic>).map((b) {
              return {
                "InternalSerialNumber": b["InternalSerialNumber"],
                "Quantity": double.parse(item["Quantity"]).toInt() -
                            double.parse(item["InWhsQty"]).toInt() <
                        0
                    ? -1
                    : 1,
              };
            }).toList(),
            "InventoryPostingBatchNumbers":
                (item['Batches'] as List<dynamic>).map((b) {
              return {
                "BatchNumber": b["BatchNumber"],
                "Quantity": double.parse(item["Quantity"]).toInt() -
                    double.parse(item["InWhsQty"]).toInt(),
                "ExpiryDate": b["ExpiryDate"]
              };
            }).toList(),
            "InventoryPostingLineUoMs": inventoryPostingLineUoMs
          };
        }).toList(),
      };
      setState(() {
        print(data);
      });
      final response = await _bloc.post(data);
      if (mounted) {
        Navigator.of(context).pop();
        MaterialDialog.success(
          context,
          title: 'Successfully',
          body: "Quick Count - ${response['DocumentNumber']}.",
          onOk: () => Navigator.of(context).pop(),
        );
      }
      clear();
      setState(() {
        items = [];
      });
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
    quantity.text = '';
    binId.text = '';
    binCode.text = '';
    uom.text = '';
    uomAbEntry.text = '';
    isBatch.text = '';
    isSerial.text = '';
    docEntry.text = '';
    refLineNo.text = '';
    isEdit = -1;
    inWhsQty.text = "0";
  }

  void onSetItemTemp(dynamic value) {
    try {
      if (value == null) return;
      FocusScope.of(context).requestFocus(FocusNode());

      itemCode.text = getDataFromDynamic(value['ItemCode']);
      itemName.text = getDataFromDynamic(value['ItemName']);
      // quantity.text = '0';
      // uom.text = getDataFromDynamic(value['InventoryUOM'] ?? 'Manual');
      uomAbEntry.text = getDataFromDynamic(value['InventoryUoMEntry'] ?? '-1');
      baseUoM.text = jsonEncode(getDataFromDynamic(value['BaseUoM'] ?? '-1'));
      uoMGroupDefinitionCollection.text = jsonEncode(
        value['UoMGroupDefinitionCollection'] ?? [],
      );

      isSerial.text = getDataFromDynamic(value['ManageSerialNumbers']);
      isBatch.text = getDataFromDynamic(value['ManageBatchNumbers']);

      if (value['ManageSerialNumbers'] == 'tYES' ||
          value['ManageBatchNumbers'] == 'tYES') {
        setState(() {
          isSerialOrBatch = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // void onCompleteTextEditItem() async {
  //   try {
  //     if (itemCode.text == '') return;

  //     //
  //     MaterialDialog.loading(context);
  //     final item = await _blocItem.find("('${itemCode.text}')");
  //     if (getDataFromDynamic(item['PurchaseItem']) == '' ||
  //         getDataFromDynamic(item['PurchaseItem']) == 'tNO') {
  //       throw Exception('${itemCode.text} is not purchase item.');
  //     }
  //     if (mounted) {
  //       MaterialDialog.close(context);
  //     }

  //     onSetItemTemp(item);
  //   } catch (e) {
  //     if (mounted) {
  //       MaterialDialog.close(context);
  //       if (e is ServerFailure) {
  //         MaterialDialog.success(context, title: 'Failed', body: e.message);
  //       }
  //     }
  //   }
  // }
  void onCompleteTextEditItem() async {
    try {
      if (barCode.text == '') return;
      quantity.text = '';
      MaterialDialog.loading(context);
      final barcodeRes = await dio.get(
          "/sml.svc/WMS_ITEM_BARCODE?\$filter=contains(BarCode,'${barCode.text}')");
      if (barcodeRes.statusCode == 200) {
        if (barcodeRes.data["value"].length == 0) {
          if (barcodeRes.data["value"].length == 0) {
            MaterialDialog.close(
              context,
            );
            clear();
            MaterialDialog.success(context, title: 'Opps.', body: "No Item");
            return;
          }
        }
        if (barcodeRes.data["value"].length > 1) {
          for (var element in barcodeRes.data["value"]) {
            itemCodeFilter.add(element['ItemCode']);
          }
          goTo(
                  context,
                  ItemByCodePage(
                      type: ItemType.purchase,
                      itemCode: itemCodeFilter
                          .map((item) => "ItemCode eq '$item'")
                          .join(' or ')))
              .then((value) {
            if (value == null) return;
            if (mounted) {
              MaterialDialog.close(context);
            }
            uom.text =
                getDataFromDynamic(barcodeRes.data["value"]?[0]?["UomCode"]);
            uomAbEntry.text =
                getDataFromDynamic(barcodeRes.data["value"]?[0]?["UomEntry"]);
            onSetItemTemp(value);
          });
          return;
        }
        final item = await _blocItem
            .find("('${barcodeRes.data["value"]?[0]?["ItemCode"]}')");
        if (mounted) {
          MaterialDialog.close(context);
        }
        uom.text = getDataFromDynamic(barcodeRes.data["value"]?[0]?["UomCode"]);
        uomAbEntry.text =
            getDataFromDynamic(barcodeRes.data["value"]?[0]?["UomEntry"]);
        onSetItemTemp(item);
      }
    } catch (e) {
      if (mounted) {
        MaterialDialog.close(context);
        if (e is ServerFailure) {
          MaterialDialog.success(context, title: 'Failed', body: e.message);
        }
      }
    }
  }

  void onCompleteQuantiyInput() {
    FocusScope.of(context).requestFocus(FocusNode());
    onNavigateSerialOrBatch();
  }

  void onNavigateSerialOrBatch({bool force = false}) {
    // return;
    if (double.parse(inWhsQty.text).toInt() ==
        double.parse(quantity.text).toInt()) return;

    if (isSerial.text == 'tYES') {
      final serialList = serialsInput.text == "" || serialsInput.text == "null"
          ? []
          : jsonDecode(serialsInput.text) as List<dynamic>;

      if (force == false && (quantity.text == serialList.length.toString())) {
        return;
      }
      goTo(
        context,
        GoodReceiptSerialScreen(
            itemCode: itemCode.text,
            quantity: quantity.text,
            listAllSerial: double.parse(inWhsQty.text).toInt() <
                    double.parse(quantity.text).toInt()
                ? null
                : true,
            binCode: binCode.text,
            serials: serialList,
            isQuickCount: true,
            isEdit: isEdit),
      ).then((value) {
        if (value == null) return;

        quantity.text = value['quantity'] ?? "0";
        serialsInput.text = jsonEncode(value['items']);
      });
    } else if (isBatch.text == 'tYES') {
      final batches = batchesInput.text == "" || batchesInput.text == "null"
          ? []
          : jsonDecode(batchesInput.text) as List<dynamic>;
      goTo(
        context,
        GoodReceiptBatchScreen(
            itemCode: itemCode.text,
            quantity: quantity.text,
            isQuickCount: true,
            alcQty: double.parse(quantity.text).toInt() -
                double.parse(inWhsQty.text).toInt(),
            listAllBatch: double.parse(inWhsQty.text).toInt() <
                    double.parse(quantity.text).toInt()
                ? null
                : true,
            serials: batches,
            binCode: binCode.text,
            isEdit: isEdit),
      ).then((value) {
        if (value == null) return;
        quantity.text = value['quantity'] ?? "0";
        batchesInput.text = jsonEncode(value['items']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Create Quick Counting',
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
                onPressed: onChangeWhs,
              ),
              Input(
                controller: ref,
                label: 'Ref.',
                placeholder: 'Referance',
              ),
              Input(
                controller: itemCode,
                onEditingComplete: onCompleteTextEditItem,
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
                controller: binCode,
                label: 'Bin.',
                placeholder: 'Bin Location',
                onPressed: onChangeBin,
              ),
              Input(
                controller: inWhsQty,
                label: 'In Whs Qty.',
                placeholder: 'Total Qty',
                readOnly: true,
              ),
              Input(
                controller: quantity,
                label: 'Quantity.',
                placeholder: 'Quantity',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onEditingComplete: onCompleteQuantiyInput,
                onPressed: isSerialOrBatch
                    ? () {
                        onNavigateSerialOrBatch(force: true);
                      }
                    : null,
              ),
              const SizedBox(height: 40),
              ContentHeader(),
              Column(
                children: items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return GestureDetector(
                    onTap: () =>
                        onEdit(item, index), // Pass both item and index
                    child: ItemRow(item: item),
                  );
                }).toList(),
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
                disabled: isEdit != -1,
                onPressed: onPostToSAP,
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
                onPressed: () {
                  if (items.length > 0) {
                    MaterialDialog.warning(
                      context,
                      title: 'Warning',
                      body:
                          'Are you sure leave? once you pressed ok the data will be ereas.',
                      confirmLabel: 'Ok',
                      cancelLabel: 'Cancel',
                      onConfirm: () {
                        Navigator.of(context).pop();
                      },
                      onCancel: () {},
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
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
