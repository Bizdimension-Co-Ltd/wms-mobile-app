import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class ProductLookUpRemoteDataSource {
  Future<Map<String, dynamic>> get(Map<String, dynamic> filter);
}

class ProductLookUpRemoteDataSourceImpl implements ProductLookUpRemoteDataSource {
  final DioClient dio;

  ProductLookUpRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> get(Map<String, dynamic> filter) async {
    try {
      final response = await dio.get("/sml.svc/BIZ_BIN_QUERY?\$filter=ItemCode eq '${filter["itemCode"]}' and WhsCode eq '${filter["warehouseCode"]}'");
      return response.data as dynamic;
    } on Failure {
      rethrow;
    }
  }
}
