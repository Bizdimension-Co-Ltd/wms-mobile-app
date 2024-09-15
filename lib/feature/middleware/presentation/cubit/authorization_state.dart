part of 'authorization_cubit.dart';

sealed class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

final class AuthorizationInitial extends AuthorizationState {}



class RequestLoginFailedState extends AuthorizationState {
  final String message;

  const RequestLoginFailedState({required this.message});
}

class UnAuthorization extends AuthorizationState {}

class RequestingAuthorization extends AuthorizationState {}

class AuthorizationSuccess extends AuthorizationState {}