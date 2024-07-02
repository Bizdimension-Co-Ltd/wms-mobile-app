import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/component/button/button.dart';
import 'package:wms_mobile/constant/api.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/feature/middleware/presentation/setting_screen.dart';
import 'package:wms_mobile/mobile_function/dashboard.dart';
import '../../../helper/helper.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
                listener: (context, state) {
                  // // TODO: implement listener
                  // if (state is AuthorizationSuccess) {
                  //   _isSuccess();
                  // }
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
                            const SizedBox(height: 25),
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
                            Button(
                              loading: state is RequestingAuthorization,
                              onPressed: _postData,
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Button(
                              variant: ButtonVariant.ghost,
                              loading: state is RequestingAuthorization,
                              child: Text(
                                'Setting',
                                style: TextStyle(color: PRIMARY_COLOR),
                              ),
                              onPressed: () =>
                                  goTo(context, const SettingScreen()),
                            ),
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
