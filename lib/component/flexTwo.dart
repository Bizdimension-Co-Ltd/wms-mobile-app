import 'package:flutter/material.dart';

class FlexTwo extends StatefulWidget {
  const FlexTwo({super.key, required this.title, required this.values});
  final title;
  final values;
  @override
  State<FlexTwo> createState() => _FlexTwoState();
}

class _FlexTwoState extends State<FlexTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            left: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
            top: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
            right: BorderSide(
              color: Color.fromARGB(255, 215, 213, 213),
              width: 0.5,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.title}",
            style: const TextStyle(color: Color.fromARGB(255, 116, 113, 113)),
          ),
          Text(
            "${widget.values}",
            style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
