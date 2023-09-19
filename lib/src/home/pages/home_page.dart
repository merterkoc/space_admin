import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:space_admin/core/dio/dio_client.dart';
import 'package:space_admin/core/firebase/storage/storage_manager.dart';
import 'package:space_admin/src/common/widget/image_selector_widget.dart';
import 'package:space_admin/src/home/component/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
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
            Opacity(
              opacity: result != null ? 1 : 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  final url = await FirebaseStorageManger()
                      .uploadImage(result, 'test', 'test1');

                  final dio = DioClient();

                  final response =
                      await dio.post('http://localhost:8080/api/admin/event', {
                    "name": _controller.text,
                    "start_date": "2017-11-09T08:36:00.834+03:00",
                    "end_date": "2017-11-09T05:36:00.834Z",
                    "description": _controller2.text,
                    "image": [url],
                    "coordinate": {"latitude": 32.00, "longitude": 32.00}
                  });
                  print(response);
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
