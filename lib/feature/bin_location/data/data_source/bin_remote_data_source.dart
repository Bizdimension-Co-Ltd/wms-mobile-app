import '../model/bin_model.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class BinRemoteDataSource {
  Future<List<BinModel>> get(String query);
  Future<APIResponse<List<BinModel>>> fetch(String query);
}

class BinRemoteDataSourceImpl implements BinRemoteDataSource {
  final DioClient dio;

  BinRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BinModel>> get(String query) async {
    try {
      final response = await dio.get('/BinLocations$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return List.from(response.data['value'])
          .map((e) => BinModel.fromJson(e))
          .toList();
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<APIResponse<List<BinModel>>> fetch(String query) async {
    try {
      final response = await dio.get('/BinLocations$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      final data = List.from(response.data['value'])
          .map((e) => BinModel.fromJson(e))
          .toList();

      return APIResponse<List<BinModel>>(
          data: data, next: response.data['next']);
    } on Failure {
      rethrow;
    }
  }
}
