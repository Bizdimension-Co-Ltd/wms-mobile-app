import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/main_screen.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/create_screen/selectItemProvider.dart';

import 'core/disble_ssl.dart';
import 'injector.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DisableSSL();
  container();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectedItemsProvider(),
      child: MyMainApp(),
    ),
  );
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
      ],
      child: const MainScreen(),
    );
  }
}
