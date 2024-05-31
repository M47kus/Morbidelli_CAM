import 'package:morbidelli_cam/provider/global.dart';

void prepareWindow(ref) {
  globalVar.add("DZ", double.parse(defaultDZ.text));
  globalVar.add("DY", double.parse(defaultDY.text));
  globalVar.add("DX", double.parse(defaultDX.text));
  //Init Data entity prepared in super state of data parse
}
