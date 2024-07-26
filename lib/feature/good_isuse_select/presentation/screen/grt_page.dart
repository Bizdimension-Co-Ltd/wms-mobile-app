import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/good_isuse_select/domain/entity/grt_entity.dart';
import 'package:wms_mobile/feature/good_isuse_select/presentation/cubit/grt_cubit.dart';
import '/constant/style.dart';

class GoodIssueSelectPage extends StatefulWidget {
  const GoodIssueSelectPage({
    super.key,
  });

  @override
  State<GoodIssueSelectPage> createState() => _GoodIssueSelectPageState();
}

class _GoodIssueSelectPageState extends State<GoodIssueSelectPage> {
  String query = "?\$top=100&\$select=Code,Name";

  int check = 1;
  List<GoodIssueSelectEntity> data = [];
  late GoodIssueSelectCubit _bloc;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _bloc = context.read<GoodIssueSelectCubit>();
      final state = context.read<GoodIssueSelectCubit>().state;

      if (state is GoodIssueSelectData) {
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
          'Good Issue Type Lists',
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
              child: BlocConsumer<GoodIssueSelectCubit, GoodIssueSelectState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RequestingGoodIssueSelect) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      ...data
                          .map(
                            (GoodIssueSelect) => GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pop(GoodIssueSelect),
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
                                          GoodIssueSelect.code,
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
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          GoodIssueSelect.name,
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
                      if (state is RequestingPaginationGoodIssueSelect)
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
