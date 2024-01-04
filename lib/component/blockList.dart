import 'package:flutter/material.dart';

class BlockList extends StatefulWidget {
  const BlockList(
      {super.key,
      required this.name,
      required this.date,
      required this.status,
      required this.qty});

  final name;
  final date;
  final status;
  final qty;
  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border(
              left: BorderSide(
                color: Color.fromARGB(255, 200, 196, 196),
                width: 0.5,
              ),
              bottom: BorderSide(
                color: Color.fromARGB(255, 188, 183, 183),
                width: 0.5,
              ),
              right: BorderSide(
                color: Color.fromRGBO(192, 188, 188, 1),
                width: 0.5,
              ),
            )),
        padding: const EdgeInsets.all(5),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "${widget.status}",
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 15),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.date}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 106, 103, 103)),
                              ),
                              Text(
                                "${widget.qty}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 106, 103, 103)),
                              )
                            ],
                          ),
                        ))
                  ]),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
