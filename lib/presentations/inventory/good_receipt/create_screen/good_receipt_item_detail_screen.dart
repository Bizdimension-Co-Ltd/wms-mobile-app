import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class DirectPutAwayItemDetailScreen extends StatefulWidget {
  const DirectPutAwayItemDetailScreen({super.key});

  @override
  State<DirectPutAwayItemDetailScreen> createState() =>
      _DirectPutAwayItemDetailScreenState();
}

class _DirectPutAwayItemDetailScreenState
    extends State<DirectPutAwayItemDetailScreen> {
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
              values: "FG01 - WHS - Finish Product",
              // textColor: Color.fromARGB(255, 129, 134, 140),

            ),

            FlexTwo(
              title: "Quantity",
              values: "1",
            ),
            
            FlexTwo(
              title: "Item Per Unit",
              values: "112.0",
            ),
            
            FlexTwo(
              title: "Unit Of Business",
              values: "20001",
            ),
            SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Line Of Business",
              // textData: "201003",
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Revenue Line",
              // textData: "",
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
