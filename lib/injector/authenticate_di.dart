import 'package:get_it/get_it.dart';
import 'package:wms_mobile/feature/middleware/domain/usecase/get_user_usecase.dart';
import 'package:wms_mobile/feature/middleware/presentation/bloc/authorization_bloc.dart';
import '../feature/middleware/data/data_source/login_local_data_souce.dart';
import '../feature/middleware/domain/usecase/create_user_usecase.dart';
import '/feature/middleware/data/repository/login_repository_impl.dart';
import '/feature/middleware/domain/repository/login_repository.dart';
import '/feature/middleware/domain/usecase/login_usecase.dart';

import '../feature/middleware/data/data_source/login_remote_data_source.dart';

class DIAuthentication {
  final GetIt getIt;

  DIAuthentication(this.getIt) {
    // ********* Bloc **********
    getIt.registerFactory(() {
      return AuthorizationBloc(getIt(), getIt(), getIt());
    });

    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return LoginUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return GetUserUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return CreateUserUseCase(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<LoginRemoteDataSource>(() {
      return LoginRemoteDataSourceImpl(getIt());
    });

    getIt.registerLazySingleton<LoginLocalDataSource>(() {
      return LoginLocalDataSourceImpl(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<LoginRepository>(() {
      return LoginRepositoryImpl(getIt(), getIt());
    });
  }
}
