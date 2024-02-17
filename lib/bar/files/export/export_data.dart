import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/g0/go_data.dart';
import 'package:morbidelli_cam/editor/entity/g1/g1_data.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';
import '../../../editor/entity/circle3p/cir3p_data.dart';
import '../../../editor/entity/drill/drill_data.dart';
import '../../drill/drill_class.dart';

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
          } else if (entity is Cir3PData) {
            lines += entity.getXXLData();
          }
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
