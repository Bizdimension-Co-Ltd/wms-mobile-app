import 'package:flutter/material.dart';
import '../../constant/style.dart';

class InputCol extends StatelessWidget {
  const InputCol(
      {super.key,
      this.label = '',
      this.placeholder = '',
      this.icon = Icons.arrow_forward_ios,
      this.onPressed,
      this.iconSize = 15,
      this.controller,
      this.readOnly = false,
      this.onEditingComplete,
      this.initialValue = '',
      this.keyboardType = TextInputType.text,
      this.onTap});

  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final IconData? icon;
  final double iconSize;
  final Function()? onPressed;
  final Function()? onTap;
  final bool readOnly;
  final Function()? onEditingComplete;
  final String initialValue;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Label text
        Text(
          label,
          style: TextStyle(
              fontSize: 14.3,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade700),
        ),

        const SizedBox(height: 10),

        // ✅ Input container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onEditingComplete: onEditingComplete,
            style: const TextStyle(fontSize: 14),
            keyboardType: keyboardType,
            textAlign: TextAlign.left,
            onTap: onTap, // ✅ use this
            decoration: InputDecoration(
              contentPadding: onPressed != null
                  ? const EdgeInsets.only(top: 14)
                  : const EdgeInsets.only(top: 0),
              hintText: placeholder,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 30,
                minWidth: 30,
              ),
              suffixIcon: onPressed == null
                  ? const SizedBox()
                  : IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        icon,
                        color: PRIMARY_COLOR,
                        size: iconSize,
                      ),
                    ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
