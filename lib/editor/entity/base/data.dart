import 'package:morbidelli_cam/helper/extensions/parse_internal_var.dart';

import '../../../provider/global.dart';

class Data {
  String? x;
  String? y;
  String? z;
  int? fix;

  convertX() {
    double dx = modelDX;
    if (x.parseInternalVar() != null) {
      switch (fix) {
        case 1 || 4 || 7:
          return x.parseInternalVar();
        case 2 || 5 || 8:
          return x.parseInternalVar()! + dx / 2;
        case 3 || 6 || 9:
          return dx - x.parseInternalVar()!;
        default:
          return x.parseInternalVar();
      }
    }
  }

  convertY() {
    double dy = modelDY;
    if (y.parseInternalVar() != null) {
      switch (fix) {
        case 1 || 2 || 3:
          return y.parseInternalVar();
        case 4 || 5 || 6:
          return y.parseInternalVar()! + dy / 2;
        case 7 || 8 || 9:
          return dy - y.parseInternalVar()!;
        default:
          return x.parseInternalVar();
      }
    }
  }
}

