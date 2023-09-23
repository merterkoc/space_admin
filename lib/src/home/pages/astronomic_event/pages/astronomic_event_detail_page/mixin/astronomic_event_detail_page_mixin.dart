import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_add_page/astronomic_event_add_page.dart';

mixin AstronomicEventAddPageMixin on State<AstronomicEventAddPage> {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final coordinateController = TextEditingController();
  var imageList = <FilePickerResult>[];

  void addImage(FilePickerResult image) {
    imageList.add(image);
  }

  void addEvent() {
    final updatedAstronomicEvent = AstronomicEventModel(
      name: nameController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      coordinate: Coordinate(
          latitude: double.tryParse(coordinateController.text.split(',')[0]),
          longitude: double.tryParse(coordinateController.text.split(',')[1])),
      image: const [],
    );
    context.read<AstronomicEventBloc>().add(
          AddAstronomicEvent(updatedAstronomicEvent, imageList),
        );
  }
}
