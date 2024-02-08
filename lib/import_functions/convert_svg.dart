import '../edit_overlay/path_directory.dart';
import '../editor_functions/data_parse.dart';
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

  for (var entity in svgData) {
    entity.convert(ref, newDirId);
  }
}
