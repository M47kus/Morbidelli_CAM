import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<File?> get_file() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    print("abort");
    return null;
  }
}

