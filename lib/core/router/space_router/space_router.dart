import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_admin/core/router/space_router/pages.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_add_page/astronomic_event_add_page.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_page/astronomic_event_detail_page.dart';
import 'package:space_admin/src/home/shell_page/shell_page.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';
import 'package:space_admin/src/login/model/enum/authentication_status.dart';
import 'package:space_admin/src/login/pages/login_page.dart';

enum SpaceRoute {
  login(name: 'login', path: '/login'),
  home(name: 'home', path: '/home'),
  astronomicEvent(name: 'astronomic_event', path: '/astronomic-event'),
  astronomicEventAdd(
      name: 'astronomic_event_add', path: 'astronomic-event-add'),
  astronomicEventDetail(
      name: 'astronomic_event_detail', path: 'astronomic-event-detail');

  final String path;
  final String name;

  const SpaceRoute({
    required this.path,
    required this.name,
  });
}

final class SpaceRouter {
  final GoRouter _router = GoRouter(
    initialLocation: SpaceRoute.login.path,
    redirect: (context, state) {
      final authState = context.read<AuthenticationBloc>().state;
      if (authState.status.isUnauthenticated) {
        return SpaceRoute.login.path;
      }
      return null;
    },
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, currentPage) {
          return ShellPage(currentPage: currentPage);
        },
        routes: [
          GoRoute(
            path: SpaceRoute.login.path,
            name: SpaceRoute.login.name,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
            redirect: (context, state) {
              final authState = context.read<AuthenticationBloc>().state;
              if (authState.status.isAuthenticated) {
                return SpaceRoute.home.path;
              }
              return null;
            },
          ),
          GoRoute(
            path: SpaceRoute.home.path,
            name: SpaceRoute.home.name,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: SpaceRoute.astronomicEvent.path,
            name: SpaceRoute.astronomicEvent.name,
            builder: (BuildContext context, GoRouterState state) {
              return const AstronomicEventPage();
            },
            routes: [
              GoRoute(
                path: SpaceRoute.astronomicEventAdd.path,
                name: SpaceRoute.astronomicEventAdd.name,
                builder: (BuildContext context, GoRouterState state) {
                  return const AstronomicEventAddPage();
                },
              ),
              GoRoute(
                path: SpaceRoute.astronomicEventDetail.path,
                name: SpaceRoute.astronomicEventDetail.name,
                builder: (BuildContext context, GoRouterState state) {
                  return AstronomicEventDetailPage(
                    id: state.pathParameters['id'] as String,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  GoRouter get router => _router;
}
