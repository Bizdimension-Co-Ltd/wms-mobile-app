import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wms_mobile/component/listItemDrop.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/purchaseOrderCodeScreen.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class ItemsSelect extends StatefulWidget {
  const ItemsSelect({
    super.key,
    this.indBack,
    this.type,
  });
  final indBack;
  final type;
  @override
  State<ItemsSelect> createState() => _ItemsSelectState();
}

class _ItemsSelectState extends State<ItemsSelect> {
  Set<int> selectedItems = {};
  int selectedRadio = -1;

  DateTime selectedDate = DateTime.now();
  final DioClient dio = DioClient();
  int check = 0;
  List<dynamic> data = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int skip = 0;
  int top = 15;
  var filter = null;

  Future<void> getListItems(filter) async {
    try {
      final response = await dio.get(
          '/Items?\$select=ItemCode,ItemName,SalesItem ${widget.type == "" || widget.type == null ? "" : "& \$filter=SalesItem eq '${widget.type}'${filter != "" ? " and ItemCode eq '$filter'" : ''}"}',
          query: {
            '\$top': top,
            '\$skip': skip,
          });

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            check = 1;
            data.addAll(response.data['value']);
          });
        }
      } else {
        throw ServerFailure(message: response.data['msg']);
      }
    } on Failure {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedRadio = widget.indBack;
    });
    getListItems("");
  }

  Future<void> _onRefresh() async {
    setState(() {
      data.clear();
      skip = 0;
    });
    await getListItems("");
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    setState(() {
      skip += top;
    });
    await getListItems("");
    _refreshController.loadComplete();
  }

  bool _isSearching = false;
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // foregroundColor: Colors.white,
      //   backgroundColor: Color.fromARGB(238, 16, 50, 171),
      //   title: const Text(
      //     "Items",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   actions: [
      //     const SizedBox(width: 15),
      //     IconButton(
      //       onPressed: () {
      //         final op = {
      //           "name": data[selectedRadio]["ItemName"],
      //           "value": data[selectedRadio]["ItemCode"],
      //           "index": selectedRadio
      //         };
      //         if (selectedRadio != -1) {
      //           Navigator.pop(context, op);
      //         } else {
      //           Navigator.pop(context, null);
      //         }
      //       },
      //       icon: const Text(
      //         "Done",
      //         style: TextStyle(fontSize: 15, color: Colors.white),
      //       ),
      //     ),
      //     const SizedBox(width: 13),
      //   ],
      // ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(238, 16, 50, 171),
        title: _isSearching
            ? TextField(
                cursorColor: Colors.white, // Set the cursor color to white
                controller: _search,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            : const Text(
                'Items',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
        actions: _isSearching
            ? [
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () async {
                    setState(() {
                      _isSearching = false;
                      check = 0;
                      data.clear();
                      getListItems(_search.text);
                      // Perform search action here using _searchController.text
                    });
                  },
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    final op = {
                      "name": data[selectedRadio]["ItemName"],
                      "value": data[selectedRadio]["ItemCode"],
                      "index": selectedRadio
                    };
                    if (selectedRadio != -1) {
                      Navigator.pop(context, op);
                    } else {
                      Navigator.pop(context, null);
                    }
                  },
                  icon: const Text(
                    "Done",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
              ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: check == 0
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2.5,
                ),
              )
            : data.length == 0
                ? Container(
                    margin: const EdgeInsets.only(bottom: 150.0),
                    child: Center(
                        child: Text(
                      "No Record",
                      style: TextStyle(fontSize: 15),
                    )),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isLastIndex = index == data.length - 1;

                      return ListItem(
                          lastIndex: isLastIndex,
                          twoRow: true,
                          index: index,
                          selectedRadio: selectedRadio,
                          onSelect: (value) {
                            setState(() {
                              selectedRadio = value;
                            });
                          },
                          desc: data[index]["ItemCode"] ?? "",
                          code: data[index]["ItemName"] ?? "");
                    },
                  ),
      ),
    );
  }
}
