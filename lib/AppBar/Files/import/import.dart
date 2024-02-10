import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:morbidelli_cam/import_functions/import_svg.dart';

import '../../../provider/provider_lib.dart';

//File picker return new or old file
Future<String?> importFile(ref) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['obj', 'svg'],
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

