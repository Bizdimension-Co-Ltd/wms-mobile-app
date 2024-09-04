import 'package:flutter/material.dart';

import '../../../../component/form/input.dart';
import '../../../../constant/style.dart';
import '../../../../helper/helper.dart';
import '../domain/entity/find_picking_list_entity.dart';

class ReviewItemSerialScreen extends StatelessWidget {
  const ReviewItemSerialScreen({super.key, required this.entity});

  final PickListsLineEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Picking / Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size(context).height,
              maxHeight: size(context).height,
              minWidth: size(context).width,
              maxWidth: size(context).width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  label: 'Pick List',
                  placeholder: 'Pick List',
                  readOnly: true,
                  initialValue: entity.absoluteEntry?.toString() ?? '-1',
                  onPressed: () {},
                ),
                Input(
                  label: 'Item Code',
                  placeholder: 'Item Code',
                  initialValue: entity.itemCode ?? "",
                  keyboardType: TextInputType.number,
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text('#Serials. : ${entity.releasedQuantity}'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text(
                          'Total Qty. : ${entity.previouslyReleasedQuantity}'),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ContentHeader(),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: entity.serialNumbers
                              ?.map((item) => GestureDetector(
                                    child: ItemRow(
                                      item: item,
                                    ),
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              'Serial No.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text('Qty.')),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.item,
  });

  final SerialNumberEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    getDataFromDynamic(item.internalSerialNumber),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('${item.quantity}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
