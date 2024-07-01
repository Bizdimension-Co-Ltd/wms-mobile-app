import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/bin_entity.dart';
import '../cubit/bin_cubit.dart';
import '/constant/style.dart';

class BinPage extends StatefulWidget {
  const BinPage({super.key, required this.warehouse});

  final String warehouse;

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  String query = "?\$top=100&\$select=AbsEntry,BinCode,Warehouse,Sublevel1";

  int check = 1;
  List<BinEntity> data = [];
  late BinCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<BinCubit>();
      final state = context.read<BinCubit>().state;

      if (state is BinData) {
        data = state.entities;
      }

      final exists = data.where((e) => e.warehouse == widget.warehouse);
      if (data.isEmpty || exists.isEmpty) {
        _bloc
            .get("$query&\$filter=Warehouse eq '${widget.warehouse}'")
            .then((value) {
          setState(() => data = value);
          _bloc.set(value);
        });
      }

      setState(() {
        data;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Bin Lists',
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
            const Divider(thickness: 0.1, height: 15),
            Expanded(
              child: BlocConsumer<BinCubit, BinState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingBin) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      ...data
                          .map(
                            (bin) => Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bin.code,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
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
    );
  }
}
