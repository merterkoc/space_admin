import 'package:flutter/material.dart';
import 'package:space_admin/dio_client.dart';

import 'menu.dart';

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
      body: const Center(
        child: FormView(),
      ),
    );
  }
}

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(128.0),
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
            ElevatedButton(
              onPressed: () async {
                final dio = DioClient();

                final response =
                    await dio.post('http://localhost:8080/api/admin/event', {
                  "name": _controller.text,
                  "start_date": "2017-11-09T08:36:00.834+03:00",
                  "end_date": "2017-11-09T05:36:00.834Z",
                  "description": _controller2.text,
                  "coordinate": {"latitude": 32.00, "longitude": 32.00}
                });
                print(response);
              },
              child: const Text('Go to second view'),
            ),
          ],
        ),
      ),
    );
  }
}
