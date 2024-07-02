import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class ItemRemoteDataSource {
  Future<List<dynamic>> get(String query);
  Future<dynamic> find(String query);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final DioClient dio;

  ItemRemoteDataSourceImpl(this.dio);

  @override
  Future<List<dynamic>> get(String query) async {
    try {
      final response = await dio.get('/Items$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return response.data['value'] as List<dynamic>;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future find(String query) async {
    try {
      final response = await dio.get('/Items$query');
      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return response.data as dynamic;
    } on Failure {
      rethrow;
    }
  }
}
