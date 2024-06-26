import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/injector.dart';
import 'package:wms_mobile/presentations/inbound/good_receipt_po/component/listSelectComponent.dart';
import 'package:wms_mobile/presentations/inbound/good_receipt_po/good_receipt_po_create_screen.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class GoodReceiptPOSelectVendor extends StatefulWidget {
  const GoodReceiptPOSelectVendor({
    super.key,
  });
  // ignore: prefer_typing_uninitialized_variables
  @override
  State<GoodReceiptPOSelectVendor> createState() =>
      _GoodReceiptPOSelectVendorState();
}

const gridList = [
  {"name": "Inbound", "img": "download.svg"},
  {"name": "Outbound", "img": "upload.svg"},
  {"name": "Pick & Pack", "img": "heigth.svg"},
  {"name": "Transfer", "img": "transfer.svg"},
  {"name": "Counting", "img": "counting1.svg"},
  {"name": "Lookup", "img": "look.svg"},
  {"name": "Log Out", "img": "logout1.svg"}
];

class _GoodReceiptPOSelectVendorState extends State<GoodReceiptPOSelectVendor> {
  int check = 1;
  TextEditingController filter = TextEditingController();
  final DioClient dio = DioClient();
  List<dynamic> data = [];
  Future<void> getListPurchaseOrder() async {
    if (filter.text == "") return;
    try {
      setState(() {
        check = 0;
      });
      final response = await dio
          .get("/PurchaseOrders?\$filter=CardCode eq '${filter.text}'");
      print(response);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            check = 1;
            data.addAll(response.data['value']);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(238, 16, 50, 171),
        title: const Text(
          'Purchase Order Lists',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoodReceiptPOCreateScreen(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 12, 112, 32),
                      borderRadius: BorderRadius.circular(5)),
                  width: 130,
                  child: Center(
                    child: Text(
                      "Receipt",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(238, 16, 50, 171),
                    borderRadius: BorderRadius.circular(5)),
                width: 130,
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
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 236, 233, 233),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              height: 100,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    margin: EdgeInsets.only(top: 5),
                    child: Text("Supplier :"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: TextField(
                              controller: filter,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                // hintText: 'User Id',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        10.0), // Adjust the vertical and horizontal padding as needed
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(235, 28, 60, 176),
                                      width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(235, 28, 60, 176),
                                      width: 2.0),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  width: 30,
                                  height: 30,
                                  color: Colors.black,
                                  "images/svg/book.svg",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await getListPurchaseOrder();
                                  },
                                  child: SvgPicture.asset(
                                    width: 30,
                                    height: 30,
                                    color: Color.fromARGB(235, 28, 60, 176),
                                    "images/svg/search.svg",
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: check == 0
                  ? Container(
                    height: 550,
                    child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2.5,
                        ),
                      ),
                  )
                  : data.length == 0
                      ? Container(
                        height: 550,
                        child: Center(child: Text("No Record")))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {}, child: BlockList());
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
