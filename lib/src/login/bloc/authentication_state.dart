part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
    required this.email,
    required this.password,
    required this.loginRequest,
  });

  final SpaceAuthenticationStatus status;
  final String email;
  final String password;
  final PageState loginRequest;

  factory AuthenticationState.initial() => const AuthenticationState(
        status: SpaceAuthenticationStatus.unknown,
        email: '',
        password: '',
        loginRequest: PageState.idle,
      );

  AuthenticationState copyWith({
    SpaceAuthenticationStatus? status,
    String? email,
    String? password,
    PageState? loginRequest,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      loginRequest: loginRequest ?? this.loginRequest,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        loginRequest,
      ];
}
