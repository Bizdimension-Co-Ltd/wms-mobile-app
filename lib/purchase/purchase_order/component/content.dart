import 'package:flutter/material.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderItemScreen.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: (){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PurchaseOrderItemScreen()),
                  );
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
                          color: Color.fromARGB(255, 188, 183, 183),
                          width: 0.5,
                        ),
                        right: BorderSide(
                          color: Color.fromARGB(255, 192, 188, 188),
                          width: 0.5,
                        ),
                      )),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 75.0,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 6,
                          child: Container(
                            child: Column(children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "Diesel Euro 5",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Quantity: 10",
                                          style: TextStyle(
                                            fontSize: 15.2,
                                               color: Color.fromARGB(255, 0, 0, 0))
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "FUE001",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 106, 103, 103)),
                                        ),
                                        Text(
                                          "TON",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 106, 103, 103)),
                                        )
                                      ],
                                    ),
                                  ))
                            ]),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
