import 'package:flutter/material.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_pages/listener/astronomic_event_detail_pages_listener.dart';
import 'package:space_admin/src/home/pages/astronomic_event/pages/astronomic_event_detail_pages/mixin/astronomic_event_detail_page_mixin.dart';

class AstronomicEventDetailPage extends StatefulWidget {
  const AstronomicEventDetailPage({super.key, required this.id});

  final String id;

  @override
  State<AstronomicEventDetailPage> createState() =>
      _AstronomicEventDetailPageState();
}

class _AstronomicEventDetailPageState extends State<AstronomicEventDetailPage>
    with AstronomicEventDetailPageMixin {
  @override
  Widget build(BuildContext context) {
    return AstronomicEventDetailPageListener.listener(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      TextField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      astronomicEventModel.image != null &&
                              astronomicEventModel.image!.isNotEmpty
                          ? Image.network(astronomicEventModel.image?.first ?? '')
                          : const Icon(Icons.image),
                      ElevatedButton(
                          onPressed: updateEvent, child: const Text('Save'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
