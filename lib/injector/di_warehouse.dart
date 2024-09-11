import 'package:get_it/get_it.dart';
import 'package:wms_mobile/feature/warehouse/domain/repository/warehouse_local_repository.dart';
import 'package:wms_mobile/feature/warehouse/domain/usecase/create_local_usecase.dart';
import 'package:wms_mobile/feature/warehouse/domain/usecase/delete_local_usecase.dart';
import 'package:wms_mobile/feature/warehouse/domain/usecase/find_local_usecase.dart';
import 'package:wms_mobile/feature/warehouse/domain/usecase/get_local_usecase.dart';
import 'package:wms_mobile/feature/warehouse/domain/usecase/update_local_usecase.dart';

import '../feature/warehouse/data/data_source/warehouse_local_data_source.dart';
import '../feature/warehouse/data/data_source/warehouse_remote_data_source.dart';
import '../feature/warehouse/data/repository/warehouse_repository_impl.dart';
import '../feature/warehouse/data/repository/warehouse_repository_local_impl.dart';
import '../feature/warehouse/domain/repository/warehouse_repository.dart';
import '../feature/warehouse/domain/usecase/delete_all_local_usecase.dart';
import '../feature/warehouse/domain/usecase/get_usecase.dart';
import '../feature/warehouse/presentation/cubit/warehouse_cubit.dart';

class DIWarehouse {
  final GetIt getIt;

  DIWarehouse(this.getIt) {
    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return GetWarehouseUseCase(getIt());
    });

    getIt.registerLazySingleton(() {
      return GetWarehouseLocalUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return FindWarehouseLocalUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return CreateWarehouseLocalUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return UpdateWarehouseLocalUseCase(getIt());
    });
    getIt.registerLazySingleton(() {
      return DeleteWarehouseLocalUseCase(getIt());
    });

    getIt.registerLazySingleton(() {
      return DeleteAllWarehouseLocalUseCase(getIt());
    });

    // ********* Bloc **********
    getIt.registerFactory(() {
      return WarehouseCubit(
          getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<WarehouseRepository>(() {
      return WarehouseRepositoryImpl(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<WarehouseLocalRepository>(() {
      return WarehouseLocalRepositoryImpl(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<WarehouseRemoteDataSource>(() {
      return WarehouseRemoteDataSourceImpl(getIt());
    });
    getIt.registerLazySingleton<WarehouseLocalDataSource>(() {
      return WarehouseLocalDataSourceImpl(getIt());
    });
  }
}
