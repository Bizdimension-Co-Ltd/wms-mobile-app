import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/component/button/button.dart';
import '../../domain/entity/list_batch_entity.dart';
import '../cubit/batch_list_cubit.dart';
import '/constant/style.dart';

class BatchListPage extends StatefulWidget {
  const BatchListPage({super.key, required this.warehouse});

  final String warehouse;

  @override
  State<BatchListPage> createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  final ScrollController _scrollController = ScrollController();

  String query = "?\$top=100&\$select=AbsEntry,BinCode,Warehouse,Sublevel1";
  List<BinEntity> data1 = [];
  List<Map<String, dynamic>> data = [
    {
      "Batch": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
    },
    {"Batch": "A000013", "Qty": "20", "Bin": "LOCATION001"},
    {"Batch": "A000014", "Qty": "30", "Bin": "DOCATION002"},
    {"Batch": "A000015", "Qty": "45", "Bin": "LOCATION003"},
    {"Batch": "B000016", "Qty": "50", "Bin": "EOCATION004"},
    {
      "Batch": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
    },
    {"Batch": "A000013", "Qty": "20", "Bin": "LOCATION001"},
    {"Batch": "A000014", "Qty": "30", "Bin": "BOCATION002"},
    {"Batch": "A000015", "Qty": "45", "Bin": "LOCATION003"},
    {"Batch": "C000016", "Qty": "50", "Bin": "AOCATION004"},
    {
      "Batch": "A000012",
      "Qty": "25",
      "Bin": "SYSTEMBIN-LOCATION",
    },
    {"Batch": "D000013", "Qty": "20", "Bin": "LOCATION001"},
    {"Batch": "A000014", "Qty": "30", "Bin": "LOCATION002"},
    {"Batch": "A000015", "Qty": "45", "Bin": "LOCATION003"},
    {"Batch": "A000016", "Qty": "50", "Bin": "COCATION004"},
  ];
  List<TextEditingController> controllers = [];
  Set<int> selectedIndices = Set<int>();

  late BatchListCubit _bloc;

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
      if (selected == true) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
      }
    });
  }

  void _onDone() {
    List<Map<String, dynamic>> selectedData =
        selectedIndices.map((index) => data[index]).toList();
    Navigator.of(context).pop(selectedData); // Pass selected data back
  }
  void _onChangeQty(String value, int index) {
    setState(() {
      data[index]["PickQty"] = value;
    });
  }
  
  void onFilter() async {
    setState(() {
      data = [];
    });
    _bloc
        .get(
      "$query&\$filter=contains(ItemCode, '111')",
    )
        .then((value) {
      if (!mounted) return;

      setState(() => data = value as dynamic);
    });
  }



  @override
  Widget build(BuildContext context) {
    // Sort data by Qty in descending order
    data.sort((a, b) => int.parse(b["Qty"]).compareTo(int.parse(a["Qty"])));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Batch Lists',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
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
                    hintText: 'Batch Number...',
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
                      'Batch Number.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Available Qty'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Qty'),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.001, height: 7),
            Expanded(
              child: BlocConsumer<BatchListCubit, BatchListState>(
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
                          var batch = entry.value;
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
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: Checkbox(
                                            value:
                                                selectedIndices.contains(index),
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
                                              batch["Batch"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              batch["Bin"],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  "Expiry Date  :",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  "20-10-2024",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      batch["Qty"],
                                      style: TextStyle(
                                          // fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                  ),
                                  // Input field here
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: SizedBox(
                                        width: 85,
                                        child: TextField(
                                          style: TextStyle(fontSize: 14),
                                          controller: controllers[index],
                                          onChanged: (value) {
                                            _onChangeQty(value, index);
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Qty',
                                            hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
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
