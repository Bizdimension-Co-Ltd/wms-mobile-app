import 'package:flutter/material.dart';
import 'package:wms_mobile/presentations/inventory/good_receipt/component/itemsSelect.dart';
import 'package:wms_mobile/presentations/inventory/good_receipt/component/listItems.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class GoodReceiptItemsScreen extends StatefulWidget {
  const GoodReceiptItemsScreen({super.key});

  @override
  State<GoodReceiptItemsScreen> createState() => _GoodReceiptItemsScreenState();
}

class _GoodReceiptItemsScreenState extends State<GoodReceiptItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          "Items",
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemsSelect()),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
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
              return const ListItems();
            }),
      ),
    );
  }
}
