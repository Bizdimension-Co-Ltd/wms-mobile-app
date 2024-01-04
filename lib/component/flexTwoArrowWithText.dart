import 'package:flutter/material.dart';

class FlexTwoArrowWithText extends StatefulWidget {
  const FlexTwoArrowWithText(
      {super.key,
      required this.title,
      required this.value,
      this.textColor,
      this.simple,
      this.req,
      });
  final title;
  final value;
  final Color? textColor;
  final FontWeight? simple;
  final req;
  @override
  State<FlexTwoArrowWithText> createState() => _FlexTwoArrowWithTextState();
}

class _FlexTwoArrowWithTextState extends State<FlexTwoArrowWithText> {
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
          widget.req == "true"
              ? Row(
                  children: [
                    Text(
                      "${widget.title}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 116, 113, 113)),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      "*",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                  ],
                )
              : Text(
                  "${widget.title}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 116, 113, 113)),
                ),
          Container(
            child: Row(
              children: [
                Text(
                  "${widget.value}",
                  style: TextStyle(
                      fontWeight: widget.simple ?? FontWeight.bold,
                      color: widget.textColor ?? Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
