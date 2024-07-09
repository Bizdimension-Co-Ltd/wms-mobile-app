import 'package:get_it/get_it.dart';
import 'package:wms_mobile/injector/di_bin.dart';
import 'package:wms_mobile/injector/di_business_partner.dart';
import 'package:wms_mobile/injector/di_delivery.dart';
import 'package:wms_mobile/injector/di_good_issue.dart';
import 'package:wms_mobile/injector/di_good_receipt.dart';
import 'package:wms_mobile/injector/di_item.dart';
import 'package:wms_mobile/injector/di_purchase_good_receipt.dart';
import 'package:wms_mobile/injector/di_purchase_order.dart';
import 'package:wms_mobile/injector/di_purchase_return.dart';
import 'package:wms_mobile/injector/di_purchase_return_request.dart';
import 'package:wms_mobile/injector/di_put_away%20copy.dart';
import 'package:wms_mobile/injector/di_put_away.dart';
import 'package:wms_mobile/injector/di_return_reqceipt.dart';
import 'package:wms_mobile/injector/di_return_reqceipt_request.dart';
import 'package:wms_mobile/injector/di_sale_order.dart';
import 'package:wms_mobile/injector/di_unit_of_measurement.dart';
import 'package:wms_mobile/injector/di_warehouse.dart';
import 'package:wms_mobile/utilies/database/database.dart';

import 'injector/authenticate_di.dart';
import 'utilies/dio_client.dart';

final getIt = GetIt.instance;

Future<void> container() async {
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerLazySingleton(() => DatabaseHelper());

//
  DIAuthentication(getIt);
  DIPurchaseOrder(getIt);
  DIWarehouse(getIt);
  DIBin(getIt);
  DIItem(getIt);
  DIUnitOfMeasurement(getIt);
  DIBusinessPartner(getIt);
  DIPurchaseGoodReceipt(getIt);
  DIReturnReceipt(getIt);
  DIReturnReceiptRequest(getIt);
  DIGoodReceipt(getIt);
  DiPutAway(getIt);
  DIGoodIssue(getIt);
  DISaleOrder(getIt);
  DIDelivery(getIt);
  DIPurchaseReturn(getIt);
  DIPurchaseReturnRequest(getIt);
  DiBinTransfer(getIt);
  //
}
