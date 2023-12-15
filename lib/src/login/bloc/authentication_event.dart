part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends AuthenticationEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthenticationEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final SpaceAuthenticationStatus status;

  @override
  List<Object?> get props => [status];
}

class LoginSubmitted extends AuthenticationEvent {}

class LogoutSubmitted extends AuthenticationEvent {}
