import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/component/datePicker.dart';
import 'package:wms_mobile/loginScreen.dart';
import 'package:wms_mobile/mobile_function/countingScreen.dart';
import 'package:wms_mobile/mobile_function/inventoryScreen.dart';
import 'package:wms_mobile/mobile_function/packingScreen.dart';
import 'package:wms_mobile/mobile_function/receivingScreen.dart';
import 'package:wms_mobile/mobile_function/rmaScreen.dart';

const gridList = [
  {"name": "Receiving", "img": "call-received.svg"},
  {"name": "Inventory", "img": "building-warehouse.svg"},
  {"name": "RMA", "img": "return.svg"},
  {"name": "Counting", "img": "c.svg"},
  {"name": "Packing", "img": "package-24.svg"}
];

class WMSMobileScreen extends StatefulWidget {
  const WMSMobileScreen({super.key});

  @override
  State<WMSMobileScreen> createState() => _WMSMobileScreenState();
}

class _WMSMobileScreenState extends State<WMSMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dashboard),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout)),
          const SizedBox(
            width: 15,
          )
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "WMS Mobile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 223, 220, 220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Function",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: GridView.builder(
                    shrinkWrap: true, // use
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemCount: gridList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ReceivingScreen()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InventoryScreen()),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MRAScreen()),
                            );
                          } else if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CountingScreen()),
                            );
                          } else if (index == 4) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PackingScreen()),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "images/svg/${gridList[index]["img"]}",
                                width: 47,
                                height: 47,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                "${gridList[index]["name"]}",
                              ),
                            ],
                          )),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
