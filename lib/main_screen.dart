import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/middleware/presentation/bloc/authorization_bloc.dart';
import '/feature/middleware/presentation/login_screen.dart';
import '/mobile_function/dashboard_screen.dart';
import 'constant/style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {},
      builder: (context, state) {
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
          home: state is AuthorizationSuccess
              ? const DashboardScreen()
              : const LoginScreen(),
        );
      },
    );
  }
}
