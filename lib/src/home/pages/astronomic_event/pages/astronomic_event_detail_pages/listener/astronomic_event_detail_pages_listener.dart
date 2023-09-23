import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';

mixin AstronomicEventDetailPageListener {
  static BlocConsumer<AstronomicEventBloc, AstronomicEventState> listener(
      {required Widget child}) {
    return BlocConsumer<AstronomicEventBloc, AstronomicEventState>(
      listener: (context, state) {
        if (state.pageState == PageState.success) {
          SnackBar snackBar = const SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state.pageState == PageState.error) {
          SnackBar snackBar = SnackBar(
            content: Text('Request fail: ${state.errorMessage}' ?? ''),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      buildWhen: (previous, current) => previous.pageState != current.pageState,
      builder: (context, state) {
        return state.pageState == PageState.loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : child;
      },
    );
  }
}
