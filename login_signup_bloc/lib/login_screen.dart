import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_signup_bloc/bloc/auth_bloc.dart';
import 'package:login_signup_bloc/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Cannot use BlocBuilder because that changes the ui/ui reruns  whenever it listens to any state
// Use BlocListener : used for functionality that needs to occur once i.e. snackbar, navigation showing a dialog bog etc
// and it not make any changes in ui i.e loading etc.

// But using both makes code more complex then instead of BlocListener and BlocConsumer we will use BlocConsumer
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      // here we need to specify the Event and the State
      // body: BlocListener<AuthBloc, AuthState>(
         body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if( state is AuthFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
          else if (state is AuthSuccess){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.success)));
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //can't take  args as it only takes Events
                        authbloc.add(AuthLoginButtonPressed(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()));
                      },
                      child: const Text('Sign In'))
                ],
              ));
                },
        ),
      );
  }
}
