import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_mobile/feature/warehouse/presentation/screen/warehouse_page.dart';
import 'package:wms_mobile/mobile_function/dashboard.dart';
import 'package:wms_mobile/utilies/storage/locale_storage.dart';
import '/feature/middleware/presentation/bloc/authorization_bloc.dart';
import '/feature/middleware/presentation/login_screen.dart';
import 'constant/style.dart';
// import 'package:iscan_data_plugin/iscan_data_plugin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPickedWarehuse = false;

  @override
  void initState() {
    init();
    // IscanDataPlugin.methodChannel.setMethodCallHandler((MethodCall call) async {
    //   log('call.method 1 -> ${call.method}');
    //   if (call.method == "onScanResults") {
    //     setState(() {
    //       log(call.arguments['data']);
    //     });
    //   }
    // });

    super.initState();
  }

  void init() async {
    final value = await LocalStorageManger.getString('warehouse');
    if (value != '') {
      setState(() {
        isPickedWarehuse = true;
      });
    }
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
              ? isPickedWarehuse
                  ? Dashboard()
                  : WarehousePage(isPicker: true)
              : const LoginScreen(),
        );
      },
    );
  }
}
