// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:wms_mobile/form/datePicker.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/form/employeeSelect.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/form/branchSelect.dart';
import 'package:wms_mobile/form/textFlexTwo.dart';
import 'package:wms_mobile/form/vendor.dart';
import 'package:wms_mobile/form/warehouseSelect.dart';
import 'package:wms_mobile/model/direct_put_away.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayItemsScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wms_mobile/services/directPutAwayServices.dart';

class DirectPutAwayCreateScreen extends StatefulWidget {
  DirectPutAwayCreateScreen({super.key, this.ind, required this.edit});
  final ind;
  bool edit;
  @override
  State<DirectPutAwayCreateScreen> createState() =>
      _DirectPutAwayCreateScreenState();
}

class _DirectPutAwayCreateScreenState extends State<DirectPutAwayCreateScreen> {
  final TextEditingController _supplierRfNo = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _ = TextEditingController();

  final TextEditingController _status =
      TextEditingController(text: "bost_Open");
  final TextEditingController _journalRemark = TextEditingController();
  final TextEditingController _shipTo = TextEditingController();
  final TextEditingController _payTo = TextEditingController();
  String? _series;
  String? _cardCode;
  String? _cardName;
  final _branch = {"code": 0, "name": ''};
  final _employees = {"code": "", "firstName": "", "lastName": ""};
  final _warehouses = {"warehouseCode": "", "warehouseName": ""};
  String? _postingDate;
  String? _returnDate;
  String? _documentDate;
  String? _estimateDate;

  num? ivendor = -1;
  num? ibranch = -1;
  num? iemployees = -1;
  num? iwarehouse = -1;
  Future<void> _branchF(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BranchSelect(
                indBack: ibranch,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _branch['code'] = '${result['bPLID']}';
      _branch['name'] = '${result['bPLName']}';
      ibranch = result["index"];
    });
  }

  Future<void> _employee(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmployeeSelect(
                indBack: iemployees,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _employees['code'] = '${result['employeesCode']}';
      _employees['firstName'] = '${result['firstName']}';
      _employees['lastName'] = '${result['lastName']}';
      iemployees = result["index"];
    });
  }

  Future<void> _warehouse(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WarehouseSelect(
                indBack: iwarehouse,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _warehouses['warehouseCode'] = '${result['warehouseCode']}';
      _warehouses['warehouseName'] = '${result['warehouseName']}';
      iwarehouse = result["index"];
    });
  }

  Future<void> _vendor(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Vendor(
                indBack: ivendor,
              )),
    );
    if (!mounted) return;
    setState(() {
      if (result == null) return;
      _cardCode = result["cardCode"];
      _cardName = result["cardName"];
      _journalRemark.text =
          result == "" ? "" : "Good Return Request - ${result['cardCode']}";
      _shipTo.text = result["address"];
      _payTo.text = result == ""
          ? ""
          : "#C168 Russian Blvd, Phum CPC, Sangkat Tek Thlar Khan Sen Sok, Phnom Penhអាគារលេខ C168 វិថិសហព័ន្ធរុស្សី ភូមិសេប៉ែសេ សង្កាត់ទឹកថ្លារ ខណ្ឌ សែនសុខ រាជធានីភ្នំពេញ";
      ivendor = result["index"];
    });
  }

  void initSeries() async {
    Dio dio = Dio();
    Object? payload = {
      "DocumentTypeParams": DirectPutAwayServices().documentSerie
    };
    if (!widget.edit) {
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: "sessionId");
      try {
        final response = await dio.post(
          "https://svr11.biz-dimension.com:50000/b1s/v1/SeriesService_GetDefaultSeries",
          options: Options(
            headers: {
              "Cookie": "B1SESSION=$token; ROUTEID=.node4",
              "Content-Type": "application/json",
            },
          ),
          data: payload,
        );
        setState(() {
          _series = response.data['Name'];
        });
        print(response.data);
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initSeries();
    init();
  }

  void init() async {
    // _supplier.text = await directPutAway[widget.ind]['name'];
    // _remarks.text = await directPutAway[widget.ind]['remarks'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          'Good Return Request',
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
                    content: Row(
                      children: const [
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
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Save Offline Draft',
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 17, 18, 48))),
                        onPressed: () async {
                          Navigator.pop(context, 'ok');

                          // Create DocumentLine instances
                          // List<DocumentLine> documentLines = [];

                          // // Add items based on your requirements
                          // for (int i = 1; i <= 3; i++) {
                          //   documentLines.add(DocumentLine(
                          //     code: '00$i',
                          //     name: 'Item $i',
                          //     description: 'Description for Item $i',
                          //   ));
                          // }
                          // Create DirectPutAway instance with documentLines
                          DirectPutAway data = DirectPutAway(
                            cardCode: _cardCode,
                            cardName: _cardName,
                            contactPersonCode: null,
                            numAtCard: _supplierRfNo.text,
                            bPLIDAssignedToInvoice: null,
                            utlgrremp: null,
                            utlwhsdesc: null,
                            comments: null,
                            documentStatus: null,
                            docDate: _postingDate,
                            docDueDate: _returnDate,
                            taxDate: _estimateDate,
                            journalMemo: _journalRemark.text,
                            address2: _shipTo.text,
                            address: _payTo.text,
                            // documentLines: documentLines,
                          );

                          if (widget.ind != null) {
                            await DirectPutAwayServices()
                                .updateData(widget.ind, data);
                          } else if (widget.ind == null) {
                            await DirectPutAwayServices().postData(data);
                          }
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
            color: const Color.fromARGB(255, 17, 18, 48),
            width: double.infinity,
            height: 50,
            child: const Center(
              child: Text(
                "POST",
                style: TextStyle(color: Colors.white, fontSize: 17),
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
                textData: _series ?? "Series fetching...",
                textColor: const Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            GestureDetector(
              onTap: () {
                _vendor(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Supplier",
                  textData: _cardCode,
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            FlexTwoArrowWithText(
                title: "Name",
                textData: _cardName,
                textColor: const Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            const FlexTwoArrow(
              title: "Contact Person",
            ),
            TextFlexTwo(
              title: "Supplier Ref No.",
              textData: _supplierRfNo,
            ),
            GestureDetector(
              onTap: () {
                _branchF(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Branch",
                  textData: _branch['name'],
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            GestureDetector(
              onTap: () {
                _employee(context);
              },
              child: FlexTwoArrowWithText(
                title: "Employee",
                textData:
                    "${_employees['firstName']}${_employees['lastName'] != "" ? " - " : ''}${_employees['lastName']}",
                textColor: const Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                _warehouse(context);
              },
              child: FlexTwoArrowWithText(
                title: "Warehouse",
                 textData: _warehouses['warehouseName'],
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
              ),
            ),
            TextFlexTwo(
              title: "Remarks",
              textData: _remarks,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFlexTwo(
              title: "Status",
              textData: _status,
            ),
            DatePicker(
              dateValue: _postingDate,
              title: "Posting Date",
            ),
            DatePicker(
              dateValue: _returnDate,
              title: "Return Date",
            ),
            DatePicker(
              dateValue: _documentDate,
              title: "Document Date",
            ),
            // const TextFlexTwo(
            //   title: "Branch Reg. No.",
            //   textData: null,
            // ),
            DatePicker(
              dateValue: _estimateDate,
              title: "Estimate Delivery Date",
            ),
            TextFlexTwo(
              title: "Journal Remark",
              textData: _journalRemark,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DirectPutAwayItemsScreen()),
                );
              },
              child: const FlexTwoArrowWithText(
                  title: "Items",
                  // textData: _branch,
                  textColor: Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFlexTwo(
              title: "Ship To",
              textData: _shipTo,
            ),
            TextFlexTwo(
              title: "Pay to",
              textData: _payTo,
            ),
            // const FlexTwoArrow(
            //   title: "Shiping Type",
            // ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
