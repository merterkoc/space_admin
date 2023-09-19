import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ImageSelected = void Function(FilePickerResult? result);

class ImageSelectorWidget extends StatefulWidget {
  const ImageSelectorWidget({super.key, required this.imageSelected});

  final ImageSelected imageSelected;

  @override
  ImageSelectorWidgetState createState() => ImageSelectorWidgetState();
}

class ImageSelectorWidgetState extends State<ImageSelectorWidget> {
  Uint8List? fileBytes;
  FilePickerResult? result;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (fileBytes != null) ...[
          Image.memory(fileBytes!),
          const SizedBox(height: 20),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _selectImage,
          child: const Text('Select image'),
        ),
      ],
    );
  }

  void _selectImage() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    setState(() {
      fileBytes = result?.files.first.bytes;
    });
    widget.imageSelected(result);
  }
}
