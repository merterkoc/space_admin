import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';
import 'package:space_admin/src/login/form/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous.loginRequest != current.loginRequest &&
          current.loginRequest.isError,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login Page'),
              SizedBox(height: 20),
              LoginForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
