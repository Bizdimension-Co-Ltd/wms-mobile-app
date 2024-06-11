import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
import 'package:wms_mobile/feature/middleware/domain/usecase/login_usecase.dart';

import '../../../../utilies/storage/locale_storage.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final LoginUseCase useCase;

  AuthorizationBloc(this.useCase) : super(AuthorizationInitial()) {
    on<AuthorizationEvent>((event, emit) async {
      // on submit to sap
      if (event is RequestLoginOnlineEvent) {
        final response = await useCase.call(event.entity);
        response.fold((error) {
          emit(RequestLoginFailedState(message: error.message));
        }, (success) async {
          await LocalStorageManger.removeString('SessionId');
          await LocalStorageManger.setString('SessionId', success);

          emit(AuthorizationSuccess());
        });
      }
    });
  }
}
