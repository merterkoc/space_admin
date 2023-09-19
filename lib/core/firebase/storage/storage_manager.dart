import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageManger {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadImage(
      FilePickerResult? result, String path, String fileName) async {
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      if (fileBytes != null) {
        final result =
            await _firebaseStorage.ref(path).child(fileName).putData(fileBytes);
        final url = await result.ref.getDownloadURL();
        return url;
      } else {
        return null;
      }
    }
    return null;
  }
}
