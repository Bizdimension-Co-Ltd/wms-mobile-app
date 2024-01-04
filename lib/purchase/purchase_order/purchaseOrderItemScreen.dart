import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/component/flexTwoArrowWithText.dart';

class PurchaseOrderItemScreen extends StatefulWidget {
  const PurchaseOrderItemScreen({super.key});

  @override
  State<PurchaseOrderItemScreen> createState() =>
      _PurchaseOrderItemScreenState();
}

class _PurchaseOrderItemScreenState extends State<PurchaseOrderItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          'Purchase Orders',
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
            FlexTwo(
              title: "Item Code",
              values: "FUE0001",
            ),
            FlexTwo(
              title: "Description",
              values: "Diesel Euro 5",
            ),
            FlexTwo(
              title: "Warehouse",
              values: "ST001 - WHS - Tela Battambang",
            ),
            FlexTwo(
              title: "Name",
              values: "Trey Salmon",
            ),
            FlexTwo(
              title: "Quantity",
              values: "1.0",
            ),
               FlexTwo(
              title: "Gross Price",
              values: "1.0 USD",
            ),
            SizedBox(
              height: 30,
            ),
            FlexTwo(
              title: "Item Per Unit",
              values: "1190.0",
            ),
            FlexTwo(
              title: "Unit Of Measurement",
              values: "TON",
            ),
             SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Line Of Business",
              value: "201001",
            ),
            FlexTwoArrow(
              title: "Revenue Line",
            ),
            FlexTwoArrowWithText(
              title: "Product Line",
              value: "109401",
            ),

          ],
        ),
      ),
    );
  }
}
