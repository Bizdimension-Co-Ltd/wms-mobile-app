import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/grt_entity.dart';
import '../cubit/grt_cubit.dart';
import '/constant/style.dart';

class GrtPage extends StatefulWidget {
  const GrtPage({
    super.key,
  });

  @override
  State<GrtPage> createState() => _GrtPageState();
}

class _GrtPageState extends State<GrtPage> {
  String query = "?\$top=100&\$select=Code,Name";

  int check = 1;
  List<GrtEntity> data = [];
  late GrtCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<GrtCubit>();
      final state = context.read<GrtCubit>().state;

      if (state is GrtData) {
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
          'Good Receipt Type Lists',
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
              child: BlocConsumer<GrtCubit, GrtState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingGrt) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      ...data
                          .map(
                            (Grt) => GestureDetector(
                              onTap: () => Navigator.of(context).pop(Grt),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          Grt.code,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                          SizedBox(
                                          width: 5,
                                        ),
                                         Text(
                                          "-",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                         Text(
                                          Grt.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      if (state is RequestingPaginationGrt)
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
