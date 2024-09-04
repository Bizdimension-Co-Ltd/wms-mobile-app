import 'package:get_it/get_it.dart';

import '../feature/pick_and_pack/pick_list/data/data_source/pick_list_remote_data_source.dart';
import '../feature/pick_and_pack/pick_list/data/repository/warehouse_transfer_repository_impl.dart';
import '../feature/pick_and_pack/pick_list/domain/repository/pick_list_repository.dart';
import '../feature/pick_and_pack/pick_list/domain/usecase/find_usecase.dart';
import '../feature/pick_and_pack/pick_list/domain/usecase/post_usecase.dart';
import '../feature/pick_and_pack/pick_list/presentation/cubit/pick_list_cubit.dart';

class DIPickList {
  final GetIt getIt;

  DIPickList(this.getIt) {
    // ********* Bloc **********
    getIt.registerFactory(() {
      return PickListCubit(getIt(), getIt());
    });

    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return FindPickListUseCase(getIt());
    });

    getIt.registerLazySingleton(() {
      return PostPickListUseCase(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<PickListRepository>(() {
      return PickListRepositoryImpl(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<PickListRemoteDataSource>(() {
      return PickListRemoteDataSourceImpl(getIt(), getIt());
    });
  }
}
