import 'package:flutter/material.dart';
import 'package:wms_mobile/form/datePicker.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/form/branchSelect.dart';
import 'package:wms_mobile/form/textFlexTwo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wms_mobile/presentations/inventory/good_receipt/create_screen/good_receipt_list_item_screen.dart';

class GoodReceiptCreateScreen extends StatefulWidget {
  const GoodReceiptCreateScreen({super.key, this.ind});
  // ignore: prefer_typing_uninitialized_variables
  final ind;
  @override
  State<GoodReceiptCreateScreen> createState() =>
      _GoodReceiptCreateScreenState();
}

class _GoodReceiptCreateScreenState extends State<GoodReceiptCreateScreen> {
  final _supplier = TextEditingController();

  String? _branch;
  num i = -1;
  String _responseMessage = '';
  Future<void> _postData() async {
    const String apiUrl =
        'https://svr11.biz-dimension.com:50000/b1s/v1/EmployeesInfo';

    try {
      Dio dio = Dio();
      var payload = {
        'FirstName': 'Testdata',
      };
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: "sessionId");
      if (widget.ind != null) {
        Response response;
        response = await dio.patch(
            'https://svr11.biz-dimension.com:50000/b1s/v1/EmployeesInfo(${widget.ind})',
            options: Options(
              headers: {
                "Cookie": "B1SESSION=$token; ROUTEID=.node4",
                "Content-Type": "application/json",
              },
            ),
            data: payload);
        setState(() {
          _responseMessage =
              'Status:PATH ${response.statusCode}\nResponse: ${response.data}';
          print(_responseMessage);
        });
      } else if (widget.ind == null) {
        Response response = await dio.post(apiUrl,
            options: Options(
              headers: {
                "Cookie": "B1SESSION=$token; ROUTEID=.node4",
                "Content-Type": "application/json",
              },
            ),
            data: payload);

        setState(() {
          _responseMessage =
              'Status:POST ${response.statusCode}\nResponse: ${response.data}';
          print(_responseMessage);
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Error: $e';
        print(_responseMessage);
      });
    } finally {}
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BranchSelect(
                indBack: i,
              )),
    );

    if (!mounted) return;

    setState(() {
      if (result == null) return;
      _branch = result["value"];
      i = result["index"];
    });

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(
    //       SnackBar(content: Text(_branch == null ? "unselected" : "$_branch")));
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    if (widget.ind != null) {
      // _supplier.text = await data[widget.ind]['name'];
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
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Save Offline Draft',
                            style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 17, 18, 48))),
                        onPressed: () async =>
                            {Navigator.pop(context, 'ok'), await _postData()},
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
            const FlexTwoArrowWithText(
                title: "Series",
                // textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            const FlexTwoArrowWithText(
                title: "Employee No",
                //  textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            TextFlexTwo(
              title: "Transportation No",
              textData: _supplier,
              req: "true",
            ),
            TextFlexTwo(
              title: "Truck No",
              textData: _supplier,
              req: "true",
            ),
            const FlexTwoArrowWithText(
                title: "Ship To",
                // textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            const FlexTwoArrowWithText(
                title: "Revenue Line",
                // textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _navigateAndDisplaySelection(context);
              },
              child: FlexTwoArrowWithText(
                  title: "Branch",
                  textData: _branch,
                  textColor: const Color.fromARGB(255, 129, 134, 140),
                  simple: FontWeight.normal,
                  req: "true",
                  requried: "requried"),
            ),
            const FlexTwoArrowWithText(
                title: "Warehouse",
                // textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
            const FlexTwoArrowWithText(
                title: "Good issue Type",
                // textData: _branch,
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
                requried: "requried"),
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
              textData: _supplier,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoodReceiptItemsScreen()),
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
}
