import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wms_mobile/model/direct_put_away.dart';

class DirectPutAwayServices {
  final Dio dio = Dio();
  String apiUrl =
      "https://svr11.biz-dimension.com:50000/b1s/v1/GoodsReturnRequest";

  Object? documentSerie = {"Document": "234000032"};

  Future<void> postData(DirectPutAway data) async {
    print(data);
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: "sessionId");

    try {
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            "Cookie": "B1SESSION=$token; ROUTEID=.node4",
            "Content-Type": "application/json",
          },
        ),
        data: data.toJson(),
      );
      // Handle the response here
      print(response.data);
    } catch (error) {
      // Handle errors here
      print('Errorsssssssss: $error');
    }
  }

  Future<void> updateData(String id, DirectPutAway data) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: "sessionId");
    try {
      final response = await dio.patch("$apiUrl('$id')",
          options: Options(
            headers: {
              "Cookie": "B1SESSION=$token; ROUTEID=.node4",
              "Content-Type": "application/json",
            },
          ),
          data: data.toJson());
      // Handle the response here
      print(response.data);
    } catch (error) {
      // Handle errors here
      print('Error: $error');
    }
  }
}
