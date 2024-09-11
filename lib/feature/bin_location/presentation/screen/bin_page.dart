import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/dio_client.dart';
import '../../data/model/bin_item_model.dart';
import '../../domain/entity/bin_entity.dart';
import '../cubit/bin_cubit.dart';
import '/constant/style.dart';

class BinPage extends StatefulWidget {
  const BinPage(
      {super.key, required this.warehouse, this.itemCode, this.fromBinlookUp});

  final String warehouse;
  final dynamic itemCode;
  final dynamic fromBinlookUp;
  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  String query = "?\$top=100&\$select=AbsEntry,BinCode,Warehouse,Sublevel1";

  bool loading = true;
  List<BinEntity> data = [];
  late BinCubit _bloc;
  final DioClient dio = DioClient();
  List<BinItemModel> qty = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getGetdataInit();
      _bloc = context.read<BinCubit>();
      final state = context.read<BinCubit>().state;

      if (state is BinData) {
        data = state.entities;
      }

      final exists = data.where((e) => e.warehouse == widget.warehouse);
      if (data.isEmpty || exists.isEmpty) {
        _bloc.get(widget.warehouse).then((value) {
          setState(() => data = value);
          _bloc.set(value);
        });
      }

      setState(() {
        data;
      });
    }
  }

  void getGetdataInit() async {
    try {
      if (widget.itemCode == "") {
        setState(() => loading = true);
        return;
      }

      final response = await dio.get(
          "/sml.svc/ITEM?\$filter=ItemCode eq '${widget.itemCode}' and WhsCode eq '${widget.warehouse}'");
      if (response.statusCode == 200) {
        setState(() {});

        qty = List.from(response.data["value"])
            .map((e) => BinItemModel.fromJson(e))
            .toList();
        loading = false;
        setState(() => qty);
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => qty = []);
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Bin Lists',
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
            const Divider(thickness: 0.001, height: 15),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 234, 235),
                border: Border(
                  bottom: BorderSide(width: 0.1),
                  top: BorderSide(width: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Bin Code',
                      style: TextStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: widget.fromBinlookUp == true
                          ? Text('')
                          : Text('Total Qty'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.01, height: 10),
            Expanded(
              child: BlocConsumer<BinCubit, BinState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingBin) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return loading
                      ? Container(
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
                      : ListView(
                          children: [
                            ...data.map(
                              (bin) {
                                BinItemModel? binItem;

                                final data = qty
                                    .where((e) => e.binCode == bin.code)
                                    .toList();
                                if (data.isNotEmpty) {
                                  binItem = data.first;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    // if (binItem == null) {
                                    //   MaterialDialog.warning(context,
                                    //       title: "Oop!",
                                    //       body:
                                    //           'Quantity fall into negative number -1.');

                                    //   return;
                                    // }

                                    Navigator.of(context).pop(bin);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(width: 0.1))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                bin.code,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child:
                                                  widget.fromBinlookUp == true
                                                      ? Text('')
                                                      : Text(
                                                          binItem?.onHandQty
                                                                  ?.toString() ??
                                                              "0.00",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            if (state is RequestingPaginationBin)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
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
