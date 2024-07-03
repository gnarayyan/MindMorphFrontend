part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

final class LoginLoading extends LoginState {}
