import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/listDocument.dart';
import 'package:wms_mobile/purchase/direct_put_away/component/listOffLineDocument.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayCreateScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/// Flutter code sample for [TabBar].

class DirectPutAwayListScreen extends StatefulWidget {
  const DirectPutAwayListScreen({super.key});

  @override
  State<DirectPutAwayListScreen> createState() =>
      _DirectPutAwayListScreenState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _DirectPutAwayListScreenState extends State<DirectPutAwayListScreen>
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
  TabBar get _tabBar => TabBar(
        indicatorColor: const Color.fromARGB(255, 17, 18, 48),
        unselectedLabelStyle: const TextStyle(fontWeight: null),
        labelColor: const Color.fromARGB(255, 17, 18, 48),
        //  isScrollable: true,
        // indicatorWeight: 5.0,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        tabs: [
          Tab(
              child: SvgPicture.asset(
            "images/svg/document-preliminary.svg",
            width: 25,
          )),
          Tab(
              child: SvgPicture.asset(
            "images/svg/cloud-offline-outline.svg",
            width: 25,
          )),
          Tab(
              child: SvgPicture.asset(
            "images/svg/x.svg",
            width: 25,
          )),
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
            'Good Return Request',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            const SizedBox(
              width: 10,
            )
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
            const TabBarView(
              // controller: _tabController,
              children: <Widget>[ListDocument(), ListOffLineDocument()],
            ),
            Positioned(
                bottom:30,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DirectPutAwayCreateScreen()),
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
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
