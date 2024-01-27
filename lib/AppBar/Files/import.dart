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

// File plainSVG = File("/home/markus/IdeaProjects/Zeichnung.svg");
// XmlDocument document = XmlDocument.parse(plainSVG.readAsStringSync());
// int pathLenght = document
//     .findAllElements("g")
//     .map((element) => element.findAllElements("path").length)
//     .elementAt(0);
// for (int i = 0; i < pathLenght; i++) {
// List an = document
//     .findAllElements("g")
//     .map((element) =>
// element.findAllElements("path").elementAt(i).attributes)
//     .toList()[0];
// for (int i = 0; i < an.length; i++) {
// if (an[i].name.toString() == "d") {
// String value = an[i].value;
// print(value);
// }
// }
// }