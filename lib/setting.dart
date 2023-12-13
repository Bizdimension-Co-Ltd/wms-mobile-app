import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter layout demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "setting",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
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
                              height: 30,
                            ),
                            const Text(
                              "Adress Configuration",
                              style: TextStyle(fontSize: 25, height: 1.7),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Version: 1.0.1",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                labelText: 'Web Server Adress',
                                border: OutlineInputBorder(),
                                hintText: 'Enter Web Server Adress',
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                labelText: 'Port',
                                border: OutlineInputBorder(),
                                hintText: 'Enter Port',
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 47.0,
                              child: ElevatedButton(
                                onPressed:
                                    null, // Replace null with your actual callback function
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 17, 29, 38)),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Expanded(
                  flex: 2,
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
        )
        );
  }
}
