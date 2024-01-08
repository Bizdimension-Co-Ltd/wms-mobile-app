import 'package:flutter/material.dart';


class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.index,
    required this.selectedRadio,
    required this.onSelect,
    required this.data,
  }) : super(key: key);

  final int index;
  final int selectedRadio;
  final Function(int) onSelect;
  final List<Map<String, String>> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 233, 228, 228),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 80,
                child: Center(
                  child: Radio(
                     fillColor:
                        MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 65, 65, 69)),
                    value: index,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      onSelect(value as int);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data[index]["name"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text("${data[index]["sub"]}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
