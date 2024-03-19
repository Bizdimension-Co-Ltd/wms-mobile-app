import 'package:flutter/material.dart';
import 'package:wms_mobile/model/businessPartner.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Vendor extends StatefulWidget {
  const Vendor({Key? key, this.indBack}) : super(key: key);
  final indBack;

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  int selectedRadio = -1;
  num check = 0;
  var s = 10;
  final List<BusinessPartner> _lists = [];
  bool _isMounted = false; // Add this flag

  Future<void> request(int page) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: "sessionId");
    final dio = Dio();
    Response response;
    response = await dio.get(
      "https://svr11.biz-dimension.com:50000/b1s/v1/BusinessPartners?\$filter=CardType eq 'cSupplier'&\$top=$s&\$skip=$page",
      options: Options(
        headers: {
          "Cookie": "B1SESSION=$token; ROUTEID=.node4",
          "Content-Type": "application/json",
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<BusinessPartner> data = List.from(
          response.data['value'].map((e) => BusinessPartner.fromJson(e)));

      if (_isMounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _lists.addAll(data);
          check = _lists.length;
        });
      }
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // Use async/await directly for delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() {
      _lists.clear();
      s = 10;
    });
    await request(0); // Assuming you want to refresh the first page
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // Use async/await directly for delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    setState(() {
      s + 10;
    });
    await request(s);
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    setState(() {
      selectedRadio = widget.indBack;
    });
    request(0); // Assuming you want to load the first page initially
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text('Spplier'),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.sort),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 236, 233, 233),
        child: Column(
          children: [
            Expanded(
              child: check == 0
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2.5,
                      ),
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        shrinkWrap: true,
                        itemCount: _lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListItem(
                            index: index,
                            selectedRadio: selectedRadio,
                            onSelect: (value) {
                              setState(() {
                                selectedRadio = value;
                              });
                            },
                            data: _lists[index],
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 18, 48)),
                onPressed: () {
                  final op = {
                    "cardCode": _lists[selectedRadio].cardCode,
                    "cardName": _lists[selectedRadio].cardName,
                    "cardType": _lists[selectedRadio].cardType,
                    "address": _lists[selectedRadio].address,
                    "index": selectedRadio
                  };
                  if (selectedRadio != -1) {
                    Navigator.pop(context, op);
                  } else {
                    Navigator.pop(context, null);
                  }
                },
                child: const Text('Okay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.index,
    required this.selectedRadio,
    required this.onSelect,
    required this.data,
  }) : super(key: key);

  final int index;
  final int selectedRadio;
  final Function(int) onSelect;
  final BusinessPartner data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 233, 228, 228),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 80,
                child: Center(
                    child: Transform.scale(
                  scale: 0.9,
                  child: Radio(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => const Color.fromARGB(255, 120, 120, 124)),
                    value: index,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      onSelect(value as int);
                    },
                  ),
                )),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data.cardName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text("${data.cardCode}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
