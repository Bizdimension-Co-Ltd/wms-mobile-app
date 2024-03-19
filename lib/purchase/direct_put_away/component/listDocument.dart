import 'package:flutter/material.dart';
import 'package:wms_mobile/component/blockList.dart';
import 'package:wms_mobile/model/direct_put_away.dart';
import 'package:wms_mobile/purchase/direct_put_away/directPutAwayDetailScreen.dart';
import 'package:wms_mobile/purchase/direct_put_away/myData.dart';

import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListDocument extends StatefulWidget {
  const ListDocument({super.key});

  @override
  State<ListDocument> createState() => _ListDocumentState();
}

class _ListDocumentState extends State<ListDocument> {
  num check = 0;
  var s = 10;
  List<DirectPutAway> _lists = [];

  void request() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: "sessionId");
    final dio = Dio();
    Response response;
    response = await dio.get(
      "https://svr11.biz-dimension.com:50000/b1s/v1/GoodsReturnRequest?\$top=$s",
      options: Options(
        headers: {
          "Cookie": "B1SESSION=$token; ROUTEID=.node4",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<DirectPutAway> data = List.from(
          response.data['value'].map((e) => DirectPutAway.fromJson(e)));
      // directPutAway.addAll(response.data['value']);
      setState(() {
        _lists = data;
        check = data.length;
      });
    }
  }

  @override
  void initState() {
    request();
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      directPutAway.clear();
      s = 10;
      request();
    });

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        s + 10;
        request();
      });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 236, 233, 233),
      height: double.infinity,
      width: double.infinity,
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DirectPutAwayDetailScreens(
                                  ind: _lists[index])),
                        );
                      },
                      child: BlockList(
                        name: "${_lists[index].cardCode} - ${_lists[index].cardName}",
                        // date: "23-3-2023",
                        date: "${_lists[index].docDate }",
                        status: "OPEN",
                        qty: "50/300",
                      ),
                    );
                  }),
            ),
    );
  }
}
