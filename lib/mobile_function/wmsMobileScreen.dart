import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WMSMobile extends StatefulWidget {
  const WMSMobile({super.key});

  @override
  State<WMSMobile> createState() => _WMSMobileState();
}

const gridList = [
  {"name": "Receiving", "img": "call-received.svg"},
   {"name": "Inventory", "img": "building-warehouse.svg"},
   {"name": "RMA", "img":"return.svg"},
   {"name":"Counting","img":"counting.svg"},
   {"name":"Packing", "img":"package-24.svg"}
];

class _WMSMobileState extends State<WMSMobile> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter layout demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,
        color: Colors.black,
        ),
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
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("images/svg/${gridList[index]["img"]}",
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
