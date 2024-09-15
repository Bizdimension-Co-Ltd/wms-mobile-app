import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/component/button/button.dart';
import 'package:wms_mobile/constant/api.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/feature/dashboard/presentations/page/dashboard_screen.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:wms_mobile/feature/middleware/presentation/cubit/authorization_cubit.dart';
import 'package:wms_mobile/feature/middleware/presentation/setting_screen.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import '../../../helper/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.fromLogout,
    this.isTokenExipred = false,
  });
  final bool? fromLogout;
  final bool isTokenExipred;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userName = TextEditingController(text: "T006");
  final _password = TextEditingController(text: "1234");

  late bool checkTypeInput = false;
  bool loading = false;

  late AuthorizationCubit _bloc;

  @override
  void initState() {
    _bloc = context.read<AuthorizationCubit>();
    super.initState();
  }

  Future<void> _postData() async {
    final entity = LoginEntity(
      username: _userName.text,
      password: _password.text,
      db: CONNECT_COMPANY,
    );

    try {
      if (mounted) {
        setState(() => loading = true);
      }

      await _bloc.onRequestLogin(entity);
      setState(() => loading = false);

      if (mounted) {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop(true);
          return;
        }
      }

      _bloc.emitEvent(AuthorizationSuccess());
    } catch (e) {
      String message = e is UnauthorizeFailure ? e.message : e.toString();

      if (mounted) {
        setState(() => loading = false);
        MaterialDialog.warning(context, title: 'Failed', body: message);
      }
    }
  }

  bool _obscureText = true;
  void _isSuccess() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    if (widget.fromLogout != null) {
      SystemNavigator.pop();
      return false; // Prevent the back navigation
    } else {
      return true; // Allow the back navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                child: SizedBox(
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
                                  fontWeight: FontWeight.bold, fontSize: 19),
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
                          loading: loading,
                          onPressed: _postData,
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Button(
                          variant: ButtonVariant.ghost,
                          loading: loading,
                          child: Text(
                            'Setting',
                            style: TextStyle(color: PRIMARY_COLOR),
                          ),
                          onPressed: () => goTo(context, const SettingScreen()),
                        ),
                      ],
                    ),
                  ),
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
      )),
    );
  }
}
