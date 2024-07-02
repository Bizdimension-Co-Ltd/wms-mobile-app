import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/unit_of_measurement_entity.dart';
import '../cubit/uom_cubit.dart';
import '/constant/style.dart';

class UnitOfMeasurementPage extends StatefulWidget {
  const UnitOfMeasurementPage({super.key, required this.ids});

  final List<int> ids;

  @override
  State<UnitOfMeasurementPage> createState() => _UnitOfMeasurementPageState();
}

class _UnitOfMeasurementPageState extends State<UnitOfMeasurementPage> {
  String query = "?\$top=100&\$select=AbsEntry,Code,Name";

  int check = 1;
  List<UnitOfMeasurementEntity> data = [];
  late UnitOfMeasurementCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<UnitOfMeasurementCubit>();
      final state = context.read<UnitOfMeasurementCubit>().state;

      if (state is UnitOfMeasurementData) {
        data = state.entities;
      }

      if (data.isEmpty) {
        _bloc.get(query).then((value) {
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
          'Unit Of Measurement Lists',
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
              child:
                  BlocConsumer<UnitOfMeasurementCubit, UnitOfMeasurementState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingUnitOfMeasurement) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      ...data
                          .where((uom) => widget.ids.contains(uom.id))
                          .map(
                            (uom) => GestureDetector(
                              onTap: () => Navigator.of(context).pop(uom),
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
                                      "${uom.code} - ${uom.name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationUnitOfMeasurement)
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
