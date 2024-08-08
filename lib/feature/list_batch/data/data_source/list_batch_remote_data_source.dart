import '../model/bin_model.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class ListBatchRemoteDataSource {
  Future<List<dynamic>> get(String query);
}

class ListBatchRemoteDataSourceImpl implements ListBatchRemoteDataSource {
  final DioClient dio;

  ListBatchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<dynamic>> get(String query) async {
    try {
      final response = await dio.get('/sml.svc/WMS_SERIAL_BATCH$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return List.from(response.data['value'])
          .map((e) => e)
          .toList();
    } on Failure {
      rethrow;
    }
  }
}