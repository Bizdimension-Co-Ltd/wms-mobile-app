import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/outbounce/purchase_return_request/presentation/cubit/purchase_return_request_cubit.dart';
import '/constant/style.dart';
import '/utilies/storage/locale_storage.dart';

import '../../../../helper/helper.dart';

class PurchaseReturnRequestPage extends StatefulWidget {
  const PurchaseReturnRequestPage({
    super.key,
  });

  @override
  State<PurchaseReturnRequestPage> createState() =>
      _PurchaseReturnRequestPageState();
}

class _PurchaseReturnRequestPageState extends State<PurchaseReturnRequestPage> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=10&\$skip=0";

  int check = 1;
  TextEditingController filter = TextEditingController();
  List<dynamic> data = [];
  late PurchaseReturnRequestCubit _bloc;

  @override
  void initState() {
    super.initState();
    init(context);
  }

  void init(BuildContext context) async {
    try {
      final warehouse = await LocalStorageManger.getString('warehouse');

      _bloc = context.read<PurchaseReturnRequestCubit>();
      _bloc
          .get(
              "$query&\$filter=DocumentStatus eq 'bost_Open' and U_tl_whsdesc eq '$warehouse'")
          .then((value) => setState(() => data = value));

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final state =
              BlocProvider.of<PurchaseReturnRequestCubit>(context).state;
          if (state is PurchaseReturnRequestData && data.length > 0) {
            _bloc
                .next(
                    "?\$top=10&\$skip=${data.length}&\$filter=DocumentStatus eq 'bost_Open' and U_tl_whsdesc eq '$warehouse' and contains(CardCode,'${filter.text}')")
                .then((value) {
              if (!mounted) return;

              setState(() => data = [...data, ...value]);
            });
          }
        }
      });
    } catch (err) {
      print(err);
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

    final warehouse = await LocalStorageManger.getString('warehouse');
    _bloc
        .get(
            "$query&\$filter=DocumentStatus eq 'bost_Open' and U_tl_whsdesc eq '$warehouse' contains(CardCode, '${filter.text}')")
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
          'Return To Supplier Request Lists - OPEN',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
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
                  hintText: 'Vendor Code...',
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
              child: BlocConsumer<PurchaseReturnRequestCubit,
                  PurchaseReturnRequestState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingPurchaseReturnRequest) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                    children: [
                      ...data
                          .map(
                            (po) => GestureDetector(
                              onTap: () => Navigator.of(context).pop(po),
                              child: Container(
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
                                          "${getDataFromDynamic(po['CardCode'])} - ${getDataFromDynamic(po['DocNum'])}",
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
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationPurchaseReturnRequest)
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
