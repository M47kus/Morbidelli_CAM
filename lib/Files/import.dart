import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<String> change_file({state}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    String file_content = File(result.files.single.path!).readAsStringSync();
    return file_content;
  } else {
    print("abort");
    return state;
  }
}

