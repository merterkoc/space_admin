import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/common/widget/text_view.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Form(
      child: Column(
        children: [
          TextView(
            padding: const EdgeInsets.all(10),
            textEditingController: emailController,
            focusNode: FocusNode(),
            labelText: 'Email',
            onChanged: (value) {
              context.read<AuthenticationBloc>().add(
                    EmailChanged(email: value ?? ''),
                  );
            },
          ),
          const SizedBox(height: 20),
          TextView(
            padding: const EdgeInsets.all(10),
            textEditingController: passwordController,
            focusNode: FocusNode(),
            obscureText: true,
            labelText: 'Password',
            onChanged: (value) {
              context.read<AuthenticationBloc>().add(
                    PasswordChanged(password: value ?? ''),
                  );
            },
          ),
          const SubmitButton(),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) =>
          previous.loginRequest != current.loginRequest ||
          previous.email != current.email ||
          previous.password != current.password,
      builder: (context, state) {
        return Opacity(
          opacity:
              state.email.isNotEmpty && state.password.isNotEmpty ? 1 : 0.5,
          child: ElevatedButton(
            onPressed: () {
              if (state.loginRequest != PageState.loading &&
                  state.email.isNotEmpty &&
                  state.password.isNotEmpty) {
                context.read<AuthenticationBloc>().add(
                      LoginSubmitted(),
                    );
              }
            },
            child: state.loginRequest.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Login'),
          ),
        );
      },
    );
  }
}
