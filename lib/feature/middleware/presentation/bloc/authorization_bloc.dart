// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wms_mobile/feature/middleware/domain/entity/login_entity.dart';
// import 'package:wms_mobile/feature/middleware/domain/usecase/get_user_usecase.dart';
// import 'package:wms_mobile/feature/middleware/domain/usecase/login_usecase.dart';

// import '../../../../utilies/storage/locale_storage.dart';
// import '../../domain/usecase/create_user_usecase.dart';

// part 'authorization_event.dart';
// part 'authorization_state.dart';

// class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
//   final LoginUseCase useCase;
//   final GetUserUseCase getUserUseCase;
//   final CreateUserUseCase createUserUseCase;

//   AuthorizationBloc(this.useCase, this.getUserUseCase, this.createUserUseCase)
//       : super(AuthorizationInitial()) {
//     // on<AuthorizationEvent>((event, emit) async {
//     //   // on submit to sap
//     //   if (event is RequestLoginOnlineEvent) {
//     //     emit(RequestingAuthorization());
//     //     //
//     //     final response = await useCase.call(event.entity);
//     //     await response.fold((error) {
//     //       emit(RequestLoginFailedState(message: error.message));
//     //     }, (success) async {
//     //       await LocalStorageManger.removeString('SessionId');
//     //       await LocalStorageManger.setString('SessionId', success);
//     //       emit(AuthorizationSuccess());
//     //     });
//     //   } else {
//     //     emit(RequestingAuthorization());
//     //     await LocalStorageManger.removeString('SessionId');
//     //     await LocalStorageManger.removeString('warehouse');
//     //     emit(UnAuthorization());
//     //   }
//     // });
//   }

//   Future<void> onRequestLogin(LoginEntity entity) async {
//     try {
//           final response = await useCase.call(entity);
//           await response.fold((error) {
//             emit(RequestLoginFailedState(message: error.message));
//           }, (success) async {
//             await LocalStorageManger.removeString('SessionId');
//             await LocalStorageManger.setString('SessionId', success);
//             emit(AuthorizationSuccess());
//           });
//         } else {
//           emit(RequestingAuthorization());
//           await LocalStorageManger.removeString('SessionId');
//           await LocalStorageManger.removeString('warehouse');
//           emit(UnAuthorization());
//         }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<dynamic> createUser(LoginEntity entity) async {
//     final response = await createUserUseCase.call(entity);

//     return response.fold((err) {
//       print(err);
//       return [];
//     }, (res) {
//       return res;
//     });
//   }

//   Future<List<dynamic>> getUsers() async {
//     final response = await getUserUseCase.call();

//     return response.fold((err) {
//       return [];
//     }, (res) {
//       return res;
//     });
//   }
// }
