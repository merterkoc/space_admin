import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/common/widget/text_view.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          EmailText(),
          SizedBox(height: 20),
          PasswordText(),
          SubmitButton(),
        ],
      ),
    );
  }
}

class EmailText extends StatelessWidget {
  const EmailText({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return TextView(
      padding: const EdgeInsets.all(10),
      textEditingController: emailController,
      focusNode: FocusNode(),
      labelText: 'Email',
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(
              EmailChanged(email: value ?? ''),
            );
      },
    );
  }
}

class PasswordText extends StatefulWidget {
  const PasswordText({super.key});

  @override
  State<PasswordText> createState() => _PasswordTextState();
}

class _PasswordTextState extends State<PasswordText> {
  final passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextView(
      padding: const EdgeInsets.all(10),
      textEditingController: passwordController,
      focusNode: FocusNode(),
      obscureText: !passwordVisible,
      textInputType: TextInputType.visiblePassword,
      labelText: 'Password',
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(
              PasswordChanged(password: value ?? ''),
            );
      },
      suffixIcon: IconButton(
        icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(
            () {
              passwordVisible = !passwordVisible;
            },
          );
        },
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
