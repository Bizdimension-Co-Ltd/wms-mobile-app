import 'package:flutter/material.dart';

import '../../constant/style.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.label = '',
    this.placeholder = '',
    this.icon = Icons.arrow_forward_ios,
    // this.icon = Icons.content_copy_rounded,
    this.onPressed,
    this.iconSize = 15,
    this.controller,
    this.readOnly = false,
    this.onEditingComplete,
    this.initialValue = '',
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final IconData? icon;
  final double iconSize;
  final Function()? onPressed;
  final bool readOnly;
  final Function()? onEditingComplete;
  final String initialValue;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.right,
              readOnly: readOnly,
              onEditingComplete: onEditingComplete,
              style: TextStyle(fontSize: 14),
              keyboardType: keyboardType,
              // initialValue: initialValue,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                contentPadding: onPressed != null
                    ? const EdgeInsets.only(top: 14)
                    : const EdgeInsets.only(top: 0),
                hintText: placeholder,
                hintStyle: TextStyle(fontSize: 14),
                suffixIconConstraints: BoxConstraints(
                  maxWidth: 30,
                  minWidth: 30,
                ),
                suffixIcon: onPressed == null
                    ? SizedBox()
                    : IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          icon,
                          color: PRIMARY_COLOR,
                          size: iconSize,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
