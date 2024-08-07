import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/helper/helper.dart';
import 'package:wms_mobile/mobile_function/dashboard.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';
import '/constant/style.dart';
import '/feature/warehouse/domain/entity/warehouse_entity.dart';
import '/feature/warehouse/presentation/cubit/warehouse_cubit.dart';

class WarehousePage extends StatefulWidget {
  const WarehousePage({super.key, this.isPicker = false});

  final bool isPicker;

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=10&\$skip=0&\$filter=BusinessPlaceID eq 1";

  TextEditingController filter = TextEditingController();
  List<WarehouseEntity> data = [];
  late WarehouseCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WarehouseCubit>();
    final state = context.read<WarehouseCubit>().state;

    if (state is WarehouseData) {
      data = state.entities;
    }

    if (data.isEmpty) {
      _bloc.get(query).then((value) {
        if (mounted) {
          setState(() => data = value);
          _bloc.set(value);
        }
      });
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final state = BlocProvider.of<WarehouseCubit>(context).state;
        if (state is WarehouseData && data.isNotEmpty) {
          _bloc
              .next(
                  "?\$top=10&\$skip=${data.length}&\$filter=BusinessPlaceID eq 1 and contains(WarehouseCode,'${filter.text}')")
              .then((value) {
            if (mounted) {
              _bloc.set([...data, ...value]);
              setState(() => data = [...data, ...value]);
            }
          });
        }
      }
    });
  }

  @override
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
            "$query&\$filter=BusinessPlaceID eq 1 and contains(WarehouseCode, '${filter.text}')")
        .then((value) {
      if (mounted) {
        setState(() => data = value);
      }
    });
  }

  void onPressed(String code) {
    if (widget.isPicker) {
      LocalStorageManger.setString('warehouse', code);
      goTo(context, Dashboard(), removeAllPreviousRoutes: true);
    } else {
      Navigator.pop(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Warehouse Lists',
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
            if (!widget.isPicker)
              Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, bottom: 6, top: 4),
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
                    hintText: 'Warehouse Code...',
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
            if (!widget.isPicker) const Divider(thickness: 0.1, height: 15),
            Expanded(
              child: BlocConsumer<WarehouseCubit, WarehouseState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingWarehouse) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                    children: [
                      ...data
                          .map(
                            (warehouse) => GestureDetector(
                              onTap: () => onPressed(warehouse.code),
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
                                      warehouse.code,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      warehouse.name,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationWarehouse)
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
