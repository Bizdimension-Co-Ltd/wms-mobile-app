import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/account.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/content.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/header.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/logistics.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayCreateScreen.dart';

/// Flutter code sample for [TabBar].

class DirectPutAwayDetailScreens extends StatefulWidget {
  const DirectPutAwayDetailScreens({super.key, required this.ind});
  final ind;
  @override
  State<DirectPutAwayDetailScreens> createState() =>
      _DirectPutAwayDetailScreenState();
}

class _DirectPutAwayDetailScreenState extends State<DirectPutAwayDetailScreens>
    with TickerProviderStateMixin {
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
            'Good Receipt PO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.cloud_upload_rounded),
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Sync To SAP',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Row(
                            children: const [
                              Text('Are you sure want to sync this to'),
                              SizedBox(width: 5),
                              Text(
                                'SAP ?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('No',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Container(
                                  width: 75,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 17, 18, 48),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Center(
                                      child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            ),
                          ],
                        ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 230,
                      color: const Color.fromARGB(255, 237, 236, 236),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);

                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                            'Good Receipt PO',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          content: SizedBox(
                                            width: double.infinity,
                                            height: 120,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                    'Closing a document is irreversible. Document '
                                                    'status will be change to "Closed" and a clearing'
                                                    'transactions will be created.'),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                    "Do you want to continue ?")
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('No',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Container(
                                                  width: 75,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 17, 18, 48),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: const Center(
                                                      child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))),
                                            ),
                                          ],
                                        ));
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
                                  "Close",
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
                                  "Cancel Good Receipt PO",
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
                                  "Duplicate",
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
        body: Stack(
          children: [
            TabBarView(
              // controller: _tabController,
              children: <Widget>[
                HeaderScreen(ind: widget.ind),
                ContentScreen(),
                LogisticScreen(),
                AccountScreen()
              ],
            ),
            Positioned(
                bottom: 30,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                               DirectPutAwayCreateScreen(ind: widget.ind,)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 111, 115, 119),
                            blurRadius: 10,
                            offset: Offset(2, 5), // Shadow position
                          ),
                        ],
                        color: const Color.fromARGB(255, 17, 18, 48),
                        borderRadius: BorderRadius.circular(100.0)),
                    width: 60,
                    height: 60,
                    child: Center(
                        child: SvgPicture.asset(
                      "images/svg/edit.svg",
                      color: Colors.white,
                    )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
