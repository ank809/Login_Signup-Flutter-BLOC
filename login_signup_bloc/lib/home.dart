import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_signup_bloc/bloc/auth_bloc.dart';
import 'package:login_signup_bloc/login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.uid),
              ElevatedButton(
                  onPressed: () {
                    authBloc.add(AuthLogoutButtonPressed());
                  },
                  child: const Text('Logout'))
            ],
          );
        }
        else{
          return const Center(child: Text('User Not Authenticated'),);
        }
      }),
    );
  }
}
