import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wms_mobile/core/error/failure.dart';
import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';

import '../../../../utilies/storage/locale_storage.dart';
import '../../domain/usecase/create_user_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';
import '../../domain/usecase/login_usecase.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  final LoginUseCase useCase;
  final GetUserUseCase getUserUseCase;
  final CreateUserUseCase createUserUseCase;

  AuthorizationCubit(this.useCase, this.createUserUseCase, this.getUserUseCase)
      : super(AuthorizationInitial());

  Future<bool> onRequestLogin(
    LoginEntity entity, {
    bool tokenExpired = false,
  }) async {
    try {
      emit(RequestingAuthorization());
      final response = await useCase.call(entity);
      return await response.fold((error) {
        throw UnauthorizeFailure(message: error.message);
      }, (success) async {
        await LocalStorageManger.removeString('SessionId');
        await LocalStorageManger.setString('SessionId', success);
        return true;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> emitEvent(AuthorizationState event) async {
    emit(event);
  }

  Future<void> onRequestLogout() async {
    try {
      emit(RequestingAuthorization());
      await LocalStorageManger.removeString('SessionId');
      emit(UnAuthorization());
    } catch (e) {
      rethrow;
    }
  }
}
