import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_mobile/loginScreen.dart';

const gridList = [
  {"name": "Store Request", "img": "request-changes.svg"},
  {"name": "Good Issue", "img": "document-subtract.svg"},
  {"name": "Good Receipt", "img": "document-add.svg"},
  {"name": "Transfer Receipt", "img": "document-preliminary.svg"},
  {"name": "Warehouse Tranfer", "img": "building-warehouse.svg"},
  {"name": "Bin Tranfer", "img": "shopping-cart-arrow-up.svg"},
  {"name": "Bin Replenishment", "img": "replace.svg"}
];

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
         iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Inventory",
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
              // const Text(
              //   "Function",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
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
                      return Container(
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
                      );
                    }),
              )
            ],
          )),
    );
  }
}
