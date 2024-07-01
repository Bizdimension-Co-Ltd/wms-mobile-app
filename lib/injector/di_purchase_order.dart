import 'package:get_it/get_it.dart';
import '../feature/inbound/good_receipt_po/presentation/cubit/purchase_order_cubit.dart';
import '../feature/inbound/good_receipt_po/data/data_source/purchase_order_remote_data_source.dart';
import '../feature/inbound/good_receipt_po/data/repository/purchase_order_repository_impl.dart';
import '../feature/inbound/good_receipt_po/domain/repository/purchase_order_repository.dart';
import '../feature/inbound/good_receipt_po/domain/usecase/get_usecase.dart';

class DIPurchaseOrder {
  final GetIt getIt;

  DIPurchaseOrder(this.getIt) {
    // ********* Bloc **********
    getIt.registerFactory(() {
      return PurchaseOrderCubit(getIt());
    });

    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return GetPurchaseOrderUseCase(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<PurchaseOrderRepository>(() {
      return PurchaseOrderRepositoryImpl(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<PurchaseOrderRemoteDataSource>(() {
      return PurchaseOrderRemoteDataSourceImpl(getIt());
    });
  }
}
