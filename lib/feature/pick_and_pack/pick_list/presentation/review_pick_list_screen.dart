import 'package:flutter/material.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';
import '../../../../component/form/input.dart';
import '../../../../constant/style.dart';
import '../../../../helper/helper.dart';

class ReviewPickListScreen extends StatefulWidget {
  const ReviewPickListScreen({super.key, required this.pickList});

  final PickListEntity pickList;

  @override
  State<ReviewPickListScreen> createState() => _ReviewPickListScreenState();
}

class _ReviewPickListScreenState extends State<ReviewPickListScreen> {
  final pickNumberText = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    pickNumberText.text = widget.pickList.absoluteentry.toString();

    super.initState();
  }

  @override
  void dispose() {
    pickNumberText.dispose();
    super.dispose();
  }

  String getTotalItems() {
    return widget.pickList.pickListsLines?.length.toStringAsFixed(2) ?? '0.00';
  }

  String getTotalRelease() {
    return widget.pickList.pickListsLines
            ?.fold(
                0.00,
                (prev, next) =>
                    prev + (next.previouslyReleasedQuantity ?? 0.00))
            .toStringAsFixed(2) ??
        '0.00';
  }

  String getTotalPicked() {
    return widget.pickList.pickListsLines
            ?.fold(0.00, (prev, next) => prev + (next.pickedQuantity ?? 0.00))
            .toStringAsFixed(2) ??
        '0.00';
  }

  String getTotalOpen() {
    return widget.pickList.pickListsLines
            ?.fold(0.00, (prev, next) => prev + (next.releasedQuantity ?? 0.00))
            .toStringAsFixed(2) ??
        '0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Review - Pick List',
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
                  label: 'Warehouse',
                  placeholder: 'Warehouse',
                  readOnly: true,
                  onPressed: () {},
                ),
                Input(
                  label: 'Pick List',
                  placeholder: 'Pick List',
                  controller: pickNumberText,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text('Total Items : ${getTotalItems()}'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text('Total Qty. : ${getTotalRelease()}'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text('Picked Qty. : ${getTotalPicked()}'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                      ),
                      child: Text('Open Qty. : ${getTotalOpen()}'),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                ContentHeader(),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.pickList.pickListsLines
                              ?.map((item) => GestureDetector(
                                    child: ItemRow(item: item),
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
              'Item No.',
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
  const ItemRow({super.key, required this.item});

  final PickListsLineEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  getDataFromDynamic(item.itemCode),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text('${item.pickedQuantity}/${item.releasedQuantity}'),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(getDataFromDynamic(item.itemDescription))
        ],
      ),
    );
  }
}
