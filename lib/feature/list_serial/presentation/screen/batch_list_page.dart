import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/component/button/button.dart';
import 'package:wms_mobile/feature/list_serial/presentation/cubit/serialNumber_list_cubit.dart';
import '../../domain/entity/list_serial_entity.dart';
import '/constant/style.dart';

class SerialListPage extends StatefulWidget {
  const SerialListPage({super.key, required this.warehouse});

  final String warehouse;

  @override
  State<SerialListPage> createState() => _SerialListPageState();
}

class _SerialListPageState extends State<SerialListPage> {
  String query = "?\$top=100&\$select=AbsEntry,BinCode,Warehouse,Sublevel1";
  int check = 1;
  List<BinEntity> data1 = [];
  List<Map<String, dynamic>> data = [
    {
      "Serial": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
      "selected": false
    },
    {"Serial": "A000013", "Qty": "20", "Bin": "MOCATION001", "selected": false},
    {"Serial": "A000014", "Qty": "30", "Bin": "LOCATION002", "selected": false},
    {"Serial": "D000015", "Qty": "45", "Bin": "LOCATION003", "selected": false},
    {"Serial": "E000016", "Qty": "50", "Bin": "DOCATION004", "selected": false},
    {
      "Serial": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
      "selected": false
    },
    {"Serial": "A000013", "Qty": "20", "Bin": "AOCATION001", "selected": false},
    {"Serial": "A000014", "Qty": "30", "Bin": "LOCATION002", "selected": false},
    {"Serial": "C000015", "Qty": "45", "Bin": "EOCATION003", "selected": false},
    {"Serial": "A000016", "Qty": "50", "Bin": "LOCATION004", "selected": false},
    {
      "Serial": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
      "selected": false
    },
    {"Serial": "A000013", "Qty": "20", "Bin": "LOCATION001", "selected": false},
    {"Serial": "A000014", "Qty": "30", "Bin": "BOCATION002", "selected": false},
    {"Serial": "B000015", "Qty": "45", "Bin": "LOCATION003", "selected": false},
    {"Serial": "A000016", "Qty": "50", "Bin": "LOCATION004", "selected": false},
  ];
  List<TextEditingController> controllers = [];

  late SerialListCubit _bloc;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    controllers = List.generate(
      data.length,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onSelected(bool? selected, int index) {
    setState(() {
      data[index]["selected"] = selected;
    });
  }

  void _onDone() {
    List<Map<String, dynamic>> selectedData =
        data.where((Serial) => Serial["selected"]).toList();
    setState(() {
      print(selectedData);
    });
    return;
    Navigator.pop(context, selectedData);
  }

  void _onChangeQty(String value, int index) {
    setState(() {
      data[index]["PickQty"] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
     data.sort((a, b) => a["Bin"].compareTo(b["Bin"]));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Serial Lists',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        actions: const [
          // TextButton(
          //   onPressed: _onDone,
          //   child: const Text(
          //     'Done',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    contentPadding: const EdgeInsets.only(top: 15),
                    hintText: 'Serial Number...',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: PRIMARY_COLOR,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            const Divider(thickness: 0.001, height: 25),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border(
                  bottom: BorderSide(width: 0.1),
                  top: BorderSide(width: 0.1),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Serial Number.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Qty'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.001, height: 7),
            Expanded(
              child: BlocConsumer<SerialListCubit, SerialListState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingBin) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      ...data.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          var Serial = entry.value;
                          return GestureDetector(
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: Checkbox(
                                            value: Serial["selected"],
                                            onChanged: (bool? value) {
                                              _onSelected(value, index);
                                            },
                                            checkColor: Colors
                                                .white, // Color of the checkmark
                                            activeColor: Colors.green.shade900,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Serial["Serial"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              Serial["Bin"],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                 
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child:   Text(
                                        Serial["Qty"],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      if (state is RequestingPaginationBin)
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
      bottomNavigationBar: Container(
        height: size(context).height * 0.09,
        padding: const EdgeInsets.all(12),
        color: Color.fromARGB(255, 243, 243, 243),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Button(
                bgColor: Colors.green.shade900,
                variant: ButtonVariant.primary,
                onPressed: _onDone,
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(child: Container()),
            Expanded(child: Container()),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
