import '../model/bin_model.dart';
import '/utilies/dio_client.dart';
import '../../../../../core/error/failure.dart';

abstract class ListBatchRemoteDataSource {
  Future<List<Bin>> get(String query);
}

class ListBatchRemoteDataSourceImpl implements ListBatchRemoteDataSource {
  final DioClient dio;

  ListBatchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Bin>> get(String query) async {
    try {
      print('/BinLocations$query');
      final response = await dio.get('/BinLocations$query');

      if (response.statusCode != 200) {
        throw ServerFailure(message: 'error');
      }

      return List.from(response.data['value'])
          .map((e) => Bin.fromJson(e))
          .toList();
    } on Failure {
      rethrow;
    }
  }
}
