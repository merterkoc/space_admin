import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_page/astronomic_event_detail_page.dart';

mixin AstronomicEventDetailPageMixin on State<AstronomicEventDetailPage> {
  late AstronomicEventModel astronomicEvent;

  late AstronomicEventModel astronomicEventModel;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    AstronomicEventState state = context.read<AstronomicEventBloc>().state;
    astronomicEventModel = state.astronomicEventList
        .firstWhere((element) => element.id == widget.id);
    astronomicEvent = state.astronomicEventList
        .firstWhere((element) => element.id == widget.id);
    nameController.text = astronomicEvent.name ?? '';
    descriptionController.text = astronomicEvent.description ?? '';
    super.initState();
  }

  void updateEvent() {
    final updatedAstronomicEvent = astronomicEvent.copyWith(
      name: nameController.text,
      description: descriptionController.text,
    );
    context.read<AstronomicEventBloc>().add(
          UpdateAstronomicEvent(updatedAstronomicEvent),
        );
  }
}
