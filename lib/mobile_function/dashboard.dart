import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/feature/counting/counting.dart';
import 'package:wms_mobile/feature/list_batch/presentation/screen/batch_list_page.dart';
import 'package:wms_mobile/feature/list_serial/presentation/screen/Serial_list_page.dart';
import 'package:wms_mobile/feature/lookup/lookup.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/feature/outbounce/outbound.dart';
import 'package:wms_mobile/feature/serial/good_receip_serial_screen.dart';
import 'package:wms_mobile/form/datePicker.dart';
import 'package:wms_mobile/feature/middleware/presentation/login_screen.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/mobile_function/countingScreen.dart';
import 'package:wms_mobile/feature/inbound/inbound.dart';
import 'package:wms_mobile/mobile_function/inventoryScreen.dart';
import 'package:wms_mobile/mobile_function/packingScreen.dart';
import 'package:wms_mobile/mobile_function/receivingScreen.dart';
import 'package:wms_mobile/mobile_function/rmaScreen.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';

import '../constant/style.dart';

const gridList = [
  {"name": "Inbound", "img": "download.svg"},
  {"name": "Outbound", "img": "upload.svg"},
  {"name": "Pick & Pack", "img": "heigth.svg"},
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
  String warehouseName = '';
  void _logout(BuildContext context) {
    MaterialDialog.loading(context);

    const timeoutDuration = Duration(seconds: 1);
    Future.delayed(timeoutDuration, () {
      BlocProvider.of<AuthorizationBloc>(context)
          .add(const RequestLogoutEvent());
    });
  }

  void onPressMenu(BuildContext context, int index) {
    switch (index) {
      case 0:
        goTo(context, const Inbound());
        break;
      case 1:
        goTo(context, const Outbound());
        break;
      case 3:
        goTo(context, const Counting());
        break;
      case 4:
        goTo(context, const ProductLookUp());
        break;
      case 5:
        _logout(context);

        // goTo(context, const LoginScreen());
        // goTo(
        //     context,
        //     const SerialListPage(
        //       warehouse: '',
        //     ));
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
    final name = await LocalStorageManger.getString('warehouseName');

    setState(() {
      warehouseCode = value;
      warehouseName = name;
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
          child: GestureDetector(
              onTap: () {
                // goTo(
                //     context,
                //     const BatchListPage(
                //       warehouse: '',
                //     ));
              },
              child: Icon(Icons.dashboard, color: Colors.white)),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: PRIMARY_COLOR,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              warehouseName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
        actions: [
          Text(
            warehouseCode,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 17,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Row(
                  children: const [
                    Icon(Icons.circle,
                        color: Color.fromARGB(255, 217, 217, 222)),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Main Menu",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: PRIMARY_COLOR)),
                  ],
                ),
              ),
              SizedBox(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: gridList.length,
                itemBuilder: (BuildContext context, int index) {
                  final isLast =
                      index == gridList.length - 1; // 👈 check last index

                  return GestureDetector(
                    onTap: () {
                      onPressMenu(context, index);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 22, 12, 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 242, 243, 244),
                      ),
                      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                color: isLast ? Colors.red : const Color.fromARGB(255, 18, 22, 157),
                                "images/svg/${gridList[index]["img"]}",
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${gridList[index]['name']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.5,
                                  color: isLast ? Colors.red : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          isLast
                              ? const SizedBox() // 👈 hide arrow for last item
                              : Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }
}
