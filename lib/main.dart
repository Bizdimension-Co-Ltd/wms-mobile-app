import 'package:flutter/material.dart';
import 'package:wms_mobile/loginScreen.dart';
import 'package:wms_mobile/splashScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

void main() {
  runApp(const MyMainApp());
}

class MyMainApp extends StatefulWidget {
  const MyMainApp({super.key});

  @override
  State<MyMainApp> createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late Timer _sessionTimer;
  Duration sessionTimeout = const Duration(minutes: 1);

  @override
  void initState() {
    _startSessionTimer();
    super.initState();
  }

  void _startSessionTimer() async {
    _sessionTimer = Timer.periodic(sessionTimeout, (Timer timer) async {
      // Check if the session is still valid
      String? sessionId = await _secureStorage.read(key: 'sessionId');
      if (sessionId == null) {
        // Navigate to login screen if the session has expired or is invalid
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()));
        _sessionTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter layout demo',
        home: SplashScreen());
  }
}
