import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';
import 'package:space_admin/src/login/bloc/authentication_bloc.dart';
import 'package:space_admin/src/repository/repository.dart';

class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AstronomicEventBloc(AstronomicEventRepository())),
        BlocProvider(create: (context) => AuthenticationBloc()),
      ],
      child: child,
    );
  }
}
