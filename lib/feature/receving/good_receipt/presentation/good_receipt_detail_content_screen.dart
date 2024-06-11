// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '/utilies/dialog/dialog.dart';

import '../../../../constant/style.dart';
import 'component/content.dart';

const borderStyle = BoxDecoration(
  color: Color.fromARGB(255, 255, 255, 255),
  border: Border(
    left: BorderSide(
      color: Color.fromARGB(255, 200, 196, 196),
      width: 0.5,
    ),
    bottom: BorderSide(
      color: Color.fromARGB(255, 188, 183, 183),
      width: 0.5,
    ),
    right: BorderSide(
      color: Color.fromARGB(255, 192, 188, 188),
      width: 0.5,
    ),
    top: BorderSide(
      color: Color.fromARGB(255, 192, 188, 188),
      width: 0.5,
    ),
  ),
);

class GoodReceiptDetailContentScreen extends StatefulWidget {
  const GoodReceiptDetailContentScreen(
      {super.key, required this.data, required this.title});
  final data;

  final String title;

  @override
  State<GoodReceiptDetailContentScreen> createState() =>
      _GoodReceiptDetailContentScreenState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _GoodReceiptDetailContentScreenState
    extends State<GoodReceiptDetailContentScreen>
    with TickerProviderStateMixin {
  // late final TabController _tabController;

  @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 4, vsync: this);
  // }

  @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

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
          // IconButton(
          //   icon: const Icon(Icons.copy_all_outlined),
          //   onPressed: _copyToDocuments,
          // ),
          // IconButton(
          //   icon: const Icon(Icons.more_vert),
          //   onPressed: _setting,
          // ),
        ],
      ),
      body: ContentScreen(title: widget.title),
      // body: TabBarView(
      //   // controller: _tabController,
      //   children: <Widget>[
      //     HeaderScreen(ind: widget.ind),
      //     const ContentScreen(),
      //     const LogisticScreen(),
      //     const AccountScreen()
      //   ],
      // ),
    );
  }

  Future<void> createDocument() async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) MaterialDialog.loading(context, barrierDismissible: false);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      MaterialDialog.close(context);
      MaterialDialog.success(context,
          title: 'Oop', body: 'Internal Error Occur(1)');
    }
  }

  void _copyToDocuments() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 181,
          color: const Color.fromARGB(255, 237, 236, 236),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    createDocument();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Good Receipt PO",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    createDocument();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Direct Put It Away",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _setting() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 181,
          color: const Color.fromARGB(255, 237, 236, 236),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: createDocument,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Approve",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: createDocument,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Cancel Purchase Order",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: borderStyle,
                    child: const Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
