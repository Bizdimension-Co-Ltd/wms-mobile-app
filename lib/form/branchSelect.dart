import 'package:flutter/material.dart';
import 'package:wms_mobile/component/listItemDrop.dart';

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
  // Keep track of the selected radio button
  final data = [
    {
      "name": "FELIX PETROLEUM PTE LTD",
      "sub": "FUE0001",
    },
    {
      "name": "EQUINOR-FUE",
      "sub": "FUE0005",
    },
    {
      "name": "H.A Energy & Shipping PTE Ltd",
      "sub": "FUE0009",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      
      selectedRadio = widget.indBack;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 18, 48),
        title: const Text('Branch'),
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
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(
                    index: index,
                    selectedRadio: selectedRadio,
                    onSelect: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                    data: data,
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 17, 18, 48)),
                onPressed: () {
                    final op = {"value": data[selectedRadio]["name"], "index": selectedRadio};
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
