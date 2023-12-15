import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_admin/core/router/space_router/space_router.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';
import 'package:space_admin/src/login/model/enum/authentication_status.dart';

mixin AuthenticationListeners {
  /// main app location listeners
  static List<BlocListener<AuthenticationBloc, AuthenticationState>>
      routeListeners() {
    return [
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, authenticationState) async {
          if (authenticationState.status.isAuthenticated) {
            context.goNamed(SpaceRoute.home.name);
          } else if (authenticationState.status.isUnauthenticated) {
            context.goNamed(SpaceRoute.login.name);
          }
        },
      ),
    ];
  }
}
