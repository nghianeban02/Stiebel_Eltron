part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isLoading;
  LoginLoading({required this.isLoading});
}
class LoginSuccess extends LoginState {

}
class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
class GetInfoSuccess extends LoginState{
  final UserModel user_model;
  GetInfoSuccess({required this.user_model});
}
