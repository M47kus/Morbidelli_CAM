import 'dart:io';
import 'package:file_picker/file_picker.dart';

//File picker return new or old file
Future<String> changeFile({state}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    String fileContent = File(result.files.single.path!).readAsStringSync();
    return fileContent;
  } else {
    return state;
  }
}
