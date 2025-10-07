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
  {"name": "Good Receipt PO", "img": "receipt_po.svg"},
  {"name": "Quik Goods Receipt", "img": "pen.svg"},
  {"name": "Customer Return Receipt", "img": "return1.svg"},
  {"name": "Goods Receipt", "img": "add_home_work.svg"},
  {"name": "Put Away", "img": "put.svg"},
];

class Inbound extends StatefulWidget {
  const Inbound({super.key});

  @override
  State<Inbound> createState() => _InboundState();
}

class _InboundState extends State<Inbound> {
  final routes = [
    PurchaseOrderPage(),
    CreateGoodReceiptPOScreen(quickReceipt: true),
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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 65),
            child: const Text(
              'Inbound',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
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
              SizedBox(height: 10,),
              SizedBox(
                child: ListView.builder(
                  // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0) ,
                  shrinkWrap: true,
                  itemCount: gridList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        goTo(context, routes[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 22, 12, 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 242, 243, 244),
                        ),
                        margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  color: const Color.fromARGB(255, 18, 22, 157),
                                  "images/svg/${gridList[index]["img"]}",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${gridList[index]['name']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(0)),
                    //   child: ListTile(
                    //     onTap: () {
                    //       if (!routes.asMap().containsKey(index)) {
                    //         MaterialDialog.success(context,
                    //             title: 'Oop',
                    //             body:
                    //                 '${gridList[index]['name']} is not implement yet!');
                    //         return;
                    //       }

                    //       goTo(context, routes[index]);
                    //     },
                    //     leading: SvgPicture.asset(
                    //       color: Color.fromARGB(235, 28, 60, 176),
                    //       "images/svg/${gridList[index]["img"]}",
                    //       width: size(context).width * 0.08,
                    //       height: size(context).width * 0.08,
                    //     ),
                    //     title: Text('${gridList[index]['name']}'),
                    //   ),
                    // );
                  },
                ),
              )
            ],
          )),
    );
  }
}
