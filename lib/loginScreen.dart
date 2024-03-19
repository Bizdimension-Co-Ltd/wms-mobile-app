import 'package:flutter/material.dart';
import 'package:wms_mobile/mobile_function/wmsMobileScreen.dart';
import 'package:wms_mobile/settingScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// https://svr11.biz-dimension.com:50000/b1s/v1
class _LoginScreenState extends State<LoginScreen> {
  final _userName = TextEditingController(text: "manager");
  final _password = TextEditingController(text: "1234");
  late bool _isLoading = false;
  late String _errorMessage = '';
  String _responseMessage = '';
  late bool checkTypeInput = false;

  Future<void> _postData() async {
    Dio dio = Dio();
    const String apiUrl = 'https://svr11.biz-dimension.com:50000/b1s/v1/Login';
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    try {
      if (_userName.text == 'manager' && _password.text == '1234') {
        setState(() {
          _isLoading = true;
        });
        var payload = {
          'CompanyDB': "TLTELA_DEVELOPER",
          'UserName': _userName.text,
          'Password': _password.text
        };
        Response response = await dio.post(apiUrl, data: payload);

        final sessionId = response.data['SessionId'];

        await secureStorage.write(
          key: 'sessionId',
          value: sessionId,
        );
        setState(() {
          _isLoading = false;
          _responseMessage =
              'Status:POST ${response.statusCode}\nResponse: ${response.data}';
          print(_responseMessage);
        });
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WMSMobileScreen(),
          ),
        );
      } else if (_userName.text != 'manager' || _password.text != '1234') {
        setState(() {
          _isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _errorMessage = 'Incorrect name or password !';
            _isLoading = false;
          });
        });
      }
    } catch (e) {
      // setState(() {
      //   _responseMessage = 'Error: $e';
      //   print(_responseMessage);
      // });
    }
  }

  bool _obscureText = true;

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
              child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    width: double.infinity,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Warehouse Management System mobile",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            )
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
                              // Check if the name and password are correct
                              // Future.delayed(
                              //   const Duration(seconds: 2),
                              //   () {
                              //     if (_userName.text == 'manager' &&
                              //         _password.text == 'manager') {
                              //       // Navigate to the home screen
                              //       Navigator.pushReplacement(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               const WMSMobileScreen(),
                              //         ),
                              //       );
                              //     } else {
                              //       setState(() {
                              //         _errorMessage =
                              //             'Incorrect name or password !';
                              //         _isLoading = false;
                              //       });
                              //     }
                              //   },
                              // );
                            }, // Replace null with your actual callback function
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 17, 18, 48)),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2.5,
                                    ))
                                : const Text(
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
                  )),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
            )
          ],
        ),
      ),
    ));
  }
}
