import 'package:flutter/material.dart';
import 'package:wms_mobile/component/datePicker.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/component/flexTwoArrowWithText.dart';
import 'package:wms_mobile/component/textFlexTwo.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayItemsScreen.dart';
import 'package:dio/dio.dart';
import 'package:wms_mobile/purchase/purchase_order/myData.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DirectPutAwayCreateScreen extends StatefulWidget {
  const DirectPutAwayCreateScreen({super.key, this.ind});
  final ind;
  @override
  State<DirectPutAwayCreateScreen> createState() =>
      _DirectPutAwayCreateScreenState();
}

class _DirectPutAwayCreateScreenState extends State<DirectPutAwayCreateScreen> {
  final _supplier = TextEditingController();
  String _responseMessage = '';
  Future<void> _postData() async {
    const String apiUrl = 'https://svr11.biz-dimension.com:50000/b1s/v1/EmployeesInfo';

    try {
      Dio dio = Dio();
      var payload = {
        'FirstName': _supplier.text,
      };
      if (widget.ind != null) {
            const FlutterSecureStorage secureStorage = FlutterSecureStorage();
            String? token = await secureStorage.read(key: "sessionId");
       Response response;
        response = await dio.post(
          apiUrl,
          options: Options(
            headers: {
              "Cookie": "B1SESSION=$token; ROUTEID=.node4",
              "Content-Type": "application/json",
            },
          ),
          data: payload
        );
        setState(() {
          _responseMessage =
              'Status:PATH ${response.statusCode}\nResponse: ${response.data}';
          print(_responseMessage);
        });
      } else if (widget.ind == null) {
        Response response = await dio.post(apiUrl, data: payload);

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

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _supplier.text = await data[widget.ind]['name'];
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
            const FlexTwoArrowWithText(
              title: "Series",
              value: "required",
              textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            const FlexTwoArrowWithText(
              title: "Supplier",
              value: "required",
              textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            const FlexTwoArrow(
              title: "Contact Person Code",
            ),
            // const FlexTwo(
            //   title: "Supplier Ref No.",
            //   values: "S012",
            // ),
            TextFlexTwo(
              title: "Supplier Ref No.",
              textData: _supplier,
            ),
            const FlexTwoArrowWithText(
              title: "Brach",
              value: "required",
              textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            const FlexTwo(
              title: "Remark",
              values: "Good Return Request",
            ),
            const SizedBox(
              height: 30,
            ),
            const DatePicker(
              title: "Posting Date",
            ),
            const DatePicker(
              title: "Due Date",
            ),
            const DatePicker(
              title: "Document Date",
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
                value: "(3)",
                textColor: Color.fromARGB(255, 129, 134, 140),
                simple: FontWeight.normal,
                req: "true",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const FlexTwoArrow(
              title: "Ship To",
            ),
            const FlexTwoArrow(
              title: "Pay to",
            ),
            const FlexTwoArrow(
              title: "Shiping Type",
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
