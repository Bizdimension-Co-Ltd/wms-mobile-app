import 'package:flutter/material.dart';
import 'package:wms_mobile/component/listItemDrop.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/utilies/dio_client.dart';

class BranchSelect extends StatefulWidget {
  const BranchSelect({Key? key, this.indBack})
      : super(
          key: key,
        );
  final indBack;
  @override
  State<BranchSelect> createState() => _BranchSelectState();
}

class _BranchSelectState extends State<BranchSelect> {
  int a = 1;
  int selectedRadio = -1;
  final DioClient dio = DioClient();
  int check = 0;
  List<dynamic> data = [];
  List<dynamic> branchAss = [];
  Future<void> getUser() async {
    try {
      final response = await dio.get('/UsersService_GetCurrentUser');
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            branchAss.addAll(response.data["UserBranchAssignment"]);
            // print(response.data["UserBranchAssignment"]);
          });
        }
      } else {
        throw ServerFailure(message: response.data['msg']);
      }
    } on Failure {
      rethrow;
    }
  }

  Future<void> getList() async {
    try {
      await getUser();
      final response = await dio.get('/BusinessPlaces', query: {
        '\$select': "BPLID,BPLName",
      });

      if (response.statusCode == 200) {
        if (mounted) {
          if (branchAss.isNotEmpty) {
            setState(() {
              check = 1;
              data = response.data['value']
                  .where((b) => branchAss.any((a) => a["BPLID"] == b["BPLID"]))
                  .toList();
            });
          }
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
    // TODO: implement initState
    super.initState();
    getList();
    setState(() {
      selectedRadio = widget.indBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text(
          'Branch',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
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
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Expanded(
              child: check == 0
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2.5,
                      ),
                    )
                  : data.length == 0
                      ? Container(
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
                                twoRow: false,
                                index: index,
                                selectedRadio: selectedRadio,
                                onSelect: (value) {
                                  setState(() {
                                    selectedRadio = value;
                                  });
                                },
                                desc: data[index]["BPLName"] ?? "",
                                code: "");
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
                    final op = {
                      "name": data[selectedRadio]["BPLName"],
                      "value": data[selectedRadio]["BPLID"],
                      "defaultWH": data[selectedRadio]["DefaultWarehouseID"],
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
      ),
    );
  }
}
