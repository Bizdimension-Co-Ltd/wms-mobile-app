import 'dart:convert';
import 'dart:developer';

import 'package:wms_mobile/constant/data.dart';
import 'package:wms_mobile/databases/database.dart';
import 'package:wms_mobile/feature/pick_and_pack/pick_list/data/model/pick_list_model.dart';

import '../../domain/entity/find_picking_list_entity.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class PickListRemoteDataSource {
  Future<PickListEntity> post(PickListModel payload);
  Future<PickListModel> find(int payload);
}

class PickListRemoteDataSourceImpl implements PickListRemoteDataSource {
  final DioClient dio;
  final AppDatabase db;

  PickListRemoteDataSourceImpl(this.dio, this.db);

  @override
  Future<PickListEntity> post(PickListModel payload) async {
    try {
      await dio.patch('/PickLists(${payload.absoluteentry})',
          data: payload.toJson());

      return payload;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<PickListModel> find(int payload) async {
    try {
      final response = await dio.get('/PickLists($payload)');
      PickListModel pickList = PickListModel.fromJson(response.data);

      List<PickListsLineModel> _list = [];
      Map<int, dynamic> _objects = <int, dynamic>{};
      for (int i = 0; i < (pickList.pickListsLines ?? []).length; i++) {
        String url = getObjectTable(pickList.pickListsLines?[i].baseObjectType);
        if (url == '') continue;

        url += "(${pickList.pickListsLines?[i].orderEntry})";
        if (_objects[pickList.pickListsLines?[i].orderEntry] == null) {
          final res = await dio.get(url);
          _objects[pickList.pickListsLines?[i].orderEntry ?? -1] = res.data;
        }

        final data = _objects[pickList.pickListsLines?[i].orderEntry];
        var lines = (data['StockTransferLines'] ?? data['DocumentLines'])
            as List<dynamic>?;
        final line = lines?.singleWhere(
            (e) => e['LineNum'] == pickList.pickListsLines?[i].orderRowId);
        if (line == null) continue;

        PickListsLineModel pickLine = pickList.pickListsLines![i];
        pickLine = pickLine.copyWithFromModel(
          itemCode: line['ItemCode'],
          itemDescription: line['ItemDescription'],
          warehouseCode: line['FromWarehouseCode'] ?? line['WarehouseCode'],
          uomCode: line['UoMCode'],
        );
        _list.add(pickLine);
      }
      _objects = {};
      return pickList.copyWith(pickListsLines: _list);
    } on Failure {
      rethrow;
    }
  }
}
