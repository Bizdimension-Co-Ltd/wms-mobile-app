import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/loginScreen.dart';
import 'package:wms_mobile/purchase/direct_put_away/directPutAwayList.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderListScreen.dart';

const gridList = [
  {"name": "Purchase Order", "img": "shopping-cart.svg"},
  {"name": "Goods Receipt", "img": "receipt.svg"},
  {"name": "Good Receipt PO", "img": "gpo.svg"},
  {"name": "Direct Put Away", "img": "document.svg"},
];

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key});

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout)),
          const SizedBox(
            width: 15,
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Receiving",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 223, 220, 220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "Function",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                child: GridView.builder(
                    shrinkWrap: true, // use
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemCount: gridList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PurchaseOrderListScreen()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PurchaseOrderListScreen()),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PurchaseOrderListScreen()),
                            );
                          } else if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DirectPutAwayListScreen()),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "images/svg/${gridList[index]["img"]}",
                                width: 47,
                                height: 47,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                "${gridList[index]["name"]}",
                              ),
                            ],
                          )),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
