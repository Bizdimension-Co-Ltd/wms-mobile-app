import 'package:flutter/material.dart';

class FlexTwoArrow extends StatefulWidget {
  const FlexTwoArrow({super.key, required this.title});
  final title;
  @override
  State<FlexTwoArrow> createState() => _FlexTwoArrowState();
}

class _FlexTwoArrowState extends State<FlexTwoArrow> {
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
          const Icon(
            Icons.arrow_forward_ios,
           color: Colors.grey,
            size: 18,
          ),
        ],
      ),
    );
  }
}
