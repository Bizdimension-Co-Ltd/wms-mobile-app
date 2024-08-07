import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/batch/good_receip_batch_screen.dart';
import 'package:wms_mobile/feature/serial/good_receip_serial_screen.dart';
import '/feature/bin_location/domain/entity/bin_entity.dart';
import '/feature/bin_location/presentation/screen/bin_page.dart';
import '/feature/business_partner/presentation/screen/business_partner_page.dart';
import '/feature/inbound/good_receipt_po/presentation/cubit/purchase_good_receipt_cubit.dart';
import '/feature/inbound/purchase_order/presentation/cubit/purchase_order_cubit.dart';
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

class CreateGoodReceiptScreen extends StatefulWidget {
  const CreateGoodReceiptScreen({super.key, this.po = null});

  final dynamic po;

  @override
  State<CreateGoodReceiptScreen> createState() =>
      _CreateGoodReceiptScreenState();
}

class _CreateGoodReceiptScreenState extends State<CreateGoodReceiptScreen> {
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

  //
  final isBatch = TextEditingController();
  final isSerial = TextEditingController();

  late PurchaseGoodReceiptCubit _bloc;
  late ItemCubit _blocItem;
  late PurchaseOrderCubit _blocCubit;

  int isEdit = -1;
  bool isSerialOrBatch = false;
  List<dynamic> items = [];
  bool loading = false;

  @override
  void initState() {
    init();
    _bloc = context.read<PurchaseGoodReceiptCubit>();
    _blocItem = context.read<ItemCubit>();
    _blocCubit = context.read<PurchaseOrderCubit>();

    //
    IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScanResults") {
        if (loading) return;

        setState(() {
          if (call.arguments['data'] == "decode error") return;
          //
          itemCode.text = call.arguments['data'];
          onCompleteTextEditItem();
        });
      }
    });
    super.initState();
  }

  void init() async {
    final whs = await LocalStorageManger.getString('warehouse');
    warehouse.text = whs;

    if (widget.po != null) {
      poText.text = getDataFromDynamic(widget.po['DocNum']);
      cardCode.text = getDataFromDynamic(widget.po['CardCode']);
      cardName.text = getDataFromDynamic(widget.po['CardName']);

      if (mounted) MaterialDialog.loading(context);

      items = [];
      for (var element in widget.po['DocumentLines']) {
        final itemResponse = await _blocItem.find("('${element['ItemCode']}')");

        items.add({
          "ItemCode": element['ItemCode'],
          "ItemDescription": element['ItemName'] ?? element['ItemDescription'],
          "Quantity": getDataFromDynamic(element['RemainingOpenQuantity']),
          "WarehouseCode": warehouse.text,
          "UoMEntry": getDataFromDynamic(element['UoMEntry']),
          "UoMCode": element['UoMCode'],
          "UoMGroupDefinitionCollection":
              itemResponse['UoMGroupDefinitionCollection'],
          "BaseUoM": itemResponse['BaseUoM'],
          "BinId": binId.text,
        });
      }

      if (mounted) MaterialDialog.close(context);

      setState(() {
        items;
      });
    }
  }

  void onSelectItem() async {
    setState(() {
      isEdit = -1;
    });
    goTo(context, ItemPage(type: ItemType.purchase)).then((value) {
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

      if (binId.text == '') {
        throw Exception('Bin Location is missing.');
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
        "UoMCode": uom.text,
        "UoMGroupDefinitionCollection":
            jsonDecode(uoMGroupDefinitionCollection.text) ?? [],
        "BaseUoM": baseUoM.text,
        "BinId": binId.text,
        "BinCode": binCode.text,
        "ManageSerialNumbers": isSerial.text,
        "ManageBatchNumbers": isBatch.text,
        "Serials":
            serialsInput.text == "" ? [] : jsonDecode(serialsInput.text) ?? [],
        "Batches":
            batchesInput.text == "" ? [] : jsonDecode(batchesInput.text) ?? [],
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

  void onEdit(dynamic item) {
    final index = items.indexWhere((e) => e['ItemCode'] == item['ItemCode']);

    if (index < 0) return;

    MaterialDialog.warning(
      context,
      title: 'Item (${item['ItemCode']})',
      confirmLabel: "Edit",
      cancelLabel: "Remove",
      onConfirm: () {
        print(item);
        itemCode.text = getDataFromDynamic(item['ItemCode']);
        itemName.text = getDataFromDynamic(item['ItemDescription']);
        quantity.text = getDataFromDynamic(item['Quantity']);
        uom.text = getDataFromDynamic(item['UoMCode']);
        uomAbEntry.text = getDataFromDynamic(item['UoMEntry']);
        binCode.text = getDataFromDynamic(item['BinCode']);
        binId.text = getDataFromDynamic(item['BinId']);
        baseUoM.text = getDataFromDynamic(item['BaseUoM']);
        uoMGroupDefinitionCollection.text = jsonEncode(
          item['UoMGroupDefinitionCollection'],
        );
        isSerial.text = getDataFromDynamic(item['ManageSerialNumbers']);
        isBatch.text = getDataFromDynamic(item['ManageBatchNumbers']);
        batchesInput.text = jsonEncode(item['Batches'] ?? []);
        serialsInput.text = jsonEncode(item['Serials'] ?? []);

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
    goTo(context, BinPage(warehouse: warehouse.text)).then((value) {
      if (value == null) return;

      binId.text = getDataFromDynamic((value as BinEntity).id);
      binCode.text = getDataFromDynamic(value.code);
    });
  }

  void onPostToSAP() async {
    try {
      Map<String, dynamic> data = {
        "BPL_IDAssignedToInvoice": 1,
        "CardCode": cardCode.text,
        "CardName": cardName.text,
        "WarehouseCode": warehouse.text,
        "DocumentLines": items.map((item) {
          List<dynamic> uomCollections =
              item["UoMGroupDefinitionCollection"] ?? [];

          final alternativeUoM = uomCollections.singleWhere(
            (row) => row['AlternateUoM'] == int.parse(item['UoMEntry']),
          );

          int baseType = -1;
          dynamic baseEntry = null;
          dynamic baseLine = null;
          if (widget.po != null) {
            final lines = (widget.po['DocumentLines'] ?? []) as List<dynamic>;
            final ele =
                lines.singleWhere((row) => row['ItemCode'] == item['ItemCode']);

            if (ele != null) {
              baseType = 22;
              baseEntry = ele['DocEntry'];
              baseLine = ele['LineNum'];
            }
          }

          List<dynamic> binAllocations = [
            {
              "Quantity": convertQuantityUoM(
                alternativeUoM['BaseQuantity'],
                alternativeUoM['AlternateQuantity'],
                double.tryParse(item['Quantity']) ?? 0.00,
              ),
              "BinAbsEntry": item['BinId'],
              "BaseLineNumber": 0,
              "AllowNegativeQuantity": "tNO",
              "SerialAndBatchNumbersBaseLine": -1
            }
          ];

          bool _isBatch = item['ManageBatchNumbers'] == 'tYES';
          bool _isSerial = item['ManageSerialNumbers'] == 'tYES';

          if (_isBatch || _isSerial) {
            binAllocations = [];

            List<dynamic> batchOrSerialLines =
                _isSerial ? item['Serials'] : item['Batches'];

            int index = 0;
            for (var element in batchOrSerialLines) {
              binAllocations.add({
                "BinAbsEntry": item['BinId'],
                "AllowNegativeQuantity": "tNO",
                "BaseLineNumber": 0,
                "SerialAndBatchNumbersBaseLine": index,
                "Quantity": convertQuantityUoM(alternativeUoM['BaseQuantity'],
                    alternativeUoM['AlternateQuantity'], 1),
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
            "BaseType": baseType,
            "BaseEntry": baseEntry,
            "BaseLine": baseLine,
            "SerialNumbers": item['Serials'] ?? [],
            "BatchNumbers": item['Batches'] ?? [],
            "DocumentLinesBinAllocations": binAllocations
          };
        }).toList(),
      };

      if (widget.po != null) {
        data['DocumentReferences'] = [
          {
            "RefDocEntr": widget.po['DocEntry'],
            "RefDocNum": widget.po['DocNum'],
            "RefObjType": "rot_PurchaseOrder",
            "IssueDate": DateTime.now().toIso8601String(),
            "Remark": "WMS",
          }
        ];
      }
      MaterialDialog.loading(context);

      final response = await _bloc.post(data);
      if (mounted) {
        if (widget.po != null) {
          _blocCubit.remove(widget.po['DocEntry']);
        }
        Navigator.of(context).pop();
        MaterialDialog.success(
          context,
          title: 'Successfully',
          body: "Good Receipt - ${response['DocNum']}.",
          onOk: () => Navigator.of(context)
              .pop(widget.po == null ? null : widget.po['DocEntry']),
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
    quantity.text = '0';
    binId.text = '';
    binCode.text = '';
    uom.text = '';
    uomAbEntry.text = '';
    isBatch.text = '';
    isSerial.text = '';
    isEdit = -1;
  }

  void onSetItemTemp(dynamic value) {
    try {
      if (value == null) return;
      FocusScope.of(context).requestFocus(FocusNode());

      itemCode.text = getDataFromDynamic(value['ItemCode']);
      itemName.text = getDataFromDynamic(value['ItemName']);
      quantity.text = '0';
      uom.text = getDataFromDynamic(value['InventoryUOM'] ?? 'Manual');
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
    } catch (e) {
      print(e);
    }
  }

  void onCompleteTextEditItem() async {
    try {
      if (itemCode.text == '') return;

      //
      MaterialDialog.loading(context);
      final item = await _blocItem.find("('${itemCode.text}')");
      if (getDataFromDynamic(item['PurchaseItem']) == '' ||
          getDataFromDynamic(item['PurchaseItem']) == 'tNO') {
        throw Exception('${itemCode.text} is not purchase item.');
      }
      if (mounted) {
        MaterialDialog.close(context);
      }

      onSetItemTemp(item);
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
        ),
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
        ),
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
                  label: 'Supplier Code',
                  placeholder: 'Supplier Code',
                  controller: cardCode,
                  readOnly: true,
                  onPressed: onChangeCardCode,
                ),
                Input(
                  label: 'Supplier Name',
                  placeholder: 'Supplier Name',
                  controller: cardName,
                  readOnly: true,
                  onPressed: () {},
                ),
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
