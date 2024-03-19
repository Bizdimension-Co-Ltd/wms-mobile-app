// ignore: file_names
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:wms_mobile/component/blockList.dart';
import 'package:wms_mobile/purchase/purchase_order/myData.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderCodeScreen.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  
  num check = 0;
  var s = 10;

  void request() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: "sessionId");
    final dio = Dio();
    Response response;
    response = await dio.get(
      "https://svr11.biz-dimension.com:50000/b1s/v1/PurchaseOrders?\$top=$s",
      options: Options(
        headers: {
          "Cookie": "B1SESSION=$token; ROUTEID=.node4",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      purchaseOrder.addAll(response.data['value']);
      // setState(() {
      //   check = purchaseOrder.length;
      // });
    }
  }

  @override
  void initState() {
    request();
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      purchaseOrder.clear();
      request();
      s = 10;
    });

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        request();
        s + 10;
      });
    }
    _refreshController.loadComplete();
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
      body:  Container(
      color: const Color.fromARGB(255, 236, 233, 233),
      height: double.infinity,
      width: double.infinity,
      child: check == 0
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.5,
              ),
            )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  shrinkWrap: true,
                  itemCount: purchaseOrder.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PurchaseOrderDetailScreen(ind: index)),
                        );
                      },
                      child: BlockList(
                        name:
                            "230010455 - ${purchaseOrder[index]["JournalMemo"]}",
                        // date: "23-3-2023",
                        date: "${purchaseOrder[index]["NumAtCard"]}",
                        status: "OPEN",
                        qty: "50/300",
                      ),
                    );
                  }),
            ),
    )
    );
  }
}
// 