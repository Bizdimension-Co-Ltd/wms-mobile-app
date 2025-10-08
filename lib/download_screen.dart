import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/provider/login_provider.dart';
import 'package:wms_mobile/provider/purchase_order_list_offline.dart';
import 'package:wms_mobile/utilies/dialog/dialog.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';
import 'package:wms_mobile/feature/middleware/presentation/login_screen.dart';
import 'package:wms_mobile/mobile_function/dashboard.dart';
import 'package:wms_mobile/constant/style.dart';
import 'package:http/http.dart' as http;

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool isDownloading = false;
  double progress = 0.0;

  Future<void> _onLogout(BuildContext context) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    await provider.logout();
    await LocalStorageManger.removeString('username');
    await LocalStorageManger.removeString('password');
    await LocalStorageManger.removeString('CONNECT_COMPANY');

    MaterialDialog.snackBar(context, "Logged out successfully.");

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen(fromLogout: true)),
        (Route<dynamic> route) => false, // remove all previous routes
      );
    }
  }

  Future<void> _onDownload(BuildContext context) async {
    setState(() {
      isDownloading = true;
      progress = 0.0;
    });

    try {
      // 1️⃣ Load offline credentials
      final username = await LocalStorageManger.getString('username');
      final password = await LocalStorageManger.getString('password');
      final host = await LocalStorageManger.getString('host');
      final port = await LocalStorageManger.getString('port');
      final company = await LocalStorageManger.getString('CONNECT_COMPANY');

      if (username.isEmpty || password.isEmpty || company.isEmpty) {
        MaterialDialog.success(
          context,
          title: "Error",
          body: "No stored credentials found.",
        );
        return;
      }
      print(username);
      print(password);
      print(host);
      print(company);
      // 2️⃣ Request login token
      final loginResponse = await http.post(
        Uri.parse('$host:$port/b1s/v1/Login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "CompanyDB": company,
          "UserName": username,
          "Password": password,
        }),
      );

      if (loginResponse.statusCode != 200) {
        throw Exception("Login failed: ${loginResponse.body}");
      }

      final loginData = jsonDecode(loginResponse.body);
      final token = loginData['SessionId'];
      if (token == null) {
        throw Exception("Token not found in login response");
      }

      // 3️⃣ Fetch purchase orders
      final purchaseOrderResponse = await http.get(
        Uri.parse('$host:$port/b1s/v1/PurchaseOrders?\$top=10'),
        headers: {
          "Cookie": 'B1SESSION=$token; ROUTEID=.node3',
          "Content-Type": "application/json",
        },
      );

      if (purchaseOrderResponse.statusCode != 200) {
        throw Exception(
            "Failed to fetch purchase orders: ${purchaseOrderResponse.body}");
      }

      final rawData = jsonDecode(purchaseOrderResponse.body)["value"] ?? [];
      if (rawData.isEmpty) {
        MaterialDialog.snackBar(context, "No purchase orders found.");
      } else {
        final offlineProvider =
            Provider.of<PurchaseOrderProviderOffline>(context, listen: false);

        await offlineProvider
            .saveDocuments(List<Map<String, dynamic>>.from(rawData));

        MaterialDialog.snackBar(context, "Download completed successfully!");
        print(offlineProvider.documents);
      }
    } catch (e) {
      MaterialDialog.success(context, title: "Error", body: e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false;
          progress = 0.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          "Data Synchronization",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1.2,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: "Logout",
            onPressed: () => _onLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔵 Animated Lottie illustration (nice effect)
              // Lottie.asset(
              //   'assets/lottie/download.json', // ✅ Add your .json animation file here
              //   height: 200,
              //   repeat: !isDownloading,
              // ),

              const SizedBox(height: 20),
              Text(
                isDownloading
                    ? "Downloading Data..."
                    : "Sync Your Data for Offline Mode",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isDownloading
                    ? "Please wait while we prepare everything for you."
                    : "Make sure you are connected to Wi-Fi or Internet before continuing.",
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Progress Bar
              if (isDownloading)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      color: PRIMARY_COLOR,
                    ),
                    const SizedBox(height: 15),
                    Text("${(progress * 100).toInt()}%",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                  ],
                ),

              // Download button
              ElevatedButton.icon(
                onPressed: isDownloading ? null : () => _onDownload(context),
                icon: const Icon(Icons.cloud_download_rounded),
                label: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    isDownloading ? "Downloading..." : "Download Data",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                ),
              ),

              const SizedBox(height: 60),

              // Footer
              const Text(
                "© 2025 BizDimension Cambodia",
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                "All rights reserved",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
