import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecase/post_usecase.dart';

part 'physical_count_state.dart';

class PhysicalCountCubit extends Cubit<PhysicalCountState> {
  PostPhysicalCountUseCase useCase;

  PhysicalCountCubit(this.useCase) : super(PhysicalCountInitial());

  Future<Map<String, dynamic>> post(Map<String, dynamic> query) async {
    emit(RequestingPhysicalCount());
    final response = await useCase.call(query);
    return response.fold((error) {
      print(error.message);
      throw Exception(error.message);
    }, (success) async {
      return success;
    });
  }
}
