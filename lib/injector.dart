import 'package:get_it/get_it.dart';
import 'package:wms_mobile/injector/di_bin.dart';
import 'package:wms_mobile/injector/di_item.dart';
import 'package:wms_mobile/injector/di_purchase_order.dart';
import 'package:wms_mobile/injector/di_warehouse.dart';

import 'injector/authenticate_di.dart';
import 'utilies/dio_client.dart';

final getIt = GetIt.instance;

Future<void> container() async {
  getIt.registerLazySingleton(() => DioClient());

//
  DIAuthentication(getIt);
  DIPurchaseOrder(getIt);
  DIWarehouse(getIt);
  DIBin(getIt);
  DIItem(getIt);
  //
}
