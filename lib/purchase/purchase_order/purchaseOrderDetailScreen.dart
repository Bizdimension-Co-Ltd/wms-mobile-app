// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:wms_mobile/purchase/purchase_order/component/account.dart';
import 'package:wms_mobile/purchase/purchase_order/component/content.dart';
import 'package:wms_mobile/purchase/purchase_order/component/header.dart';
import 'package:wms_mobile/purchase/purchase_order/component/logistics.dart';

/// Flutter code sample for [TabBar].

class PurchaseOrderDetailScreen extends StatefulWidget {
  const PurchaseOrderDetailScreen({super.key, required this.ind});
  final ind;
  @override
  State<PurchaseOrderDetailScreen> createState() =>
      _PurchaseOrderDetailScreenState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _PurchaseOrderDetailScreenState extends State<PurchaseOrderDetailScreen>
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
  TabBar get _tabBar => const TabBar(
        indicatorColor: Color.fromARGB(255, 17, 18, 48),
        unselectedLabelStyle: TextStyle(fontWeight: null),
        labelColor: Color.fromARGB(255, 17, 18, 48),
        //  isScrollable: true,
        // indicatorWeight: 5.0,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        tabs: [
          Tab(
            child: Text(
              "Header",
              // style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              "Contents",
              // style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              "Logistics",
              // style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              "Accounts",
              // style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 17, 18, 48),
          title: const Text(
            'Purchase Orders',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy_all_outlined),
              onPressed: () {
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
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
                                child: const Center(
                                    child: Text(
                                  "Good Receipt PO",
                                  style: TextStyle(fontSize: 15),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
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
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
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
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
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
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
                                child: const Center(
                                    child: Text(
                                  "Approve",
                                  style: TextStyle(fontSize: 15),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
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
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromARGB(255, 200, 196, 196),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 188, 183, 183),
                                        width: 0.5,
                                      ),
                                      right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color:
                                            Color.fromARGB(255, 192, 188, 188),
                                        width: 0.5,
                                      ),
                                    )),
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
              },
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Theme(
                  //<-- SEE HERE
                  data: ThemeData().copyWith(
                      splashColor: const Color.fromARGB(255, 221, 221, 225)),
                  child: _tabBar),
            ),
          ),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: <Widget>[
            HeaderScreen(ind: widget.ind),
            ContentScreen(),
            LogisticScreen(),
            AccountScreen()
          ],
        ),
      ),
    );
  }
}
