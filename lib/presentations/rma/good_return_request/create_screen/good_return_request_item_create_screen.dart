import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/form/textFlexTwo.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class PurchaseOrderItemCreateScreen extends StatefulWidget {
  const PurchaseOrderItemCreateScreen({super.key});

  @override
  State<PurchaseOrderItemCreateScreen> createState() =>
      _PurchaseOrderItemCreateScreenState();
}

class _PurchaseOrderItemCreateScreenState
    extends State<PurchaseOrderItemCreateScreen> {
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
              simple: FontWeight.normal,
              req: "true",
            ),
            TextFlexTwo(
              req: "true",
              title: "Quantity",
              // textData: "",
            ),
            TextFlexTwo(
              title: "Unit Price",
              // textData: "FG01 - WHS - Finish Product",
            ),
            TextFlexTwo(
              title: "Gross Price",
              // textData: "FG01 - WHS - Finish Product",
            ),
            SizedBox(
              height: 30,
            ),
            TextFlexTwo(
              title: "Item Per Unit",
              // textData: "201003",
            ),
            TextFlexTwo(
              title: "Unit of Measurement",
              // textData: "",
            ),
            SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Line Of Business",
              // textData: "203006",
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Revenue Line",
              // textData: "203006",
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Product Line",
              // textData: "203006",
              simple: FontWeight.normal,
              // req: "true",
            ),
          ],
        ),
      ),
    );
  }
}
