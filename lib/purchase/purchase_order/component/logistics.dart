import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';

import '../../../constant/style.dart';

class LogisticScreen extends StatefulWidget {
  const LogisticScreen({super.key});

  @override
  State<LogisticScreen> createState() => _LogisticScreenState();
}

class _LogisticScreenState extends State<LogisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: PRIMARY_BG_COLOR,
      child: ListView(
        children: const [
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Ship To",
            values: "Phnom Penh, Cambodia",
          ),
          FlexTwo(
            title: "Bill To",
            values: "Ourussey Bill To battambang",
          ),
        ],
      ),
    );
  }
}
