import 'package:get_it/get_it.dart';

import 'injector/authenticate_di.dart';
import 'utilies/dio_client.dart';

final getIt = GetIt.instance;

Future<void> container() async {
  getIt.registerLazySingleton(() => DioClient());

//
  DIAuthentication(getIt);
  //
}
