import 'package:flutter/material.dart';
import 'package:wms_mobile/purchase/direct_put_away/create_screen/directPutAwayItemCreateScreen.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            left: BorderSide(
              color: Color.fromARGB(255, 222, 219, 219),
              width: 0.5,
            ),
            bottom: BorderSide(
              color: Color.fromARGB(255, 207, 202, 202),
              width: 0.5,
            ),
            right: BorderSide(
              color: Color.fromARGB(255, 215, 211, 211),
              width: 0.5,
            ),
          )),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(13, 7, 0, 9),
                    child: const Text(
                      "Regular 92",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 13),
                      child: const Text(
                        "FUE002",
                        style: TextStyle(fontSize: 14.5, color: Colors.grey),
                      )),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(13, 16, 0, 0),
                        width: 23,
                        height: 23,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 33, 47),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        width: 85,
                        height: 23,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 222, 219, 219),
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 207, 202, 202),
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: Color.fromARGB(255, 215, 211, 211),
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color: Color.fromARGB(255, 215, 211, 211),
                              width: 0.5,
                            ),
                          ),
                        ),
                        // child: const Center(child: Text("5")),
                        child: const TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.normal,
                              fontSize: 14.5),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 33, 47),
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        width: 23,
                        height: 23,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                padding: const EdgeInsets.only(right: 13),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DirectPutAwayItemCreateScreen()),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 122, 119, 119),
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      "Ton1390L",
                      style: TextStyle(
                          fontSize: 14.5,
                          color: Color.fromARGB(255, 72, 72, 81)),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    const Text(
                      "WH03 - WH03 - KST01",
                      style: TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 72, 72, 81)),
                    ),
                  ],
                ) // color: const Color.fromARGB(255, 65, 60, 199),
                ),
          ),
        ],
      ),
    );
  }
}
