import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/business_partner/presentation/cubit/business_partner_cubit.dart';
import 'package:wms_mobile/feature/inbound/good_receipt_po/presentation/cubit/purchase_good_receipt_cubit.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/feature/unit_of_measurement/presentation/cubit/uom_cubit.dart';
import 'package:wms_mobile/feature/warehouse/presentation/cubit/warehouse_cubit.dart';
import 'package:wms_mobile/main_screen.dart';
import 'core/disble_ssl.dart';
import 'feature/bin_location/presentation/cubit/bin_cubit.dart';
import 'feature/inbound/purchase_order/presentation/cubit/purchase_order_cubit.dart';
import 'feature/item/presentation/cubit/item_cubit.dart';
import 'injector.dart';

void main() async {
  // Ensures Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DisableSSL();
  container();
  //  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyMainApp());
}

class MyMainApp extends StatefulWidget {
  const MyMainApp({super.key});

  @override
  State<MyMainApp> createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthorizationBloc>()),
        BlocProvider(create: (_) => getIt<PurchaseOrderCubit>()),
        BlocProvider(create: (_) => getIt<WarehouseCubit>()),
        BlocProvider(create: (_) => getIt<BinCubit>()),
        BlocProvider(create: (_) => getIt<ItemCubit>()),
        BlocProvider(create: (_) => getIt<UnitOfMeasurementCubit>()),
        BlocProvider(create: (_) => getIt<BusinessPartnerCubit>()),
        BlocProvider(create: (_) => getIt<PurchaseGoodReceiptCubit>()),
      ],
      child: const MainScreen(),
    );
  }
}
