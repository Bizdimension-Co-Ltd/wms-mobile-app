import 'package:flutter/material.dart';

class FlexTwoField extends StatefulWidget {
  const FlexTwoField({super.key, required this.title, required this.values});
  final title;
  final values;
  @override
  State<FlexTwoField> createState() => _FlexTwoFieldState();
}

class _FlexTwoFieldState extends State<FlexTwoField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                "${widget.title}:",
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: 'User Id',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal:
                          10.0), // Adjust the vertical and horizontal padding as needed
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(235, 28, 60, 176), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(235, 28, 60, 176), width: 2.0),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
