import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrowWithText.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class DirectPutAwayItemCreateScreen extends StatefulWidget {
  const DirectPutAwayItemCreateScreen({super.key});

  @override
  State<DirectPutAwayItemCreateScreen> createState() =>
      _DirectPutAwayItemCreateScreenState();
}

class _DirectPutAwayItemCreateScreenState
    extends State<DirectPutAwayItemCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          'Items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PurchaseOrderCodeScreen()),
                );
              },
              icon: const Icon(Icons.qr_code_scanner_outlined)),
          const SizedBox(
            width: 15,
          ),
          const Icon(
            Icons.add,
            size: 25,
          ),
          const SizedBox(
            width: 13,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 236, 233, 233),
        child: ListView(
          children: const [
            SizedBox(
              height: 30,
            ),
            FlexTwo(
              title: "Item Code",
              values: "FUE0001",
            ),
            FlexTwo(
              title: "Description",
              values: "Diesel Euro 5",
            ),
            FlexTwoArrowWithText(
              title: "Warehouse",
              value: "FG01 - WHS - Finish Product",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            FlexTwoArrowWithText(
              title: "UoM Code",
              value: "TON",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            FlexTwo(
              title: "Quantity",
              values: "1",
            ),
            SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Line Of Business",
              value: "201003",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Revenue Line",
              value: "",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Product Line",
              value: "203006",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
          ],
        ),
      ),
    );
  }
}
