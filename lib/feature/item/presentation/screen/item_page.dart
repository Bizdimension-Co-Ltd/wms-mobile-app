import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enum/global.dart';
import '../../../../utilies/dialog/dialog.dart';
import '/helper/helper.dart';
import '../cubit/item_cubit.dart';
import '/constant/style.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.type});

  final ItemType type;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ScrollController _scrollController = ScrollController();

  String query =
      "?\$top=10&\$skip=0&\$select=ItemCode,ItemName,PurchaseItem,InventoryItem,SalesItem,InventoryUOM,UoMGroupEntry,InventoryUoMEntry,DefaultPurchasingUoMEntry,DefaultSalesUoMEntry, ManageSerialNumbers, ManageBatchNumbers";

  int _skip = 0;

  int check = 1;
  TextEditingController filter = TextEditingController();
  List<dynamic> data = [];
  late ItemCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<ItemCubit>();
      final state = context.read<ItemCubit>().state;

      if (state is ItemData) {
        data = state.entities;
      }

      if (data.length == 0) {
        query = "$query&\$filter=${getItemTypeQueryString(widget.type)}";
        _bloc.get(query).then((value) {
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
          final state = BlocProvider.of<ItemCubit>(context).state;
          if (state is ItemData && data.length > 0) {
            _bloc
                .next(
                    "?\$top=10&\$skip=${data.length}&\$filter=${getItemTypeQueryString(widget.type)} and contains(ItemCode,'${filter.text}')")
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
            "$query&\$filter=${getItemTypeQueryString(widget.type)} and contains(ItemCode, '${filter.text}')",
            cache: false)
        .then((value) {
      if (!mounted) return;

      setState(() => data = value);
    });
  }

  void onFind(String code) async {
    try {
      if (!mounted) return;

      MaterialDialog.loading(context);
      final response = await _bloc.find("('$code')");
      if (mounted) {
        MaterialDialog.close(context);

        Navigator.pop(context, response);
      }
    } catch (e) {
      if (mounted) {
        MaterialDialog.success(context,
            title: 'Invalid', body: 'Item not found - $code');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Item Lists',
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
                  hintText: 'Item Code...',
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
              child: BlocConsumer<ItemCubit, ItemState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingItem) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    controller: _scrollController,
                    children: [
                      ...data
                          .map(
                            (item) => GestureDetector(
                              onTap: () =>
                                  onFind(getDataFromDynamic(item['ItemCode'])),
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
                                      getDataFromDynamic(item['ItemCode']),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(getDataFromDynamic(item['ItemName'])),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationItem)
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
