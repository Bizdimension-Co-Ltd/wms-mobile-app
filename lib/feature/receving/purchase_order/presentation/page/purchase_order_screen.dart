// ignore: file_names
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:wms_mobile/component/blockList.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/purchase/purchase_order/myData.dart';
import 'package:wms_mobile/purchase/purchase_order/purchaseOrderDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key, required this.title});

  final String title;

  @override
  State<PurchaseOrderScreen> createState() =>
      _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  DateTime selectedDate = DateTime.now();

  final dio = Dio();
  int check = 0;

  void request() async {
    setState(() => check = 0);
    await Future.delayed(const Duration(seconds: 1));

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
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size(context).width * 0.045),
        ),
        actions: [
          IconButton(
              onPressed: () {
                MaterialDialog.success(context,
                    title: 'Oop', body: 'Scanner undermantain!');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const PurchaseOrderCodeScreen()),
                // );
              },
              icon: const Icon(Icons.qr_code_scanner_outlined)),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => _selectDate(context),
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
                            title: widget.title,
                          ),
                        ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: createDocument,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      request();
    }
  }

  Future<void> createDocument() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) MaterialDialog.loading(context, barrierDismissible: false);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      MaterialDialog.close(context);
      MaterialDialog.success(context,
          title: 'Oop', body: 'Internal Error Occur(1)');
    }
  }
}
// 