import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/login/model/enum/authentication_status.dart';
import 'package:space_admin/src/repository/authentication_repository/authentication_repository.dart';
import 'package:space_admin/src/repository/model/dto/login_dto.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<SpaceAuthenticationStatus> _subscription;

  AuthenticationBloc() : super(AuthenticationState.initial()) {
    on<LoginSubmitted>((event, emit) => _onLoginSubmitted(event, emit));
    on<EmailChanged>((event, emit) => _onEmailChanged(event, emit));
    on<PasswordChanged>((event, emit) => _onPasswordChanged(event, emit));
    on<AuthenticationStatusChanged>(
        (event, emit) => _onAuthenticationStatusChanged(event, emit));
    on<LogoutSubmitted>((event, emit) => _onLogoutSubmitted(event, emit));

    _authenticationRepository = AuthenticationRepository();
    _subscription =
        _authenticationRepository.authenticationStatus.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(loginRequest: PageState.loading));
    await Future.delayed(const Duration(seconds: 1));
    final response = await _authenticationRepository
        .login(LoginDTO(email: state.email, password: state.password));

    if (response.isOk) {
      _onLoginSuccess(emit);
    } else {
      _onLoginError(emit);
    }
  }

  void _onLoginSuccess(Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      status: SpaceAuthenticationStatus.authenticated,
      loginRequest: PageState.success,
    ));
  }

  void _onLoginError(Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      status: SpaceAuthenticationStatus.unauthenticated,
      loginRequest: PageState.error,
    ));
  }

  _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(status: event.status));
  }

  _onEmailChanged(EmailChanged event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(password: event.password));
  }

  _onLogoutSubmitted(LogoutSubmitted event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logout();
    emit(state.copyWith(status: SpaceAuthenticationStatus.unauthenticated));
  }
}
