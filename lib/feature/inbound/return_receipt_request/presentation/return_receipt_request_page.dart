import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/core/enum/global.dart';
import '/constant/style.dart';
import '/feature/inbound/good_receipt_po/presentation/create_good_receipt_screen.dart';
import '/utilies/storage/locale_storage.dart';

import '../../../../helper/helper.dart';
import 'cubit/return_receipt_request_cubit.dart';

class ReturnReceiptRequestPage extends StatefulWidget {
  const ReturnReceiptRequestPage({
    super.key, required this.type,
  });
  final BusinessPartnerType type;

  @override
  State<ReturnReceiptRequestPage> createState() =>
      _ReturnReceiptRequestPageState();
}

class _ReturnReceiptRequestPageState extends State<ReturnReceiptRequestPage> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=10&\$skip=0";

  int check = 1;
  TextEditingController filter = TextEditingController();
  List<dynamic> data = [];
  late ReturnReceiptRequestCubit _bloc;

  @override
  // void initState() {
  //   super.initState();
  //   init(context);
  // }

  // void init(BuildContext context) async {
  //   try {
  //     final warehouse = await LocalStorageManger.getString('warehouse');

  //     _bloc = context.read<ReturnReceiptRequestCubit>();
  //     _bloc
  //         .get(
  //             "$query&\$filter=DocumentStatus eq 'bost_Open' and U_tl_whsdesc eq '$warehouse'")
  //         .then((value) => setState(() => data = value));

  //     _scrollController.addListener(() {
  //       if (_scrollController.position.pixels ==
  //           _scrollController.position.maxScrollExtent) {
  //         final state =
  //             BlocProvider.of<ReturnReceiptRequestCubit>(context).state;
  //         if (state is ReturnReceiptRequestData && data.length > 0) {
  //           _bloc
  //               .next(
  //                   "?\$top=10&\$skip=${data.length}&\$filter=DocumentStatus eq 'bost_Open' and U_tl_whsdesc eq '$warehouse' and contains(CardCode,'${filter.text}')")
  //               .then((value) {
  //             if (!mounted) return;

  //             setState(() => data = [...data, ...value]);
  //           });
  //         }
  //       }
  //     });
  //   } catch (err) {
  //     print(err);
  //   }
  // }
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<ReturnReceiptRequestCubit>();
      final state = context.read<ReturnReceiptRequestCubit>().state;

      if (state is ReturnReceiptRequestData) {
        data = state.entities;
      }

      if (data.length == 0) {
        _bloc
            .get("$query&\$filter=${getBPTypeQueryString(widget.type)}")
            .then((value) {
          setState(() => data = value);
          _bloc.set(value);
        });
      }

      setState(() {
        data;
      });

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final state = BlocProvider.of<ReturnReceiptRequestCubit>(context).state;
          if (state is ReturnReceiptRequestData && data.length > 0) {
            _bloc
                .next(
                    "?\$top=10&\$skip=${data.length}&\$filter=${getBPTypeQueryString(widget.type)} and contains(CardCode,'${filter.text}')")
                .then((value) {
              if (!mounted) return;
              _bloc.set([...data, ...value]);
              setState(() => data = [...data, ...value]);
            });
          }
        }
      });
    }
  }
    void dispose() {
    _scrollController.dispose();
    filter.dispose();

    super.dispose();
  }

  void onFilter() async {
    setState(() {
      data = [];
    });
    _bloc
        .get(
            "$query&\$filter=${getBPTypeQueryString(widget.type)} and contains(CardCode, '${filter.text}')")
        .then((value) {
      if (!mounted) return;

      setState(() => data = value);
    });
  }

  void onPressed(dynamic bp) {
    Navigator.pop(context, bp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Business Partner Lists',
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
                  hintText: 'BusinessPartner Code...',
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
              child: BlocConsumer<ReturnReceiptRequestCubit,
                  ReturnReceiptRequestState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingReturnReceiptRequest) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                     children: [
                      ...data
                          .map(
                            (bp) => GestureDetector(
                              onTap: () => onPressed(bp),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getDataFromDynamic(bp['CardCode']),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      getDataFromDynamic(bp['CardName']),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationReturnReceiptRequest)
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
