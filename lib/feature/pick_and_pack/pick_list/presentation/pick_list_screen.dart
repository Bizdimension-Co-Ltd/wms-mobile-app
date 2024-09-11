import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wms_mobile/component/button/button.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/domain/entity/find_picking_list_entity.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/presentation/cubit/pick_list_cubit.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/presentation/pick/picking_screen.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/presentation/review_pick_list_screen.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import '../../../../component/form/input.dart';
import '../../../../constant/style.dart';

class PickListScreen extends StatefulWidget {
  const PickListScreen({super.key});

  @override
  State<PickListScreen> createState() => _PickListScreenState();
}

class _PickListScreenState extends State<PickListScreen> {
  final pickNumberText = TextEditingController();
  final totalItem = TextEditingController();
  final totalQty = TextEditingController();
  final pickedQty = TextEditingController();
  final openQty = TextEditingController();
  final lastPick = TextEditingController();
  final picker = TextEditingController();
  final status = TextEditingController();

  bool loading = false;
  PickListEntity? picking;

  late PickListCubit _bloc;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _bloc = context.read<PickListCubit>();
    }
  }

  void onFindPickList() async {
    try {
      clearInput();

      if (pickNumberText.text == '') {
        throw Exception("Pick Number can not be empty.");
      }

      setState(() => loading = true);
      final data = await _bloc.find(int.parse(pickNumberText.text));

      totalItem.text = data.pickListsLines?.length.toString() ?? "0.00";
      totalQty.text = data.pickListsLines
              ?.fold(
                0.00,
                (prev, next) =>
                    prev + (next.previouslyReleasedQuantity ?? 0.00),
              )
              .toString() ??
          '0.00';
      pickedQty.text = data.pickListsLines
              ?.fold(0.00, (prev, next) => prev + (next.pickedQuantity ?? 0.00))
              .toString() ??
          '0.00';
      openQty.text = data.pickListsLines
              ?.fold(
                  0.00, (prev, next) => prev + (next.releasedQuantity ?? 0.00))
              .toString() ??
          '0.00';
      if (data.pickDate != null) {
        lastPick.text =
            DateFormat('dd-MM-yyyy').format(data.pickDate ?? DateTime.now());
      }
      picker.text = data.name ?? "";
      status.text = data.status?.replaceAll("ps_", "") ?? "";

      setState(() {
        loading = false;
        picking = data;
      });
    } catch (e) {
      if (mounted) {
        setState(() => loading = false);
        MaterialDialog.warning(
          context,
          title: 'Not Found',
          body: 'Pick List Number (${pickNumberText.text}) not exist.',
        );
      }
    }
  }

  void clearInput() {
    totalItem.text = '';
    totalQty.text = '';
    pickedQty.text = '';
    openQty.text = '';
    lastPick.text = '';
    picker.text = '';
    status.text = '';
  }

  @override
  void dispose() {
    pickNumberText.dispose();
    totalItem.dispose();
    totalQty.dispose();
    pickedQty.dispose();
    openQty.dispose();
    lastPick.dispose();
    picker.dispose();
    status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Picking',
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
                onEditingComplete: () async {
                  await Future.delayed(const Duration(milliseconds: 100));
                  onFindPickList();
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: size(context).width,
                height: size(context).height * 0.08,
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        onPressed: onFindPickList,
                        disabled: loading,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (loading)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: size(context).width * 0.03,
                                height: size(context).width * 0.03,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            const Text(
                              'Look Up',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Button(
                        onPressed: () {
                          if (loading || picking == null) return;

                          goTo(
                            context,
                            PickingScreen(picking: picking!),
                          );
                        },
                        disabled: loading || picking == null,
                        child: Text(
                          'Go Pick',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Button(
                        onPressed: () {
                          if (loading || picking == null) return;

                          goTo(
                            context,
                            ReviewPickListScreen(pickList: picking!),
                          ).then((onValue) => clearInput());
                        },
                        disabled: loading || picking == null,
                        child: Text(
                          'Review',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Input(
                label: 'Total Items',
                placeholder: 'Total Items',
                readOnly: true,
                controller: totalItem,
              ),
              Input(
                label: 'Total Qty',
                readOnly: true,
                placeholder: 'Total Qty',
                controller: totalQty,
              ),
              Input(
                label: 'Picked Qty',
                readOnly: true,
                placeholder: 'Picked Qty',
                controller: pickedQty,
              ),
              Input(
                label: 'Open Qty',
                readOnly: true,
                placeholder: 'Open Qty',
                controller: openQty,
              ),
              Input(
                label: 'Last Picked',
                placeholder: 'Last Picked',
                readOnly: true,
                controller: lastPick,
              ),
              Input(
                label: 'Picker',
                placeholder: 'Picker',
                readOnly: true,
                controller: picker,
              ),
              Input(
                label: 'Status',
                placeholder: 'Status',
                readOnly: true,
                controller: status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
