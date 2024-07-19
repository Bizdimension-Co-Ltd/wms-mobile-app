import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/feature/counting/bin_count/domain/usecase/param.dart';
import 'package:wms_mobile/feature/counting/bin_count/domain/usecase/put_usecase.dart';

part 'binlocation_count_state.dart';

class BinlocationCountCubit extends Cubit<BinlocationCountState> {
  PutBinCountUseCase useCase;

  BinlocationCountCubit(this.useCase) : super(BinlocationCountInitial());

   Future<Map<String, dynamic>> put(dynamic query, int docEntry) async {
    emit(RequestingBinlocationCount());
    final params = PutBinCountParams(query: query, docEntry: docEntry);
    final response = await useCase.call(params);
    return response.fold((error) {
      print(error.message);
      throw Exception(error.message);
    }, (success) {
      return success;
    });
  }
}
