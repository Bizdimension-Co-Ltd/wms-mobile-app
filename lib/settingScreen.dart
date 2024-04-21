import 'package:flutter/material.dart';
import 'package:wms_mobile/constant/style.dart';

import 'utilies/dialog/dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> saveSetting() async {
    MaterialDialog.loading(context);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      MaterialDialog.close(context);
    }
    // LocalStorageManger
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.6,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "Setting",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(size(context).width * 0.06),
                  width: double.infinity,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adress Configuration",
                        style: TextStyle(
                            fontSize: size(context).width * 0.06, height: 1.7),
                      ),
                      const SizedBox(height: 30),
                      const TextField(
                        decoration: InputDecoration(
                            labelText: 'Web Server Adress',
                            border: OutlineInputBorder(),
                            hintText: 'Enter Web Server Adress',
                            isDense: true),
                      ),
                      const SizedBox(height: 25),
                      const TextField(
                        decoration: InputDecoration(
                            labelText: 'Port',
                            border: OutlineInputBorder(),
                            hintText: 'Enter Port',
                            isDense: true),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 47.0,
                        child: ElevatedButton(
                          onPressed:
                              saveSetting, // Replace null with your actual callback function
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 17, 18, 48)),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(
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
              const SizedBox(height: 30)
            ],
          ),
        ));
  }
}
