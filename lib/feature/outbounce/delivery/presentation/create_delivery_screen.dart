import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/inbound/good_receipt_po/presentation/duplicateItem_GPO_Screen.dart';
import 'package:wms_mobile/feature/item_by_code/presentation/screen/item_page.dart';
import 'package:wms_mobile/feature/outbounce/delivery/presentation/cubit/delivery_cubit.dart';
import 'package:wms_mobile/feature/outbounce/sale_order/presentation/sale_order_page.dart';
import 'package:wms_mobile/feature/warehouse/presentation/screen/warehouse_page.dart';
import 'package:wms_mobile/utilies/dio_client.dart';
import '/feature/batch/good_receip_batch_screen.dart';
import '/feature/serial/good_receip_serial_screen.dart';
import '/feature/bin_location/domain/entity/bin_entity.dart';
import '/feature/bin_location/presentation/screen/bin_page.dart';
import '/feature/business_partner/presentation/screen/business_partner_page.dart';
import '../../../../core/error/failure.dart';
import '../../../item/presentation/cubit/item_cubit.dart';
import '/component/button/button.dart';
import '/component/form/input.dart';
import '/core/enum/global.dart';
import '/feature/unit_of_measurement/domain/entity/unit_of_measurement_entity.dart';
import '/feature/unit_of_measurement/presentation/screen/unit_of_measurement_page.dart';
import '/helper/helper.dart';
import '/utilies/dialog/dialog.dart';
import '/utilies/storage/locale_storage.dart';
// import 'package:iscan_data_plugin/iscan_data_plugin.dart';
import '../../../../constant/style.dart';

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({super.key});

  @override
  State<CreateDeliveryScreen> createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  final cardCode = TextEditingController();
  final cardName = TextEditingController();
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
  final binId = TextEditingController();
  final binCode = TextEditingController();
  final serialsInput = TextEditingController();
  final batchesInput = TextEditingController();
  final docEntry = TextEditingController();
  final refLineNo = TextEditingController();
  final totalQty = TextEditingController();
  List<dynamic> isBin = [{}];
  //
  final isBatch = TextEditingController();
  final isSerial = TextEditingController();
  final DioClient dio = DioClient();
  List<dynamic> itemCodeFilter = [];
  final barCode = TextEditingController();
  late DeliveryCubit _bloc;
  late ItemCubit _blocItem;

  int isEdit = -1;
  bool isSerialOrBatch = false;
  List<dynamic> items = [];
  List<dynamic> baseEntry = [];
  bool loading = false;

  @override
  void initState() {
    init();
    _bloc = context.read<DeliveryCubit>();
    _blocItem = context.read<ItemCubit>();

    //
    // IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
    //   if (call.method == "onScanResults") {
    //     if (loading) return;

    //     setState(() {
    //       if (call.arguments['data'] == "decode error") return;
    //       //
    //       barCode.text = call.arguments['data'];
    //       onCompleteTextEditItem();
    //     });
    //   }
    // });
    super.initState();
  }

  void init() async {
    final whs = await LocalStorageManger.getString('warehouse');
    warehouse.text = whs;
  }

  void onSelectItem() async {
    if (cardCode.text == "") return;
    setState(() {
      isEdit = -1;
    });
    goTo(
            context,
            ItemByCodePage(
                type: ItemType.sale,
                itemCode: itemCodeFilter
                    .map((item) => "ItemCode eq '$item'")
                    .join(' or ')))
        .then((value) {
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

      if (quantity.text == '' || quantity.text == '0') {
        throw Exception('Quantity must be greater than zero.');
      }

      final item = {
        "ItemCode": itemCode.text,
        "ItemDescription": itemName.text,
        "Quantity": quantity.text,
        "WarehouseCode": warehouse.text,
        "UoMEntry": uomAbEntry.text,
        "DocEntry": docEntry.text,
        "UoMCode": uom.text,
        "UoMGroupDefinitionCollection":
            jsonDecode(uoMGroupDefinitionCollection.text) ?? [],
        "BaseUoM": baseUoM.text,
        "TotalQuantity": totalQty.text,
        "BinId": binId.text,
        "BinCode": binCode.text,
        "ManageSerialNumbers": isSerial.text,
        "ManageBatchNumbers": isBatch.text,
        "Serials":
            serialsInput.text == "" ? [] : jsonDecode(serialsInput.text) ?? [],
        "Batches":
            batchesInput.text == "" ? [] : jsonDecode(batchesInput.text) ?? [],
        "BarCode": barCode.text,
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

      // print(item);

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

  void onEdit(dynamic item, index) {
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
        totalQty.text = getDataFromDynamic(item['TotalQuantity']);
        uoMGroupDefinitionCollection.text = jsonEncode(
          item['UoMGroupDefinitionCollection'],
        );
        isSerial.text = getDataFromDynamic(item['ManageSerialNumbers']);
        isBatch.text = getDataFromDynamic(item['ManageBatchNumbers']);
        batchesInput.text = jsonEncode(item['Batches'] ?? []);
        serialsInput.text = jsonEncode(item['Serials'] ?? []);
        barCode.text = getDataFromDynamic(item['BarCode']);
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

  void onChangeCardCode() async {
    goTo(context, BusinessPartnerPage(type: BusinessPartnerType.supplier))
        .then((value) {
      if (value == null) return;

      cardCode.text = getDataFromDynamic(value['CardCode']);
      cardName.text = getDataFromDynamic(value['CardName']);
    });
  }

  void onChangeBin() async {
    goTo(context, BinPage(warehouse: warehouse.text, itemCode: itemCode.text))
        .then((value) {
      if (value == null) return;

      binId.text = getDataFromDynamic((value as BinEntity).id);
      binCode.text = getDataFromDynamic(value.code);
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
      if (poText.text == '') {
        throw Exception(
            "You can only perform action with Return Receipt Request Document.");
      }

      Map<String, dynamic> data = {
        "CardCode": cardCode.text,
        "CardName": cardName.text,
        "WarehouseCode": warehouse.text,
        "DocumentLines": items.asMap().entries.map((entry) {
          int parentIndex = entry.key;
          Map<String, dynamic> item = entry.value;
          List<dynamic> uomCollections =
              item["UoMGroupDefinitionCollection"] ?? [];

          final alternativeUoM = uomCollections.firstWhere(
            (row) => row['AlternateUoM'] == int.parse(item['UoMEntry']),
            orElse: () => null, // Provide a default value if not found
          );

          if (alternativeUoM == null) {
            throw Exception(
                "No matching UoM found for item ${item['ItemCode']}");
          }

          List<dynamic> binAllocations = [
            {
              "Quantity": convertQuantityUoM(
                alternativeUoM['BaseQuantity'],
                alternativeUoM['AlternateQuantity'],
                double.tryParse(item['Quantity']) ?? 0.00,
              ),
              "BinAbsEntry": item['BinId'],
              "BaseLineNumber": parentIndex,
              "AllowNegativeQuantity": "tNO",
              "SerialAndBatchNumbersBaseLine": -1
            }
          ];

          bool isBatch = item['ManageBatchNumbers'] == 'tYES';
          bool isSerial = item['ManageSerialNumbers'] == 'tYES';

          if (isBatch || isSerial) {
            binAllocations = [];

            List<dynamic> batchOrSerialLines =
                isSerial ? item['Serials'] : item['Batches'];

            int index = 0;
            for (var element in batchOrSerialLines) {
              binAllocations.add({
                "BinAbsEntry": item['BinId'],
                "AllowNegativeQuantity": "tNO",
                "BaseLineNumber": parentIndex,
                "SerialAndBatchNumbersBaseLine": index,
                "Quantity": convertQuantityUoM(
                    alternativeUoM['BaseQuantity'],
                    alternativeUoM['AlternateQuantity'],
                    double.tryParse(element["Quantity"]) ?? 0.00),
              });

              index++;
            }
          }

          return {
            "ItemCode": item['ItemCode'],
            "ItemDescription": item['ItemDescription'],
            "UoMCode": item['UoMCode'],
            "UoMEntry": item['UoMEntry'],
            "Quantity": item['Quantity'],
            "WarehouseCode": warehouse.text,
            "BaseType": 17, // sale order object
            "BaseEntry": item['DocEntry'],
            "BaseLine": parentIndex,
            "SerialNumbers": item['Serials'] ?? [],
            "BatchNumbers": item['Batches'] ?? [],
            "DocumentLinesBinAllocations":
                isBin.length > 0 ? binAllocations : []
          };
        }).toList(),
      };

      final response = await _bloc.post(data);
      if (mounted) {
        Navigator.of(context).pop();
        MaterialDialog.success(
          context,
          title: 'Successfully',
          body: "Return Receipt - ${response['DocNum']}.",
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
  }

  void onSetItemTemp(dynamic value) async {
    try {
      if (value == null) return;
      MaterialDialog.loading(context);
      FocusScope.of(context).requestFocus(FocusNode());
      final bin = await dio
          .get("/BinLocations?\$filter=Warehouse eq '${warehouse.text}'");
      if (bin.data["value"].length == 0) {
        isBin.clear();
      }
      ;
      itemCode.text = getDataFromDynamic(value['ItemCode']);
      itemName.text = getDataFromDynamic(value['ItemName']);
      // quantity.text = '0';
      // uom.text = getDataFromDynamic(value['InventoryUOM'] ?? 'Manual');
      uomAbEntry.text = getDataFromDynamic(value['InventoryUoMEntry'] ?? '-1');
      baseUoM.text = jsonEncode(getDataFromDynamic(value['BaseUoM'] ?? '-1'));
      // log(value.toString());
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
      if (mounted) {
        MaterialDialog.close(context);
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
      quantity.text = "";
      final duplicateItem =
          items.where((e) => e["BarCode"] == barCode.text).toList();
      if (duplicateItem.isEmpty) {
        MaterialDialog.success(context, title: 'Opps.', body: "Item not found");
        return;
      }
      if (duplicateItem.length > 1) {
        goTo(
            context,
            DuplicateItemGPOPage(
              barCode: barCode.text,
              items: duplicateItem,
            )).then((item) {
          if (item == null) return;
          final index = items.indexWhere((e) =>
              e['BarCode'] == item['BarCode'] &&
              e['ItemCode'] == item['ItemCode']);
          onEdit(item, index);
        });

        return;
      }
      // Continue processing if there is only one matching item
      final item = await items.firstWhere((e) => e["BarCode"] == barCode.text);
      final index = items.indexWhere((e) => e['BarCode'] == item['BarCode']);
      onEdit(item, index);
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
            serials: serialList,
            isEdit: isEdit,
            listAllSerial: true,
            binCode: binCode.text),
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
            serials: batches,
            isEdit: isEdit,
            listAllBatch: true,
            binCode: binCode.text),
      ).then((value) {
        if (value == null) return;
        quantity.text = value['quantity'] ?? "0";
        batchesInput.text = jsonEncode(value['items']);
      });
    }
  }

  void onNavigateToSO() async {
    goTo(context, SaleOrderPage()).then((value) async {
      if (value == null) return;

      cardCode.text = getDataFromDynamic(value['CardCode']);
      cardName.text = getDataFromDynamic(value['CardName']);
      poText.text = getDataFromDynamic(value['DocNum']);

      // if (mounted) MaterialDialog.loading(context);

      // items = [];
      // itemCodeFilter = [];

      // for (var element in value['DocumentLines']) {
      //   final itemResponse = await _blocItem.find("('${element['ItemCode']}')");

      //   items.add({
      //     "DocEntry": element['DocEntry'],
      //     "BaseEntry": element['DocEntry'],
      //     "BaseLine": element['LineNum'],
      //     "ItemCode": element['ItemCode'],
      //     "ItemDescription": element['ItemName'] ?? element['ItemDescription'],
      //     "TotalQuantity": getDataFromDynamic(element['Quantity']),
      //     "Quantity": "0",
      //     "WarehouseCode": warehouse.text,
      //     "UoMEntry": getDataFromDynamic(element['UoMEntry']),
      //     "UoMCode": element['UoMCode'],
      //     "UoMGroupDefinitionCollection":
      //         itemResponse['UoMGroupDefinitionCollection'],
      //     "BaseUoM": itemResponse['BaseUoM'],
      //     "BinId": binId.text,
      //     "ManageSerialNumbers": itemResponse["ManageSerialNumbers"],
      //     "ManageBatchNumbers": itemResponse["ManageBatchNumbers"],
      //     "BarCode": element['BarCode'],
      //   });
      //   baseEntry.add({
      //     "BaseEntry": element['DocEntry'],
      //     "ItemCode": element['ItemCode'],
      //   });
      //   // await Future.delayed(Duration(seconds: 1));
      //   itemCodeFilter.add(element['ItemCode']);
      // }

      // if (mounted) MaterialDialog.close(context);

      // setState(() {
      //   items;
      // });
      // Show loading indicator
      if (mounted) MaterialDialog.loading(context);
      final bin = await dio
          .get("/BinLocations?\$filter=Warehouse eq '${warehouse.text}'");
      if (bin.data["value"].length == 0) {
        isBin.clear();
      }
      // Initialize the list of items
      List<Map<String, dynamic>> rawItems = [];

      for (var element in value['DocumentLines']) {
        final itemResponse = await _blocItem.find("('${element['ItemCode']}')");

        rawItems.add({
          "DocEntry": element['DocEntry'],
          "BaseEntry": element['DocEntry'],
          "ItemCode": element['ItemCode'],
          "ItemDescription": element['ItemName'] ?? element['ItemDescription'],
          "Quantity": "0",
          "TotalQuantity": getDataFromDynamic(element['Quantity']),
          "WarehouseCode": warehouse.text,
          "UoMEntry": getDataFromDynamic(element['UoMEntry']),
          "UoMCode": element['UoMCode'],
          "UoMGroupDefinitionCollection":
              itemResponse.uoMGroupDefinitionCollection,
          "BaseUoM": itemResponse.inventoryUOM,
          "BinId": binId.text,
          "ManageSerialNumbers": itemResponse.isManageSerial,
          "ManageBatchNumbers": itemResponse.isManageBatch,
          "BarCode": element['BarCode'],
        });
        baseEntry.add({
          "BaseEntry": element['DocEntry'],
          "ItemCode": element['ItemCode'],
        });
        itemCodeFilter.add(element['ItemCode']);
      }

      // Combine items with the same ItemCode and UoMCode
      items = combineItems(rawItems);

      // Close loading indicator
      if (mounted) MaterialDialog.close(context);

      // Update state with combined items
      if (mounted) {
        setState(() {
          items;
        });
      }
    });
  }

  List<Map<String, dynamic>> combineItems(List<Map<String, dynamic>> rawItems) {
    Map<String, Map<String, dynamic>> combinedItemsMap = {};

    for (var item in rawItems) {
      // Convert quantity to double
      double quantity =
          double.tryParse(item["TotalQuantity"].toString()) ?? 0.0;

      String key = '${item["ItemCode"]}_${item["UoMCode"]}';

      if (combinedItemsMap.containsKey(key)) {
        // Add to the existing quantity
        combinedItemsMap[key]!["TotalQuantity"] =
            (combinedItemsMap[key]!["TotalQuantity"] as double) + quantity;
      } else {
        // Add a new item
        combinedItemsMap[key] = {
          "DocEntry": item['DocEntry'],
          "BaseEntry": item['DocEntry'],
          "ItemCode": item["ItemCode"],
          "ItemDescription": item["ItemDescription"],
          "Quantity": "0",
          "TotalQuantity": quantity,
          "WarehouseCode": item["WarehouseCode"],
          "UoMEntry": item["UoMEntry"],
          "UoMCode": item["UoMCode"],
          "UoMGroupDefinitionCollection": item["UoMGroupDefinitionCollection"],
          "BaseUoM": item["BaseUoM"],
          "BinId": item["BinId"],
          "ManageSerialNumbers": item["ManageSerialNumbers"],
          "ManageBatchNumbers": item["ManageBatchNumbers"],
          "BarCode": item['BarCode'],
        };
      }
    }

    return combinedItemsMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Create Delivery',
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
                  controller: poText,
                  readOnly: true,
                  label: 'SO. #',
                  placeholder: 'DocNum',
                  onPressed: onNavigateToSO,
                ),
                Input(
                  controller: cardCode,
                  readOnly: true,
                  label: 'Customer Code',
                  placeholder: 'Customer Code',
                ),
                Input(
                  controller: cardName,
                  readOnly: true,
                  label: 'Customer Name',
                  placeholder: 'Customer Name',
                ),
                Input(
                  label: 'Warehouse',
                  placeholder: 'Warehouse',
                  controller: warehouse,
                  readOnly: true,
                  onPressed: onChangeWhs,
                ),
                const SizedBox(height: 20),
                Text(''),
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
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
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

class ItemRow extends StatefulWidget {
  const ItemRow({super.key, required this.item, this.po});
  final dynamic po;
  final dynamic item;

  @override
  _ItemRowState createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  getDataFromDynamic(widget.item['ItemCode']),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text(getDataFromDynamic(widget.item['UoMCode'])),
              ),
              Expanded(
                  child: Text(
                '${getDataFromDynamic(widget.item['TotalQuantity'])}/${widget.item['Quantity']}',
              )),
            ],
          ),
          SizedBox(height: 6),
          Text(getDataFromDynamic(widget.item['ItemDescription'])),
        ],
      ),
    );
  }
}
