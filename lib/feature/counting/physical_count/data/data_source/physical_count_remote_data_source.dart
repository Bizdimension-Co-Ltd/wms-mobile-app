import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class PhysicalCountRemoteDataSource {
  Future<Map<String, dynamic>> post(Map<String, dynamic> payload);
}

class PhysicalCountRemoteDataSourceImpl implements PhysicalCountRemoteDataSource {
  final DioClient dio;

  PhysicalCountRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> post(Map<String, dynamic> payload) async {
    try {
      final response = await dio.post('/InventoryPostings', data: payload);
      return response.data as dynamic;
    } on Failure {
      rethrow;
    }
  }
}
