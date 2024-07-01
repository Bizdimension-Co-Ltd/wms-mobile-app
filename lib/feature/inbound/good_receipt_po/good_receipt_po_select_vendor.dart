import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/feature/inbound/good_receipt_po/good_receipt_po_create_screen.dart';
import 'package:wms_mobile/feature/inbound/good_receipt_po/presentation/cubit/purchase_order_cubit.dart';

import '../../../helper/helper.dart';

class GoodReceiptPOSelectVendor extends StatefulWidget {
  const GoodReceiptPOSelectVendor({
    super.key,
  });

  @override
  State<GoodReceiptPOSelectVendor> createState() =>
      _GoodReceiptPOSelectVendorState();
}

class _GoodReceiptPOSelectVendorState extends State<GoodReceiptPOSelectVendor> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=10&\$skip=0";

  int _skip = 0;

  int check = 1;
  TextEditingController filter = TextEditingController();
  List<dynamic> data = [];
  late PurchaseOrderCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<PurchaseOrderCubit>();
      _bloc.get(query).then((value) => setState(() => data = value));

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final state = BlocProvider.of<PurchaseOrderCubit>(context).state;
          if (state is PurchaseOrderData && data.length > 0) {
            _bloc
                .next(
                    "?\$top=10&\$skip=${data.length}&\$filter=contains(CardCode,'${filter.text}')")
                .then((value) {
              if (!mounted) return;

              setState(() => data = [...data, ...value]);
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    filter.dispose();

    super.dispose();
  }

  void onFilter() async {
    setState(() {
      data = [];
    });
    _bloc
        .get("$query&\$filter=CardCode contains(CardCode, '${filter.text}')")
        .then((value) {
      if (!mounted) return;

      setState(() => data = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Purchase Order Lists',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      // bottomNavigationBar: MyBottomSheet(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 243, 243, 243),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 14, right: 14, bottom: 6, top: 4),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: TextFormField(
                controller: filter,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  contentPadding: const EdgeInsets.only(top: 15),
                  hintText: 'Supplier Code...',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: PRIMARY_COLOR,
                    ),
                    onPressed: onFilter,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            const Divider(thickness: 0.1, height: 15),
            Expanded(
              child: BlocConsumer<PurchaseOrderCubit, PurchaseOrderState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingPurchaseOrder) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                    children: [
                      ...data
                          .map(
                            (po) => Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getDataFromDynamic(po['DocNum']),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        'Doc Date : ${getDataFromDynamic(po['DocDueDate'], isDate: true)}',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          getDataFromDynamic(po['Comments']),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Text(
                                        'Dilvery Date : ${getDataFromDynamic(po['DocDate'], isDate: true)}',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationPurchaseOrder)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
