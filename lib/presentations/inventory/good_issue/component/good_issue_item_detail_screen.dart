import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/form/flexTwoArrowWithText.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class GoodIssueItemDetailScreen extends StatefulWidget {
  GoodIssueItemDetailScreen({super.key, required this.itemDetail});
  Map<String, dynamic> itemDetail;
  @override
  State<GoodIssueItemDetailScreen> createState() =>
      _GoodIssueItemDetailScreenState();
}

class _GoodIssueItemDetailScreenState extends State<GoodIssueItemDetailScreen> {
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
        actions: const [],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 236, 233, 233),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            FlexTwo(
                title: "Item Code",
                values: widget.itemDetail["ItemCode"] ?? ''),
            FlexTwo(
                title: "Description",
                values: widget.itemDetail["ItemDescription"] ?? ''),
            FlexTwo(
                title: "Warehouse",
                values: widget.itemDetail["WarehouseCode"] ?? ''
                // textColor: Color.fromARGB(255, 129, 134, 140),
                ),
                 FlexTwo(
                title: "Bin Location", values:  ''),
            FlexTwo(
                title: "Quantity", values: widget.itemDetail["Quantity"] ?? ''),
              SizedBox(
              height: 30,
            ),
            FlexTwo(
                title: "Inventory UoM",
                values:  ''),
                 FlexTwo(
                title: "UoM Code",
                values: widget.itemDetail["UoMCode"] ?? ''),
            SizedBox(
              height: 30,
            ),
            FlexTwoArrowWithText(
              title: "Line Of Business",
              textData: widget.itemDetail["CostingCode"] ?? '',
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Revenue Line",
              textData: widget.itemDetail["CostingCode2"] ?? '',
              // textColor: Color.fromARGB(255, 129, 134, 140),
              simple: FontWeight.normal,
              // req: "true",
            ),
            FlexTwoArrowWithText(
              title: "Product Line",
              textData: widget.itemDetail["CostingCode3"] ?? '',
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
