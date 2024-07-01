import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/feature/inbound/good_receipt_po/domain/usecase/get_usecase.dart';

part 'purchase_order_state.dart';

class PurchaseOrderCubit extends Cubit<PurchaseOrderState> {
  GetPurchaseOrderUseCase useCase;

  PurchaseOrderCubit(this.useCase) : super(PurchaseOrderInitial());

  void get() {
    emit(RequestingPurchaseOrder());

    
  }
}
