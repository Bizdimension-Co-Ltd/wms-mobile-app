import 'package:flutter/material.dart';
import 'package:wms_mobile/constant/style.dart';

class ListToDoItem extends StatefulWidget {
  const ListToDoItem({
    super.key,
  });
  @override
  State<ListToDoItem> createState() => _ListToDoItemState();
}

class _ListToDoItemState extends State<ListToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            // left: BorderSide(
            //   color: Color.fromARGB(255, 200, 196, 196),
            //   width: 0.5,
            // ),
            bottom: BorderSide(
              color: Color.fromARGB(255, 188, 183, 183),
              width: 0.5,
            ),
            // right: BorderSide(
            //   color: Color.fromARGB(255, 192, 188, 188),
            //   width: 0.5,
            // ),
          )),
      // padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 75.0,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 6,
              child: Container(
                child: Column(children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,  
                                child: Text(
                                  "AG001",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(flex: 2, child: Text("Ton")),
                            Expanded(flex: 2, child: Text("10/20")),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(flex: 7, child: Text("Testing Desc")),
                          ],
                        ),
                      ))
                ]),
              )),
          // Expanded(flex: 1, child: Container(child: Text("")))
        ],
      ),
    );
  }
}
