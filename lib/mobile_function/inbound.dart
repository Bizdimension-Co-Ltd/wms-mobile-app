import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/form/datePicker.dart';
import 'package:wms_mobile/feature/middleware/presentation/login_screen.dart';
import 'package:wms_mobile/mobile_function/countingScreen.dart';
import 'package:wms_mobile/mobile_function/inventoryScreen.dart';
import 'package:wms_mobile/mobile_function/packingScreen.dart';
import 'package:wms_mobile/mobile_function/receivingScreen.dart';
import 'package:wms_mobile/mobile_function/rmaScreen.dart';
import 'package:wms_mobile/presentations/inbound/good_receipt_po/good_receipt_po_select_vendor.dart';

import '../constant/style.dart';

const gridList = [
  {"name": "Good Receipt PO", "img": "download.svg"},
  {"name": "Quik Goods Receipt", "img": "upload.svg"},
  {"name": "Customer", "img": "heigth.svg"},
  {"name": "Transfer", "img": "transfer.svg"},
  {"name": "Counting", "img": "counting1.svg"},
  {"name": "Lookup", "img": "look.svg"},
  {"name": "Log Out", "img": "logout1.svg"}
];

class Inbound extends StatefulWidget {
  const Inbound({super.key});

  @override
  State<Inbound> createState() => _InboundState();
}

class _InboundState extends State<Inbound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(12), // Add some padding if necessary
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context, null);
              },
              child: Icon(Icons.arrow_back)),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(238, 16, 50, 171),
        title: const Text(
          "Inbound",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
          ),
        ),
      ),
      body: Container(
          // padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: ListView.builder(
                  // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  shrinkWrap: true,
                  itemCount: gridList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                         onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoodReceiptPOSelectVendor()),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey, // Set the desired color
                                width: 1.0, // Set the desired width
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SvgPicture.asset(
                                  color: Color.fromARGB(235, 28, 60, 176),
                                  "images/svg/${gridList[index]["img"]}",
                                  width: size(context).width * 0.09,
                                  height: size(context).width * 0.09,
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "${gridList[index]["name"]}",
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                    ),
                                  ))
                            ],
                          ),
                        ));
                  },
                ),
              )
            ],
          )),
    );
  }
}
