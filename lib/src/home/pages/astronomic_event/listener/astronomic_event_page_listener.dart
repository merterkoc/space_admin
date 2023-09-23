import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';

mixin AstronomicEventPageListener {
  static BlocBuilder<AstronomicEventBloc, AstronomicEventState> listener(
      {required Widget child}) {
    return BlocBuilder<AstronomicEventBloc, AstronomicEventState>(
      buildWhen: (previous, current) => previous.pageState != current.pageState,
      builder: (context, state) {
        return state.pageState == PageState.loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : child;
      },
    );
  }
}
