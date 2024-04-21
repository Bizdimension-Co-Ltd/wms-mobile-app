import 'package:flutter/material.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/feature/middleware/presentation/login_screen.dart';
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
    super.initState();
    _startSessionTimer();
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(sessionTimeout, (Timer timer) async {
      // Check if the session is still valid
      String? sessionId = await _secureStorage.read(key: 'sessionId');

      if (sessionId == null) {
        // Navigate to login screen if the session has expired or is invalid
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()));
        _sessionTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default color for the date picker
        colorScheme: const ColorScheme.light(
          primary: PRIMARY_COLOR, // Change primary color
          onPrimary: Colors.white, // Change text color
        ),
      ),
      title: 'Flutter layout demo',
      home: SplashScreen(),
    );
  }
}
