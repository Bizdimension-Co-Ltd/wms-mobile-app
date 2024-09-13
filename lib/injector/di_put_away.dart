import 'package:get_it/get_it.dart';
import 'package:wms_mobile/feature/pick_and_pack/put_away/presentation/cubit/put_away_cubit.dart';

import '../feature/pick_and_pack/put_away/data/data_source/put_away_remote_data_source.dart';
import '../feature/pick_and_pack/put_away/data/repository/put_away_repository_impl.dart';
import '../feature/pick_and_pack/put_away/domain/repository/put_away_repository.dart';
import '../feature/pick_and_pack/put_away/domain/usecase/post_usecase.dart';

class DiPutAway {
  final GetIt getIt;

  DiPutAway(this.getIt) {
    // ********* Bloc **********
    getIt.registerFactory(() {
      return PutAwayCubit(getIt());
    });

    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return PostPutAwayUseCase(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<PutAwayRepository>(() {
      return PutAwayRepositoryImpl(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<PutAwayRemoteDataSource>(() {
      return PutAwayRemoteDataSourceImpl(getIt());
    });
  }
}
