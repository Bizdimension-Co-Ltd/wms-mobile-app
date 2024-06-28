import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flex_two_field.dart';
import 'package:wms_mobile/form/vendorSelect.dart';
import 'package:wms_mobile/form/warehouseSelect.dart';
import 'package:wms_mobile/presentations/inbound/customer_return_receipt/component/itemSelect.dart';
import 'package:wms_mobile/presentations/inbound/good_receipt_po/component/list_to_do_item.dart';
import 'package:wms_mobile/presentations/inventory/component/uomSelect.dart';
import 'package:wms_mobile/presentations/inventory/good_receipt/component/binlocationSelect.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class CustomerReturnReceiptCreateScreen extends StatefulWidget {
  CustomerReturnReceiptCreateScreen({super.key});
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<CustomerReturnReceiptCreateScreen> createState() =>
      _CustomerReturnReceiptCreateScreenState();
}

class _CustomerReturnReceiptCreateScreenState
    extends State<CustomerReturnReceiptCreateScreen> {
  // start form field

  TextEditingController whs = TextEditingController();
  TextEditingController sup = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController uom = TextEditingController();
  TextEditingController bin = TextEditingController();

  TextEditingController qty = TextEditingController();
  Map<String, dynamic> _rtr = {};
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
      "CardCode": _rtr["cardCode"],
      "CardName": _rtr["cardName"],
      "WarehouseCode": whs.text,
      "DocumentLines": document.toList()
    };
    // setState(() {
    //   print(payload);
    // });
    // return;
    try {
      MaterialDialog.loading(context, barrierDismissible: false);

      final response = await dio.post('/ReturnRequest', data: payload);
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
    // init();
  }

  // void init() async {
  //   if (widget.data.isNotEmpty) {
  //     poNumber.text = widget.data["DocNum"]?.toString() ?? "";
  //   }
  // }

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
    // if (item.text.isNotEmpty) {
    //   try {
    //     var documentLine = widget.data["DocumentLines"]
    //         .firstWhere((e) => e["ItemCode"] == item.text);
    //     newRow["TotalQty"] = documentLine["Quantity"];
    //     newRow["ItemDescription"] = documentLine["ItemDescription"];
    //   } catch (e) {
    //     MaterialDialog.success(context,
    //         title: 'Error', body: "ItemCode not found $e");
    //     return;
    //   }
    // }
        setState(() {
      document = [
        newRow,
        ...document,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(238, 16, 50, 171),
        title: const Text(
          'Return Receipt ',
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
              FlexTwoField(
                title: "RTR",
                values: sup,
                menu: "true",
                onMenuClick: () {
                  _navigateVendorSelect(context);
                },
              ),
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
                child: document.length == 0
                    ? Center(
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
      bin.text = "";
      indexBINSeleted = -1;
      whs.text = result["name"];
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

  num indexVendorSeleted = -1;
  Future<void> _navigateVendorSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VendorSelect(
                type: "cCustomer",
                indBack: indexVendorSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      sup.text = result["cardName"];
      _rtr = {
        "cardCode": result["cardCode"],
        "cardName": result["cardName"],
        "address": result["address"],
        "contactPersonList": result["contactPersonList"]
      };
      indexVendorSeleted = result["index"];
      print(sup.text);
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_rtr["cardCode"] == null
              ? "Unselected"
              : "Selected ${_rtr["cardCode"]}")));
  }
}
