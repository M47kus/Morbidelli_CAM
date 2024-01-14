import 'package:ditredi/ditredi.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';
import 'package:morbidelli_cam/edit_overlay/g1/g1_edit.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../../path_privider_lib.dart';

Group3D modelEntityLines(ref) {
  Map entityFolder =
      ref.read(pathEntityProvider)[ref.watch(pathDirectoryIdProvider)]!;

  List<Line3D> modelLines = [];
  int? lineStart;
  List spline = [];

  for (var entity in entityFolder.values) {
    if (entity is G0Data) {
      if (spline.isNotEmpty) {
        for (int index = 0; index < spline.length; index++) {
          if (index < spline.length - 1) {
            modelLines.add(Line3D(
                vector.Vector3(spline[index].modelX(), spline[index].modelZ(),
                    spline[index].modelY()),
                vector.Vector3(spline[index + 1].modelX(),
                    spline[index + 1].modelZ(), spline[index + 1].modelY()),
                width: 1));
          }
        }
        spline.clear();
      }

      lineStart = entity.id;
      spline.add(entity);
    } else if (entity is G1Data && lineStart != null) {
      if (entity.id > lineStart) {
        spline.add(entity);
      }
    }
  }

  if (spline.isNotEmpty) {
    for (int index = 0; index < spline.length; index++) {
      if (index < spline.length - 1) {
        modelLines.add(Line3D(
            vector.Vector3(spline[index].modelX(), spline[index].modelZ(),
                spline[index].modelY()),
            vector.Vector3(spline[index + 1].modelX(),
                spline[index + 1].modelZ(), spline[index + 1].modelY()),
            width: 1));
      }
    }
    spline.clear();
  }

  return Group3D(modelLines);
}
