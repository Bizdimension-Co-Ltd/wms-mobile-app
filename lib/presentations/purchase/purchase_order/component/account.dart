import 'package:flutter/material.dart';
import 'package:wms_mobile/component/flexTwo.dart';
import 'package:wms_mobile/component/flexTwoArrow.dart';
import 'package:wms_mobile/constant/style.dart';


class AccountScreen extends StatefulWidget {
   final Map<String, dynamic> poAccount;

  const AccountScreen({super.key, required this.poAccount});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: PRIMARY_BG_COLOR,
      child: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          FlexTwo(
            title: "Journal Remark",
            values: widget.poAccount["JournalMemo"],
          ),
          FlexTwo(
            title: "Payment Terms",
          values: widget.poAccount["PaymentGroupCode"] ,
              
          ),
          FlexTwo(
            title: "Cancellation date",
           values: widget.poAccount["CancelDate"] ?? "",
              
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
