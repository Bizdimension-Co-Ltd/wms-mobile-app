import '../../../../../../../core/error/failure.dart';

abstract class ItemLocaleDataSource {
  Future<List<dynamic>> get(String query);
  Future<dynamic> create(dynamic query, {bool many});
  Future<dynamic> find(String query);
}

class ItemLocaleDataSourceImpl implements ItemLocaleDataSource {
  ItemLocaleDataSourceImpl();

  @override
  Future<List<dynamic>> get(String query) async {
    return [];
    // try {
    //   final response = await dio.get('/Items$query');

    //   if (response.statusCode != 200) {
    //     throw ServerFailure(message: 'error');
    //   }

    //   return response.data['value'] as List<dynamic>;
    // } on Failure {
    //   rethrow;
    // }
  }

  @override
  Future find(String query) async {
    try {
      // final item = database.query('items', where: [])

      // final response = await dio.get('/Items$query');
      // if (response.statusCode != 200) {
      //   throw ServerFailure(message: 'error');
      // }

      // final uomGroup = await dio.get(
      //   '/UnitOfMeasurementGroups(${response.data['UoMGroupEntry']})',
      // );

      // return {
      //   ...response.data,
      //   "BaseUoM": uomGroup.data['BaseUoM'],
      //   "UoMGroupDefinitionCollection":
      //       uomGroup.data['UoMGroupDefinitionCollection'],
      // };
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<dynamic> create(dynamic data, {bool many = false}) async {}
}
