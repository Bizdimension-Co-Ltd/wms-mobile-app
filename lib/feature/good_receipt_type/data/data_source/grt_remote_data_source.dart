import '../model/grt_model.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class GrtRemoteDataSource {
  Future<List<Grt>> get(String query);
}

class GrtRemoteDataSourceImpl implements GrtRemoteDataSource {
  final DioClient dio;

  GrtRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Grt>> get(String query) async {
    try {
      print('/sml.svc/TL_OGIN$query');
      final response = await dio.get('/sml.svc/TL_OGIN$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return List.from(response.data['value'])
          .map((e) => Grt.fromJson(e))
          .toList();
    } on Failure {
      rethrow;
    }
  }
}
