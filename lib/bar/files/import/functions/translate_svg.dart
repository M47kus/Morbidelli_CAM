import 'package:morbidelli_cam/editor/data_parse.dart';

import '../../../../editor/entity/drill/drill_data.dart';
import '../../../../provider/global.dart';

void translateSVG(svgData, ref, [convertType]) {

  int objId = ref.read(entityProvider.notifier).getNewObjId();
  ref
      .read(entityProvider.notifier)
      .newObject( objId, DrillData(id: objId, drill: importDrill));
  for (var entity in svgData) {
    entity.convert(ref, convertType);
  }
}
