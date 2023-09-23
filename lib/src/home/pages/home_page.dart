import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_admin/core/firebase/storage/storage_manager.dart';
import 'package:space_admin/src/common/widget/image_selector_widget.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FormView(),
      ),
    );
  }
}

class FormView extends StatefulWidget {
  FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    TextEditingController _coordinateLat = TextEditingController();
    TextEditingController _coordinateLong = TextEditingController();

    String? url;
    return Padding(
      padding: const EdgeInsets.all(128.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('FormView'),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller2,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
              ),
            ),
            ImageSelectorWidget(
              imageSelected: (image) {
                setState(() {
                  result = image;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _coordinateLat,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lat',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _coordinateLong,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Long',
              ),
            ),
            Opacity(
              opacity: result != null ? 1 : 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  url = await FirebaseStorageManger()
                      .uploadImage(result, 'test', 'test1');

                  final astronomicEventModel = AstronomicEventModel(
                    image: [url ?? ''],
                    coordinate: Coordinate(
                      latitude: double.parse(_coordinateLat.text),
                      longitude: double.parse(_coordinateLong.text),
                    ),
                    startDate: '2017-11-09T08:36:00.834+03:00',
                    endDate: '2017-11-09T08:36:00.834+03:00',
                    description: _controller2.value.text,
                    name: _controller.value.text,
                  );
                  context.read<AstronomicEventBloc>().add(
                        AddAstronomicEvent(astronomicEventModel),
                      );
                },
                child: const Text('Go to second view'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
