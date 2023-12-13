import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        home: Scaffold(
          body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 210),
                        const Text("WMMS Mobile",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                        const SizedBox(height: 30),
                        Image.asset(
                          "images/splash.jpg",
                          width: 250,
                          height: 250,
                        ),
                      ],
                    )),
                  ),
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
                          style: TextStyle(fontSize: 14.5,
                          color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "All right reserved",
                          style: TextStyle(fontSize: 14.5,
                            color: Colors.grey
                          ),
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
