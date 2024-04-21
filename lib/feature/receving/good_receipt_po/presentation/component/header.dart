import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';

import '../good_receipt_po_detail_content_screen.dart';
import '../myData.dart';

class HeaderScreen extends StatefulWidget {
  const HeaderScreen({super.key, required this.data, required this.title});
  final data;
  final String title;
  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: PRIMARY_BG_COLOR,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  top: BorderSide(
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
                                children: [
                                  Text(
                                    "230010455 - ${widget.data["name"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "9-04-2023",
                                  //   style: TextStyle(
                                  //       color:
                                  //           Color.fromARGB(255, 106, 103, 103)),
                                  // ),
                                  Text(
                                    "${widget.data["email"]}",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 106, 103, 103)),
                                  ),
                                  const Text(
                                    "OPEN",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ]),
                    )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoodReceiptDetailContentScreen(
                  data: widget.data,
                  title: widget.title,
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                  const Expanded(
                      flex: 4,
                      child: SizedBox(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Items (3)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                "Click to View Items",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 106, 103, 103)),
                              ),
                            ]),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("25/300"),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ],
                          )))
                ],
              ),
            ),
          ),
          const FlexTwo(
            title: "Series",
            values: "23000001",
          ),
          const FlexTwo(
            title: "Document Number",
            values: "23000005",
          ),
          const FlexTwo(
            title: "Vendor",
            values: "2000001",
          ),
          const FlexTwo(
            title: "Name",
            values: "Trey Salmon",
          ),
          const FlexTwo(
            title: "Contact Person",
            values: "Trey Salmon",
          ),
          const SizedBox(
            height: 30,
          ),
          const FlexTwo(
            title: "Document Date",
            values: "04-10-2023",
          ),
          const FlexTwo(
            title: "Delivery Date",
            values: "04-10-2023",
          ),
          const FlexTwo(
            title: "Posting Date",
            values: "04-10-2023",
          ),
          const FlexTwo(
            title: "Remark",
            values: "A0012",
          ),
          const FlexTwo(
            title: "Custumer Ref. No",
            values: "01",
          ),
          const FlexTwo(
            title: "Status",
            values: "OPEN",
          ),
          const FlexTwo(
            title: "Branch",
            values: "205001 - TELA Battambang",
          ),
          const SizedBox(
            height: 30,
          ),
          const FlexTwoArrow(
            title: "Attachment",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
