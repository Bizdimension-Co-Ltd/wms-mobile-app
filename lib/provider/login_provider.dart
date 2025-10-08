import 'package:flutter/material.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _username;
  String? _password;
  String? _company;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  bool get rememberMe => _rememberMe;
  String? get username => _username;
  String? get password => _password;
  String? get company => _company;

  LoginProvider() {
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    _username = await LocalStorageManger.getString('username');
    _password = await LocalStorageManger.getString('password');
    _company = await LocalStorageManger.getString('CONNECT_COMPANY');
    if (_username != null && _username!.isNotEmpty) {
      _isLoggedIn = true; // auto login if credentials exist
    }
    notifyListeners();
  }

  Future<void> login(String username, String password, bool remember) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 200)); // Simulate delay

    if (username.isNotEmpty && password.isNotEmpty) {
      _username = username;
      _password = password;
      // _company = company;
      _rememberMe = remember;
      _isLoggedIn = true;

      if (remember) {
        await LocalStorageManger.setString('username', username);
        await LocalStorageManger.setString('password', password);
        // await LocalStorageManger.setString('CONNECT_COMPANY', company);
      } else {
        await LocalStorageManger.removeString('username');
        await LocalStorageManger.removeString('password');
        // await LocalStorageManger.removeString('CONNECT_COMPANY');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await LocalStorageManger.removeString('username');
    await LocalStorageManger.removeString('password');
    await LocalStorageManger.removeString('CONNECT_COMPANY');
    _isLoggedIn = false;
    notifyListeners();
  }
}
