import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wms_mobile/component/listItemDrop.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class VendorSelect extends StatefulWidget {
  const VendorSelect({Key? key, this.indBack}) : super(key: key);
  final indBack;

  @override
  State<VendorSelect> createState() => _VendorSelectState();
}

class _VendorSelectState extends State<VendorSelect> {
  int selectedRadio = -1;
  final DioClient dio = DioClient();
  int check = 0;
  List<dynamic> data = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int skip = 0;
  int top = 10;
  var filter = null;

  Future<void> getList() async {
    try {
      final response = await dio.get('/BusinessPartners', query: {
        '\$top': top,
        '\$skip': skip,
        '\$filter': "CardType eq 'cSupplier'"
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
    getList();
    selectedRadio = widget.indBack;
  }

  Future<void> _onRefresh() async {
    setState(() {
      filter = null;
      data.clear();
      skip = 0;
    });
    await getList();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    setState(() {
      skip += top;
    });
    await getList();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text('Vendors',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.sort),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          SmartRefresher(
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
                : data.isEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 150.0),
                        child: Center(
                          child: Text(
                            "No Record",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListItem(
                            twoRow: true,
                            index: index,
                            selectedRadio: selectedRadio,
                            onSelect: (value) {
                              setState(() {
                                selectedRadio = value;
                              });
                            },
                            desc: data[index]["CardName"] ?? "",
                            code: data[index]["CardCode"] ?? "",
                          );
                        },
                      ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 17, 18, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Map<String, dynamic> op = {
                    "cardCode": data[selectedRadio]["CardCode"],
                    "cardName": data[selectedRadio]["CardName"],
                    "address":
                        data[selectedRadio]["BPAddresses"]?.isNotEmpty == true
                            ? data[selectedRadio]["BPAddresses"]![0]["Street"]
                            : null,
                    "contactPersonList": data[selectedRadio]["ContactEmployees"],
                    "index": selectedRadio
                  };
                  if (selectedRadio != -1) {
                    Navigator.pop(context, op);
                  } else {
                    Navigator.pop(context, null);
                  }
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
