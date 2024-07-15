import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/feature/inbound/put_away/presentation/create_put_away_screen.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import '/feature/inbound/good_receipt_po/presentation/create_good_receipt_screen.dart';
import '/feature/inbound/purchase_order/presentation/purchase_order_page.dart';
import 'return_receipt/presentation/create_return_receipt_screen.dart';

import '../../constant/style.dart';
import '../../helper/helper.dart';
import 'good_receipt/presentation/create_good_receipt_screen.dart';

const gridList = [
  {"name": "Good Receipt PO", "img": "download.svg"},
  {"name": "Quik Goods Receipt", "img": "download.svg"},
  {"name": "Customer Return Receipt", "img": "return.svg"},
  {"name": "Goods Receipt", "img": "transfer.svg"},
  {"name": "Put Away", "img": "counting1.svg"},
];

class Inbound extends StatefulWidget {
  const Inbound({super.key});

  @override
  State<Inbound> createState() => _InboundState();
}

class _InboundState extends State<Inbound> {
  final routes = [
    PurchaseOrderPage(),
    CreateGoodReceiptPOScreen(quickReceipt:true),
    CreateReturnReceiptScreen(),
    CreateGoodReceiptScreen(),
    CreatePutAwayScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          "Inbound",
          style: TextStyle(
            color: Colors.white,
            fontSize: size(context).width * 0.045,
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
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: ListTile(
                        onTap: () {
                          if (!routes.asMap().containsKey(index)) {
                            MaterialDialog.success(context,
                                title: 'Oop',
                                body:
                                    '${gridList[index]['name']} is not implement yet!');
                            return;
                          }

                          goTo(context, routes[index]);
                        },
                        leading: SvgPicture.asset(
                          color: Color.fromARGB(235, 28, 60, 176),
                          "images/svg/${gridList[index]["img"]}",
                          width: size(context).width * 0.08,
                          height: size(context).width * 0.08,
                        ),
                        title: Text('${gridList[index]['name']}'),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
