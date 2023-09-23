import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_admin/core/router/space_router/pages.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_pages/astronomic_event_detail_page.dart';
import 'package:space_admin/src/home/shell_page/shell_page.dart';

final class SpaceRouter {
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, currentPage) {
          return ShellPage(currentPage: currentPage);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: '/astronomic-event',
            builder: (BuildContext context, GoRouterState state) {
              return const AstronomicEventPage();
            },
            routes: [
              GoRoute(
                path: ':id',
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

  get router => _router;
}
