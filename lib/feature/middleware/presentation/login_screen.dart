import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/constant/api.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/feature/middleware/presentation/setting_screen.dart';
import 'package:wms_mobile/mobile_function/dashboard_screen.dart';

import '../../../utilies/dialog/dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userName = TextEditingController(text: "T010");
  final _password = TextEditingController(text: "1234");

  late bool checkTypeInput = false;

  Future<void> _postData() async {
    try {
      MaterialDialog.loading(context);
      if (mounted) {
        // MaterialDialog.close(context);
        final loginEntity = LoginEntity(
            username: _userName.text,
            password: _password.text,
            db: CONNECT_COMPANY);

        BlocProvider.of<AuthorizationBloc>(context).add(
          RequestLoginOnlineEvent(entity: loginEntity),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  bool _obscureText = true;

  void _isSuccess() {
    if (mounted) {
      MaterialDialog.close(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is AuthorizationSuccess) {
                    _isSuccess();
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(size(context).width * 0.06),
                        width: double.infinity,
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Warehouse Management System mobile",
                              style: TextStyle(
                                  fontSize: size(context).width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  height: 1.7),
                            ),
                            SizedBox(height: spaceY(context)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _userName,
                              decoration: const InputDecoration(
                                  labelText: ' Name',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Name',
                                  isDense: true),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextField(
                              obscureText: _obscureText,
                              controller: _password,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                hintText: 'Enter Password',
                                isDense: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 47.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _postData();
                                }, // Replace null with your actual callback function
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 17, 18, 48)),
                                ),
                                child: const Text(
                                  "SIGN IN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 47.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingScreen()),
                                  );
                                }, // Replace null with your actual callback function
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                ),
                                child: const Text(
                                  'Setting',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 1, 1, 1)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Copyright@ 2023 BizDimension Cambodia",
                      style: TextStyle(fontSize: 14.5, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "All right reserved",
                      style: TextStyle(fontSize: 14.5, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: size(context).width * 0.08)
          ],
        ),
      ),
    ));
  }
}
