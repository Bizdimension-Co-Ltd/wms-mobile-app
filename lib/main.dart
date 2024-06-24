import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/main_screen.dart';
import 'package:wms_mobile/presentations/purchase/purchase_order/create_screen/selectItemProvider.dart';
import 'dart:async';

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

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     // Define the default color for the date picker
    //     colorScheme: const ColorScheme.light(
    //       primary: PRIMARY_COLOR, // Change primary color
    //       onPrimary: Colors.white, // Change text color
    //     ),
    //   ),
    //   title: 'Flutter layout demo',
    //   // home: TestPage(),
    //   home: SplashScreen(),
    // );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  static const batterChannel = MethodChannel('com.example.wms_mobiles');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              final val = await MyMethodChannel.getBatteryLevel();
              print(val);

              //  print( await batterChannel.invokeMethod('getBatteryLevel'));
            },
            child: Text('Click Me')),
      ),
    );
  }
}

class MyMethodChannel {
  static const platform = MethodChannel('com.example.method_channel');

  static Future<String> getBatteryLevel() async {
    try {
      final String result = await platform.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get battery level: '${e.message}'.";
    }
  }
}
