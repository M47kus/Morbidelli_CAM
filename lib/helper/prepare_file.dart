import 'package:morbidelli_cam/provider/global.dart';


void prepareWindow(ref) {
  globalVar.add("DX", double.parse(defaultDX.text));
  globalVar.add("DY", double.parse(defaultDY.text));
  globalVar.add("DZ", double.parse(defaultDZ.text));
  //Init Data entity prepared in super state of data parse
}
