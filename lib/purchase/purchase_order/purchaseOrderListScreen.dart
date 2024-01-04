// ignore: file_names
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:wms_mobile/component/blockList.dart';
import 'package:wms_mobile/purchase/purchase_order/myData.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderCodeScreen.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderDetailScreen.dart';
import 'package:dio/dio.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  
  final dio = Dio();
  num check = 0;
  void request() async {
    Response response;
    response = await dio.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      data.addAll(response.data);
      setState(() {
        check = data.length;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          "Purchase Orders ",
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
            width: 20,
          ),
          const Icon(Icons.calendar_today_outlined),
          const SizedBox(
            width: 13,
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 236, 233, 233),
        height: double.infinity,
        width: double.infinity,
        // padding: EdgeInsets.only(bottom: 30),
        child: check == 0
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2.5,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseOrderDetailScreen(
                                  ind: index,
                                )),
                      );
                    },
                    child: BlockList(
                      name: "230010455 - ${data[index]["name"]}",
                      // date: "23-3-2023",
                      date: "${data[index]["email"]}",

                      status: "OPEN",
                      qty: "50/300",
                    ),
                  );
                }),
      ),
    );
  }
}
// 