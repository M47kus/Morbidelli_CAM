import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/overlay/path_directory.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import '../../../../editor/entity/drill/drill_data.dart';

void translateSVG(svgData, ref, [convertType]) {
  int newDirId = ref.read(pathDirectoryProvider.notifier).getNewId();
  ref
      .read(pathDirectoryProvider.notifier)
      .add(newDirId, PathDirectory(id: newDirId));
  ref.read(shownSplinesProvider.notifier).update(newDirId, true);
  ref
      .read(entityProvider.notifier)
      .newDirectory(newDirId); //create new directory in main data structure

  int objId = ref.read(entityProvider.notifier).getNewObjId(newDirId);
  ref
      .read(entityProvider.notifier)
      .newObject(newDirId, objId, DrillData(id: objId, drill: importDrill));
  for (var entity in svgData) {
    entity.convert(ref, newDirId, convertType);
  }
}
