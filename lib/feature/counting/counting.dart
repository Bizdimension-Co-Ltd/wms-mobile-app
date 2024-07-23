import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/feature/counting/bin_count/presentation/create_bin_count_screen.dart';
import 'package:wms_mobile/feature/counting/physical_count/presentation/create_physical_count_screen.dart';
import 'package:wms_mobile/feature/counting/quick_count/presentation/create_quick_count_screen.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';

import '../../constant/style.dart';
import '../../helper/helper.dart';

const gridList = [
  {"name": "Quick Count", "img": "refresh.svg"},
  {"name": "Cycle Count", "img": "history.svg"},
  {"name": "Physical Count", "img": "phy_count.svg"},
  {"name": "Bin Count", "img": "bin_count.svg"},
];

class Counting extends StatefulWidget {
  const Counting({super.key});

  @override
  State<Counting> createState() => _CountingState();
}

class _CountingState extends State<Counting> {
  final routes = [
    CreateQuickCountScreen(),
    CreateQuickCountScreen(),
    CreatePhysicalCountScreen(),
    CreateBinCountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          "Counting",
          style: TextStyle(
            color: Colors.white,
            fontSize: size(context).width * 0.045,
          ),
        ),
      ),
      body: Container(
          // padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: ListView.builder(
                  // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  shrinkWrap: true,
                  itemCount: gridList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: ListTile(
                        onTap: () {
                          if (!routes.asMap().containsKey(index)) {
                            MaterialDialog.success(context,
                                title: 'Oop',
                                body:
                                    '${gridList[index]['name']} is not implement yet!');
                            return;
                          }

                          goTo(context, routes[index]);
                        },
                        leading: SvgPicture.asset(
                          color: Color.fromARGB(235, 28, 60, 176),
                          "images/svg/${gridList[index]["img"]}",
                          width: size(context).width * 0.08,
                          height: size(context).width * 0.08,
                        ),
                        title: Text('${gridList[index]['name']}'),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
