part of  'auth_bloc.dart';
sealed class AuthState {}

class AuthInitial extends AuthState{
}

class AuthFailure extends AuthState{
  final String error;
  AuthFailure(this.error);
}

class AuthSuccess extends AuthState{
  final String success;
  final String uid;
  AuthSuccess(this.uid, this.success);
}

class AuthLoading extends AuthState{
  
}
