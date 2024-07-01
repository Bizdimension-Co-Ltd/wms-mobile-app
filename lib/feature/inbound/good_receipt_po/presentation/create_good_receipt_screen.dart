import 'package:flutter/material.dart';
import 'package:wms_mobile/component/form/input.dart';

import '../../../../constant/style.dart';

class CreateGoodReceiptScreen extends StatefulWidget {
  const CreateGoodReceiptScreen({super.key});

  @override
  State<CreateGoodReceiptScreen> createState() =>
      _CreateGoodReceiptScreenState();
}

class _CreateGoodReceiptScreenState extends State<CreateGoodReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Create Good Receipt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(
              label: 'Warehouse',
              placeholder: 'Warehouse',
              onPressed: () {},
            ),
            Input(
              label: 'PO. #',
              placeholder: 'PO DocNum',
              onPressed: () {},
            ),
            Input(
              label: 'Bin.',
              placeholder: 'Bin Location',
              onPressed: () {},
            ),
            Input(
              label: 'Item.',
              placeholder: 'Item',
              icon: Icons.document_scanner_outlined,
              onPressed: () {},
            ),
            Input(
              label: 'Quantity.',
              placeholder: 'Quantity',
            ),
            const SizedBox(height: 40),
            Text('ITEMS'),
            const SizedBox(height: 12),
            ContentHeader(),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...List.generate(30, (int index) => ItemRow())],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          bottom: BorderSide(width: 0.1),
          top: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Item No.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('UoM')),
          Expanded(child: Text('Qty/Op.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'LPG00000001',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Text('Litres')),
              Expanded(child: Text('10/20')),
            ],
          ),
          SizedBox(height: 6),
          Text('Lipsum generator: Lorem Ipsum - All the facts')
        ],
      ),
    );
  }
}
