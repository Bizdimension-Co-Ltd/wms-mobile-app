import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key, required this.grrAccount});
  Map<String, dynamic> grrAccount;
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
        children: [
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Journal Remark",
            values: "${widget.grrAccount["JournalMemo"] ?? ""}",
          ),
          FlexTwo(
            title: "Payment Terms",
           values: "${widget.grrAccount["PaymentGroupCode"] ?? ""}",
          ),
          FlexTwo(
            title: "Cancellation date",
            values: "${widget.grrAccount["CancelDate"] ?? ""}",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
