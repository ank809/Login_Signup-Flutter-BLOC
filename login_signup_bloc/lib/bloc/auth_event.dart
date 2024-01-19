part of 'auth_bloc.dart';

//auth events are basically an input 
sealed class AuthEvent {}

class AuthLoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  AuthLoginButtonPressed({required this.email, required this.password});
}

class AuthLogoutButtonPressed extends AuthEvent{}