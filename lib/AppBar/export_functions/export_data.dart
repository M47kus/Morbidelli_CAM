import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:morbidelli_cam/editor_functions/data_parse.dart';
import 'package:morbidelli_cam/main/load_settings.dart';
import '../../edit_overlay/circle3p/cir3p_edit.dart';
import '../../edit_overlay/drill/drill_edit.dart';
import '../../edit_overlay/g0/go_edit.dart';
import '../../edit_overlay/g1/g1_edit.dart';
import '../../provider/path_privider_lib.dart';
import '../../provider/provider_lib.dart';
import '../drill/drill_class.dart';

Future<void> exportXXL(ref) async {
  print("export");
  var state = ref.read(entityProvider);
  String lines = "";
  String workspace = "AD";

  lines +=
      'H DX=${double.parse(modelDX.text)} DY=${double.parse(modelDY.text)} DZ=${double.parse(modelDZ.text)} -$workspace C=0 T=0 R=99 *MM /"W"';

  for (int dirId in state.keys) {
    if (ref.watch(shownSplinesProvider)[dirId] != null) {
      if (ref.read(shownSplinesProvider)[dirId]) {
        Drill selectedDrill = ref
            .read(drillclassprovider)
            .values
            .toList()[0]; //select first drill in list

        for (var entity in state[dirId]!.values) {
          if (entity is DrillData) {
            selectedDrill = entity.drill!;
          } else if (entity is G0Data) {
            lines += entity.getXXLData(selectedDrill);
          } else if (entity is G1Data) {
            lines += entity.getXXLData();
          } else if (entity is Cir3PData) {}
        }
      }
    }
  }

  String? outputPath = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select an output file:',
    fileName: 'output-file.xxl',
  );

  if (outputPath == null) {
    // User canceled the picker
  } else {
    File outputFile = File(outputPath);
    outputFile.writeAsString(lines);
  }
}
