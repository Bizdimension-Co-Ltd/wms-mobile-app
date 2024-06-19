import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/form/textFlexTwo.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class GoodReceiptItemCreateScreen extends StatefulWidget {
  const  GoodReceiptItemCreateScreen({super.key});

  @override
  State<GoodReceiptItemCreateScreen> createState() =>
      _GoodReceiptItemCreateScreenState();
}

class _GoodReceiptItemCreateScreenState
    extends State<GoodReceiptItemCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
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
                      builder: (context) =>  PurchaseOrderCodeScreen()),
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
             TextFlexTwo(
              title: "Item Code",
              // textData: "",
            ),
             TextFlexTwo(
              title: "Description",
              // textData: "",
            ),
            FlexTwoArrowWithText(
              title: "Warehouse",
              // textData: "FG01 - WHS - Finish Product",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            FlexTwoArrowWithText(
              title: "UoM Code",
              // textData: "TON",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
            TextFlexTwo(
              title: "Quantity",
              // textData: "",
            ),
            SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Inventory UoM",
              // textData: "201003",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "UoM Code",
              // textData: "",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              req: "true",
            ),
             SizedBox(
              height: 30,
            ),
             FlexTwoArrowWithText(
              title: "Line Of Business",
              // textData: "203006",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
             FlexTwoArrowWithText(
              title: "Revenue Line",
              // textData: "203006",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Product Line",
              // textData: "203006",
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
