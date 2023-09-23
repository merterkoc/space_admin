import 'package:flutter/material.dart';
import 'package:space_admin/src/common/widget/image_selector_widget.dart';
import 'package:space_admin/src/home/component/date_picker.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_add_page/listener/astronomic_event_add_listener.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_page/mixin/astronomic_event_detail_page_mixin.dart';

class AstronomicEventAddPage extends StatefulWidget {
  const AstronomicEventAddPage({super.key});

  @override
  State<AstronomicEventAddPage> createState() => _AstronomicEventAddPageState();
}

class _AstronomicEventAddPageState extends State<AstronomicEventAddPage>
    with AstronomicEventAddPageMixin {
  @override
  Widget build(BuildContext context) {
    return AstronomicEventAddPageListener.listener(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('FormView'),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Description',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Start Date'),
                SpaceDatePicker(
                  onDateSelected: (date) {
                    startDateController.text = date.toString();
                  },
                ),
                const SizedBox(height: 20),
                const Text('End Date'),
                SpaceDatePicker(
                  onDateSelected: (date) {
                    endDateController.text = date.toString();
                  },
                ),
                const SizedBox(height: 20),
                ImageSelectorWidget(
                  imageSelected: (image) {
                    setState(() {
                      if (image != null) {
                        addImage(image);
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: coordinateController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Coordinate (lat, long)',
                  ),
                ),
                Opacity(
                  opacity: imageList.isNotEmpty ? 1 : 0.5,
                  child: ElevatedButton(
                    onPressed: addEvent,
                    child: const Text('Add Event'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
