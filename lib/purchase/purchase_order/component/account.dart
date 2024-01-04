import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 236, 233, 233),
      child: ListView(
        children: const [
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Journal Remark",
            values: "Purchase order - FUE0002",
          ),
          FlexTwo(
            title: "Payment Terms",
            values: "Net 30 Day",
          ),
          FlexTwo(
            title: "Cancellation date",
            values: "20-20-2023",
          ),
          SizedBox(
            height: 30,
          ),
          FlexTwoArrow(
            title: "Reference Document",
          )
        ],
      ),
    );
  }
}
