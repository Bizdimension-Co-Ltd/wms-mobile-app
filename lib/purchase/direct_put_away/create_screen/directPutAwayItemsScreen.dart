import 'package:flutter/material.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/itemsSelect.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/listItems.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayItemCreateScreen.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderCodeScreen.dart';

class DirectPutAwayItemsScreen extends StatefulWidget {
  const DirectPutAwayItemsScreen({super.key});

  @override
  State<DirectPutAwayItemsScreen> createState() =>
      _DirectPutAwayItemsScreenState();
}

class _DirectPutAwayItemsScreenState extends State<DirectPutAwayItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      builder: (context) => const PurchaseOrderCodeScreen()),
                );
              },
              icon: const Icon(Icons.qr_code_scanner_outlined)),
          const SizedBox(
            width: 15,
          ),
          IconButton(
            onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ItemsSelect()),
              );
            },
            icon:  Icon(
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
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DirectPutAwayItemCreateScreen()),
                    );
                  },
                  child: const ListItems());
            }),
      ),
    );
  }
}
