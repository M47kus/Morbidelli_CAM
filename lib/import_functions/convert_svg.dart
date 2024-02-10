import 'package:morbidelli_cam/edit_overlay/drill/drill_edit.dart';

import '../edit_overlay/path_directory.dart';
import '../editor_functions/data_parse.dart';
import '../main/load_settings.dart';
import '../provider/path_privider_lib.dart';

void translateSVG(svgData, ref) {
  int newDirId = ref.read(pathDirectoryProvider.notifier).getNewId();
  ref
      .read(pathDirectoryProvider.notifier)
      .add(newDirId, PathDirectory(id: newDirId));
  ref.read(shownSplinesProvider.notifier).update(newDirId, true);
  ref
      .read(entityProvider.notifier)
      .newDirectory(newDirId); //create new directory in main data structure

  int objId = ref.read(entityProvider.notifier).getNewObjId(newDirId);
  ref.read(entityProvider.notifier).newObject(
      newDirId,
      objId,
      DrillData(
        id: objId,
        drill: importDrill
      ));
  for (var entity in svgData) {
    entity.convert(ref, newDirId);
  }
}
