import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../../provider/provider_lib.dart';
import 'convert_svg.dart';

//File picker return new or old file
Future<void> importFile(ref, [extension]) async {
  List<String> allowedextension = [];
  if (extension != null) {
    allowedextension.add(extension);
  } else {
    allowedextension = ['obj', 'svg'];
  }
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedextension,
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    if (file.extension.toString() == "svg") {
      print("svg");
      convertSVG(file.path, ref);
    } else if (file.extension.toString() == "obj") {
      print("obj");
      String fileContent = File(result.files.single.path!).readAsStringSync();
      ref.read(modelContentProvider.notifier).set(fileContent);
    }
  } else {
    //do nothing
  }
}
