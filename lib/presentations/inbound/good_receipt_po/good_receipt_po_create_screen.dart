import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wms_mobile/component/flex_two_field.dart';
import 'package:wms_mobile/form/goodReceiptTypeSelect.dart';
import 'package:wms_mobile/form/itemSelect.dart';
import 'package:wms_mobile/form/warehouseSelect.dart';
import 'package:wms_mobile/injector.dart';
import 'package:wms_mobile/presentations/inbound/good_receipt_po/component/list_to_do_item.dart';
import 'package:wms_mobile/presentations/inventory/component/uomSelect.dart';
import 'package:wms_mobile/presentations/inventory/good_receipt/component/binlocationSelect.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class GoodReceiptPOCreateScreen extends StatefulWidget {
  GoodReceiptPOCreateScreen({super.key, required this.data});
  Map<String, dynamic> data;
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<GoodReceiptPOCreateScreen> createState() =>
      _GoodReceiptPOCreateScreenState();
}

class _GoodReceiptPOCreateScreenState extends State<GoodReceiptPOCreateScreen> {
  // start form field

  TextEditingController whs = TextEditingController();
  TextEditingController poNumber = TextEditingController(text: "1234");
  TextEditingController item = TextEditingController();
  TextEditingController uom = TextEditingController();
  TextEditingController bin = TextEditingController();

  TextEditingController qty = TextEditingController();
  // Map<String, dynamic> _warehouse = {};
  Map<String, dynamic> _item = {};
  Map<String, dynamic> _uoMCode = {};
  Map<String, dynamic> _bin = {};
  final totalQty = 0;
  final DioClient dio = DioClient();

  List<dynamic> document = [];
  @override
  Future<void> _postData() async {
    Map<String, dynamic> payload = {
      "BPL_IDAssignedToInvoice": 1,
      "CardCode": widget.data["CardCode"],
      "CardName": widget.data["CardName"],
      "WarehouseCode": whs.text,
      "DocumentLines": document.toList()
    };
    // setState(() {
    //   print(payload);
    // });
    // return;
    try {
      MaterialDialog.loading(context, barrierDismissible: false);

      final response = await dio.post('/PurchaseDeliveryNotes', data: payload);
      if (response.statusCode == 201) {
        MaterialDialog.close(context);
        MaterialDialog.success(context,
            title: 'Success', body: "Created Successfully !");
      }
    } catch (e) {
      MaterialDialog.close(context);
      MaterialDialog.success(context, title: 'Error', body: e.toString());
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    if (widget.data.isNotEmpty) {
      poNumber.text = widget.data["DocNum"]?.toString() ?? "";
      whs.text = "";
    }
  }

  // void addDocument() {
  //   if (item.text.isEmpty) return;
  //   int total = 0;

  //   Map<String, dynamic> newRow = {
  //     "ItemCode": item.text,
  //     "UoMCode": _uoMCode["name"],
  //     "UoMEntry": _uoMCode["value"],
  //     "Quantity": qty.text,
  //     "ItemDescription": _item["name"],
  //     "DocumentLinesBinAllocations": [
  //       // {
  //       //   "Quantity": _uoMCode["quantity"],
  //       //   // "BinAbsEntry": _binLocation["value"],
  //       //   // "BaseLineNumber": widget.ind,
  //       //   // "AllowNegativeQuantity": _binLocation["allowNegativeQuantity"],
  //       //   // "SerialAndBatchNumbersBaseLine":
  //       //   //     _binLocation["serialAndBatchNumbersBaseLine"]
  //       // }
  //     ]
  //   };
  //   if (item.text.isNotEmpty) {
  //     try {
  //       var documentLine = widget.data["DocumentLines"]
  //           .firstWhere((e) => e["ItemCode"] == item.text);
  //       newRow["TotalQty"] = documentLine["Quantity"];
  //       newRow["ItemDescription"] = documentLine["ItemDescription"];
  //     } catch (e) {
  //       MaterialDialog.success(context,
  //           title: 'Error', body: "ItemCode not found $e");
  //       return;
  //     }
  //   }

  //   setState(() {
  //     document = [
  //       newRow,
  //       ...document,
  //     ];
  //   });
  // }
  void addDocument() {
    if (item.text.isEmpty) return;

    // Prepare the new row data
    Map<String, dynamic> newRow = {
      "ItemCode": item.text,
      "UoMCode": _uoMCode["name"],
      "UoMEntry": _uoMCode["value"],
      "Quantity": int.parse(qty.text), // Ensure Quantity is an integer
      "ItemDescription": _item["name"],
      "WarehouseCode": whs.text,
      "DocumentLinesBinAllocations": [
        {
          "Quantity": _uoMCode["quantity"],
          "BinAbsEntry": _bin["value"],
          "BaseLineNumber": document.length,
          "AllowNegativeQuantity": "tNO",
          "SerialAndBatchNumbersBaseLine": -1
        }
      ]
    };
    if (item.text.isNotEmpty) {
      try {
        var documentLine = widget.data["DocumentLines"]
            .firstWhere((e) => e["ItemCode"] == item.text);
        newRow["TotalQty"] = documentLine["Quantity"];
        newRow["UoMCode"] = documentLine["UoMCode"];
      } catch (e) {
        _item["name"] = "";
        MaterialDialog.success(context,
            title: 'Error',
            body: "Purchase order does not contain item '${item.text}'");
        return;
      }
    }
    setState(() {
      // Check if the item already exists in the document
      int existingIndex =
          document.indexWhere((e) => e["ItemCode"] == item.text);
      if (existingIndex != -1) {
        // Update the quantity of the existing item
        // document[existingIndex]["Quantity"] += newRow["Quantity"];
        document[existingIndex]["Quantity"] = newRow["Quantity"];
        document[existingIndex]["UoMCode"] = newRow["UoMCode"];
      } else {
        // Add the new item
        document = [newRow, ...document];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(238, 16, 50, 171),
        title: const Text(
          'Good Receipt PO',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  addDocument();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 12, 112, 32),
                      borderRadius: BorderRadius.circular(5)),
                  width: 110,
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await _postData();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(238, 16, 50, 171),
                      borderRadius: BorderRadius.circular(5)),
                  width: 110,
                  child: Center(
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(238, 16, 50, 171),
                    borderRadius: BorderRadius.circular(5)),
                width: 110,
                child: Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            children: [
              FlexTwoField(
                title: "Whs",
                values: whs,
                menu: "true",
                onMenuClick: () {
                  _navigateWarehouseSelect(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              FlexTwoField(title: "PO. #", values: poNumber),
              SizedBox(
                height: 10,
              ),
              FlexTwoField(
                title: "Bin",
                values: bin,
                barcode: "true",
                menu: "true",
                onMenuClick: () {
                  _navigateBINSelect(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              FlexTwoField(
                title: "Item",
                values: item,
                menu: "true",
                barcode: "true",
                onMenuClick: () {
                  _navigateItemsSelect(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              FlexTwoField(title: "Qty", values: qty),
              SizedBox(
                height: 10,
              ),
              FlexTwoField(
                title: "UOM",
                values: uom,
                menu: "true",
                onMenuClick: () {
                  _navigateUOMSelect(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                child: Row(
                  children: const [
                    Expanded(flex: 7, child: Text("Item Number")),
                    Expanded(flex: 2, child: Text("UoM")),
                    Expanded(flex: 2, child: Text("Qty/Open")),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child:document.length == 0 ?
                Center(
                  child: Text("No Record"),
                )
                : ListView.builder(
                  // padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                  shrinkWrap: true,
                  itemCount: document.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: ListToDoItem(
                          itemCode: document[index]["ItemCode"],
                          desc: document[index]["ItemDescription"],
                          uom: document[index]["UoMCode"],
                          qty: document[index]["Quantity"],
                          openQty: document[index]["TotalQty"],
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }

  num indexWarehouseSeleted = -1;
  Future<void> _navigateWarehouseSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WarehouseSelect(
                branchId: 1,
                indBack: indexWarehouseSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      whs.text = result["name"];
      bin.text = "";
      indexBINSeleted = -1;
      indexWarehouseSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content:
              Text(whs.text == null ? "Unselected" : "Selected ${whs.text}")));
  }

  num indexItemsSeleted = -1;
  Future<void> _navigateItemsSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ItemsSelect(
                type: 'tYES',
                indBack: indexItemsSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      item.text = result["value"];
      _item = {"name": result["name"], "value": result["value"]};
      indexItemsSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(
              item.text == null ? "Unselected" : "Selected ${item.text}")));
  }

  num indexUOMSeleted = -1;
  Future<void> _navigateUOMSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UoMSelect(
              indBack: indexUOMSeleted,
              item: item.text,
              qty: double.tryParse(qty.text) ?? 0.00
              // branchId: _branch["value"],
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      uom.text = result["name"].toString();
      _uoMCode = {
        "name": result["name"],
        "value": result["value"],
        "quantity": result["quantity"],
        "useBaseUnits": "tNO"
      };
      print(_uoMCode);
      indexUOMSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_uoMCode["name"] == null
              ? "Unselected"
              : "Selected ${_uoMCode["name"]}")));
  }

  num indexBINSeleted = -1;
  Future<void> _navigateBINSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BinlocationSelect(
                indBack: indexBINSeleted,
                whCode: whs.text,
                // branchId: _branch["value"],
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      bin.text = result["name"];
      _bin = {
        "name": result["name"],
        "value": result["value"],
        "allowNegativeQuantity": "tNO",
        "serialAndBatchNumbersBaseLine": -1
      };
      indexBINSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_bin["name"] == null
              ? "Unselected"
              : "Selected ${_bin["name"]}")));
  }
}
