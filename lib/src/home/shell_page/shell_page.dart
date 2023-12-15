import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/home/component/menu.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';
import 'package:space_admin/src/login/listener/authentication_listener.dart';
import 'package:space_admin/src/login/model/enum/authentication_status.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.currentPage});

  final Widget currentPage;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ...AuthenticationListeners.routeListeners(),
      ],
      child: Scaffold(
        body: Row(
          children: [
            if (context.read<AuthenticationBloc>().state.status.isAuthenticated)
              const SideMenu(),
            Expanded(
              child: widget.currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
