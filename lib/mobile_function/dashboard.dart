import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/form/datePicker.dart';
import 'package:wms_mobile/feature/middleware/presentation/login_screen.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/mobile_function/countingScreen.dart';
import 'package:wms_mobile/feature/inbound/inbound.dart';
import 'package:wms_mobile/mobile_function/inventoryScreen.dart';
import 'package:wms_mobile/mobile_function/packingScreen.dart';
import 'package:wms_mobile/mobile_function/receivingScreen.dart';
import 'package:wms_mobile/mobile_function/rmaScreen.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';

import '../constant/style.dart';

const gridList = [
  {"name": "Inbound", "img": "download.svg"},
  {"name": "Outbound", "img": "upload.svg"},
  {"name": "Pick & Pack", "img": "heigth.svg"},
  {"name": "Transfer", "img": "transfer.svg"},
  {"name": "Counting", "img": "counting1.svg"},
  {"name": "Lookup", "img": "look.svg"},
  {"name": "Log Out", "img": "logout1.svg"}
];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String warehouseCode = '';

  void onPressMenu(BuildContext context, int index) {
    switch (index) {
      case 0:
        goTo(context, const Inbound());
        break;
      case 6:
        goTo(context, const LoginScreen());
        break;
      default:
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final value = await LocalStorageManger.getString('warehouse');
    setState(() {
      warehouseCode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(14), // Add some padding if necessary
          child: SvgPicture.asset(
            "images/svg/menu.svg",
            color: Colors.white,
            fit: BoxFit.contain, // Ensure the SVG fits within the container
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          "Main Menu",
          style: TextStyle(
            color: Colors.white,
            fontSize: size(context).width * 0.045,
          ),
        ),
        actions: [
          Text(
            warehouseCode,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: size(context).width * 0.045,
            ),
          ),
          const SizedBox(width: 15),
        ],
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
                        onTap: () => onPressMenu(context, index),
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
