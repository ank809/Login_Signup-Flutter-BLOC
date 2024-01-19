import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc():super(AuthInitial()){
    on<AuthLoginButtonPressed>((event, emit) {
      emit(AuthLoading());
    final email=event.email;
    final password=event.password;

      try{
        if (password.length<6){
        return emit(AuthFailure('Password length is too short'));
      }
      else if (!isValidEmail(email)){
        return emit(AuthFailure('Email is not valid'));
      }
      else if (password.isEmpty){
        return emit(AuthFailure('Password can not be empty'));
      }
      else if (email.isEmpty){
        return emit(AuthFailure('Email can not be empty'));
      }
      else{
        return emit(AuthSuccess('$email-$password' ,'Success'));
      }
      }catch(e){
        return emit(AuthFailure(e.toString()));
      }
    });

    on<AuthLogoutButtonPressed>((event, emit) {
      try{
        return emit(AuthInitial());
      }catch(e){
        return emit(AuthFailure(e.toString()));
      }
    });
  }

bool isValidEmail(String email){
   final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);

}
}