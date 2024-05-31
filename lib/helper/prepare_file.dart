import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/initial/init_data.dart';
import 'package:morbidelli_cam/provider/global.dart';

void prepareWindow(ref) {
  globalVar.add("DZ", double.parse(defaultDZ.text));
  globalVar.add("DY", double.parse(defaultDY.text));
  globalVar.add("DX", double.parse(defaultDX.text));
  //Init Data entity prepared in super state of data parse
}
