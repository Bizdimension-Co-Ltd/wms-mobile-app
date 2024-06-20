import 'package:flutter/material.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/form/branchSelect.dart';
import 'package:wms_mobile/form/employeeSelect.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/form/goodReceiptTypeSelect.dart';
import 'package:wms_mobile/form/revenueLine.dart';
import 'package:wms_mobile/form/textFlexTwo.dart';
import 'package:wms_mobile/form/warehouseSelect.dart';
import 'package:wms_mobile/presentations/inventory/good_Receipt/create_screen/good_Receipt_list_item_screen.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class GoodReceiptCreateScreen extends StatefulWidget {
  GoodReceiptCreateScreen({super.key, this.id, required this.dataById});
  // ignore: prefer_typing_uninitialized_variables
  final id;
  Map<String, dynamic> dataById;
  @override
  State<GoodReceiptCreateScreen> createState() => _GoodReceiptCreateScreenState();
}

class _GoodReceiptCreateScreenState extends State<GoodReceiptCreateScreen> {
  final TextEditingController _supplier = TextEditingController();
  String? _serie;
  Map<String, dynamic> _employee = {};
  final TextEditingController _transportationNo = TextEditingController();
  final TextEditingController _truckNo = TextEditingController();
  Map<String, dynamic> _shipTo = {};
  Map<String, dynamic> _revenueLine = {};
  Map<String, dynamic> _branch = {};
  Map<String, dynamic> _warehouse = {};
  Map<String, dynamic> _giType = {};
  List<dynamic> selectedItems = [];
  final TextEditingController _remark = TextEditingController( );

  final DioClient dio = DioClient();
  final String _responseMessage = '';

  int check = 0;
  Future<void> _postData() async {
    Map<String, dynamic> payload = {
      // "Series": int.parse(series),
      // "CardCode": _vendor["cardCode"],
      // "CardName": _vendor["cardName"],
      // "ContactPersonCode": 0,
      // "NumAtCard": _supplierRefNo.text,
      // "BPL_IDAssignedToInvoice": _branch["BplId"],
      // "JournalMemo": "Purchase Orders - ${_vendor["cardCode"]}",
      // "Comments": _remark.text,
      // "DocDate": _postingDate.toString(),
      // "DocDueDate": _dueDate.toString(),
      // "Taxdate": _documentDate.toString(),
      // "Address2": _shipTo,
      // "Address": _vendor["address"],
      "DocumentLines": selectedItems
          .map((e) => {
                "ItemCode": e["ItemCode"],
                "ItemDescription": e["ItemName"] ?? e["ItemDescription"],
                "Quantity": 10,
                // "WarehouseCode":
                "UnitPrice": 0,
                "GrossBuyPrice": 0,
                "UoMCode": e["InventoryUOM"]
              })
          .toList()
    };
    try {
      MaterialDialog.loading(context, barrierDismissible: false);

      final response = widget.id
          ? await dio.patch("/InventoryGenEntries('')", data: payload)
          : await dio.post('/InventoryGenEntries', data: payload);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            check = 1;
            // series.addAll(response.data['value']);
          });
          MaterialDialog.close(context);
          MaterialDialog.success(context,
              title: 'Success',
              body: widget.id
                  ? "Updated Sccessfully !"
                  : "Created Sccessfully !");
        }
      } else {
        MaterialDialog.close(context);
        throw ServerFailure(message: response.data['msg']);
      }
    } catch (e) {
      print(e);
      MaterialDialog.close(context);
      MaterialDialog.success(context, title: 'Error', body: "");
    }
  }

  Future<void> getListSeries() async {
    Map<String, dynamic> payload = {
      'DocumentTypeParams': {'Document': '59'},
    };
    try {
      final response =
          await dio.post('/SeriesService_GetDocumentSeries', data: payload);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            check = 1;
            // series.addAll(response.data['value']);
          });
          // print(response.data["value"]);
        }
      } else {
        throw ServerFailure(message: response.data['msg']);
      }
    } on Failure {
      rethrow;
    }
  }

  Future<void> getDefaultSeries() async {
    if (widget.id) return;
    Map<String, dynamic> payload = {
      'DocumentTypeParams': {'Document': '59'},
    };
    try {
      final response =
          await dio.post('/SeriesService_GetDefaultSeries', data: payload);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            check = 1;
            _serie = response.data["Series"].toString();
            // series.addAll(response.data['value']);
          });
        }
      } else {
        throw ServerFailure(message: response.data['msg']);
      }
    } on Failure {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    getDefaultSeries();
  }

  Future<void> init() async {
    if (widget.id) {
      setState(() {
        _serie = widget.dataById["Series"].toString();
        _employee["value"] = widget.dataById["U_tl_grempl"];
        _transportationNo.text = widget.dataById["U_tl_grtrano"] ?? "";
        _truckNo.text = widget.dataById["U_tl_grtruno"] ??"";
        _shipTo["value"] = widget.dataById["U_tl_branc"];
        _revenueLine["value"] = widget.dataById["U_ti_revenue"];
        _branch["value"] = widget.dataById["BPL_IDAssignedToInvoice"];
        _warehouse["value"] = widget.dataById["U_tl_whsdesc"];
        _giType["value"] = widget.dataById["U_tl_gitype"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          'Good Receipt',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Posting Documents',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: const Row(
                      children: [
                        Text(''),
                        SizedBox(width: 5),
                        Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {Navigator.pop(context, 'Cancel')},
                        child: const Text('Save Offline Draft',
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 17, 18, 48))),
                        onPressed: () async => {
                          Navigator.pop(context, 'ok'),
                          // await _postData()
                        },
                        child: Container(
                          width: 90,
                          // height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: const Center(
                            child: Text(
                              'Sync to SAP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
        },
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 17, 18, 48),
                borderRadius: BorderRadius.circular(50)),
            width: double.infinity,
            child: const Center(
              child: Text(
                "POST",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 236, 233, 233),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
                title: "Series",
                textData: _serie,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            GestureDetector(
              onTap: () {
                _navigateEmployeeSelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Employee",
                  textData: _employee["name"] ?? _employee["value"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            TextFlexTwo(
              title: "Transportation No",
              textData: _transportationNo,
              req: "true",
            ),
            TextFlexTwo(
              title: "Truck No",
              textData: _truckNo,
              req: "true",
            ),
            GestureDetector(
              onTap: () {
                _navigateShipToSelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Ship To",
                  textData: _shipTo["name"] ?? _shipTo["value"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            GestureDetector(
              onTap: () {
                _navigateRevenueLineSelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Revenue Line",
                  textData: _revenueLine["name"] ?? _revenueLine["value"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _navigateBranchSelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Branch",
                  textData: _branch["name"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            GestureDetector(
              onTap: () {
                _navigateWarehouseSelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Warehouse",
                  textData: _warehouse["name"] ?? _warehouse["value"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            GestureDetector(
              onTap: () {
                _navigateGISelect(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Good Receipt Type",
                  textData: _giType["name"] ?? _giType["value"],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            const SizedBox(
              height: 30,
            ),
            // const DatePicker(
            //   title: "Posting Date",
            //   req: "true",
            // ),
            // const DatePicker(
            //   title: "Document Date",
            //   req: "true",
            // ),
            TextFlexTwo(
              title: "Remark",
              textData: _remark,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoodReceiptListItemsScreen(
                      dataFromPrev: selectedItems,
                    ),
                  ),
                );

                // Handle the result here
                if (result != null) {
                  setState(() {
                    selectedItems = List<dynamic>.from(result);
                  });

                  // Do something with the selected items
                }
              },
              child: FlexTwoArrowWithText(
                  title: "Items",
                  textData: "(${selectedItems.length})",
                  textColor: Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            const SizedBox(
              height: 30,
            ),
            FlexTwoArrow(
              title: "Reference Documents ",
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  num indexEmployeeSeleted = -1;
  Future<void> _navigateEmployeeSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmployeeSelect(
                indBack: indexEmployeeSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _employee = {"name": result["name"], "value": result["value"]};
      indexEmployeeSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_employee["name"] == null
              ? "Unselected"
              : "Selected ${_employee["name"]}")));
  }

  num indexShipToSeleted = -1;
  Future<void> _navigateShipToSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WarehouseSelect(
                indBack: indexShipToSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _shipTo = {"name": result["name"], "value": result["value"]};
      indexShipToSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_warehouse["name"] == null
              ? "Unselected"
              : "Selected ${_warehouse["name"]}")));
  }

  num indexRevenueLineSeleted = -1;
  Future<void> _navigateRevenueLineSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RevenueLineSelect(
                indBack: indexRevenueLineSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _revenueLine = {"name": result["name"], "value": result["value"]};
      indexRevenueLineSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_revenueLine["name"] == null
              ? "Unselected"
              : "Selected ${_revenueLine["name"]}")));
  }

  num indexBranchSeleted = -1;
  Future<void> _navigateBranchSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BranchSelect(
                indBack: indexBranchSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _branch = {"name": result["name"], "value": result["value"]};
      indexBranchSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_branch["name"] == null
              ? "Unselected"
              : "Selected ${_branch["name"]}")));
  }

  num indexWarehouseSeleted = -1;
  Future<void> _navigateWarehouseSelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WarehouseSelect(
                indBack: indexWarehouseSeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _warehouse = {"name": result["name"], "value": result["value"]};
      indexWarehouseSeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_warehouse["name"] == null
              ? "Unselected"
              : "Selected ${_warehouse["name"]}")));
  }

  num indexGISeleted = -1;
  Future<void> _navigateGISelect(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GoodReceiptTypeSelect(
                indBack: indexGISeleted,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _giType = {"name": result["name"], "value": result["value"]};
      indexGISeleted = result["index"];
    });
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(_giType["name"] == null
              ? "Unselected"
              : "Selected ${_giType["name"]}")));
  }
}
