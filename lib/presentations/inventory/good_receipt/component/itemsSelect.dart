import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class ItemsSelect extends StatefulWidget {
  const ItemsSelect({super.key});

  @override
  State<ItemsSelect> createState() => _ItemsSelectState();
}

class _ItemsSelectState extends State<ItemsSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          "Items",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  PurchaseOrderCodeScreen()),
                );
              },
              icon: const Icon(Icons.qr_code_scanner_outlined)),
          const SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {},
              icon: const Text(
                "Done",
                style: TextStyle(fontSize: 15),
              )),
          const SizedBox(
            width: 13,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 236, 233, 233),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const DirectPutAwayItemDetailScreen()),
                    // );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border(
                          left: BorderSide(
                            color: Color.fromARGB(255, 200, 196, 196),
                            width: 0.5,
                          ),
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 202, 197, 197),
                            width: 0.5,
                          ),
                          right: BorderSide(
                            color: Color.fromARGB(255, 205, 201, 201),
                            width: 0.5,
                          ),
                        )),
                    width: double.infinity,
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: double.infinity,
                              // color: Colors.green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.check_box),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  SvgPicture.asset(
                                    "images/svg/box-3.svg",
                                    width: 50,
                                    color:
                                        const Color.fromARGB(255, 58, 65, 80),
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Diesel Euro 5",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "FUE0001",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 113, 109, 109)),
                                  )
                                ],
                              ),
                              // color: const Color.fromARGB(255, 67, 75, 182),
                            )),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
