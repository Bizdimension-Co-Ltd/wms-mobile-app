import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/utilies/formart.dart';

class General extends StatefulWidget {
  final Map<String, dynamic> gHeader;
  const General({super.key, required this.gHeader});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 236, 233, 233),
      child: ListView(
        children: [
          Container(
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
            height: 80.0,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Items (${widget.gHeader["DocumentLines"].length})",
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
          FlexTwo(
            title: "Series",
            values: widget.gHeader["Series"],
          ),
          FlexTwo(
            title: "Document Number",
            values: widget.gHeader["DocNum"],
          ),
          FlexTwo(
            title: "Employee No",
            values: widget.gHeader["Series"],
          ),
          FlexTwo(
            title: "Transportation No",
            values: widget.gHeader["Series"],
          ),
          FlexTwo(
            title: "Truck No",
            values: widget.gHeader["Series"],
          ),
          FlexTwo(
            title: "Ship To",
            values: widget.gHeader["ShipToCode"] ?? "",
          ),
          FlexTwo(
            title: "Revenue Line",
            values: widget.gHeader["Series"],
          ),
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Branch",
            values: widget.gHeader["BPLName"],
          ),
          FlexTwo(
            title: "Warehouse",
            values: widget.gHeader["U_tl_whsdesc"],
          ),
          FlexTwo(
            title: "Good Receipt Type",
            values: widget.gHeader["U_tl_grtype"],
          ),
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Posting Date",
            values: splitDate(widget.gHeader["TaxDate"]),
          ),
          FlexTwo(
            title: "Document Date",
            values: splitDate(widget.gHeader["DocDate"]) ,
          ),
          FlexTwo(
            title: "Remark",
            values: widget.gHeader["Comments"],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
