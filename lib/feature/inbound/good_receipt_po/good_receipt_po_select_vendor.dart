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

            // Container(
            //   color: Colors.white,
            //   height: 100,
            //   padding: EdgeInsets.all(5),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         height: 40,
            //         padding: EdgeInsets.only(left: 20),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 flex: 3,
            //                 child: TextField(
            //                   controller: filter,
            //                   decoration: InputDecoration(
            //                     border: OutlineInputBorder(),
            //                     // hintText: 'User Id',
            //                     isDense: true,
            //                     contentPadding: EdgeInsets.symmetric(
            //                         vertical: 8.0,
            //                         horizontal:
            //                             10.0), // Adjust the vertical and horizontal padding as needed
            //                     enabledBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                           color: Color.fromARGB(235, 28, 60, 176),
            //                           width: 2.0),
            //                     ),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                           color: Color.fromARGB(235, 28, 60, 176),
            //                           width: 2.0),
            //                     ),
            //                   ),
            //                 )),
            //             Expanded(
            //                 flex: 1,
            //                 child: Row(
            //                   children: [
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     SvgPicture.asset(
            //                       width: 30,
            //                       height: 30,
            //                       color: Colors.black,
            //                       "images/svg/book.svg",
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     GestureDetector(
            //                       onTap: () async {
            //                         await getListPurchaseOrder();
            //                       },
            //                       child: SvgPicture.asset(
            //                         width: 30,
            //                         height: 30,
            //                         color: Color.fromARGB(235, 28, 60, 176),
            //                         "images/svg/search.svg",
            //                       ),
            //                     ),
            //                   ],
            //                 )),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 538,
            //   child: check == 0
            //       ? Container(
            //           height: 550,
            //           child: const Center(
            //             child: CircularProgressIndicator.adaptive(
            //               strokeWidth: 2.5,
            //             ),
            //           ),
            //         )
            //       : data.length == 0
            //           ? Center(child: Text("No Record"))
            //           : ListView.builder(
            //               padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
            //               shrinkWrap: true,
            //               itemCount: data.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return GestureDetector(
            //                     onTap: () {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) =>
            //                                 GoodReceiptPOCreateScreen(
            //                                     data: data[index]),
            //                           ));
            //                     },
            //                     child: BlockList(
            //                       number: data[index]["DocNum"],
            //                       desc: data[index]["Comments"] == ""
            //                           ? "N/A"
            //                           : data[index]["Comments"],
            //                       date: splitDate(data[index]["DocDate"]),
            //                       date2: splitDate(data[index]["DocDueDate"]),
            //                     ));
            //               },
            //             ),
            // )
          ],
        ),
      ),
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoodReceiptPOCreateScreen(
                        data: {},
                      ),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 12, 112, 32),
                    borderRadius: BorderRadius.circular(5)),
                width: 130,
                child: Center(
                  child: Text(
                    "Receipt",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(238, 16, 50, 171),
                  borderRadius: BorderRadius.circular(5)),
              width: 130,
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
