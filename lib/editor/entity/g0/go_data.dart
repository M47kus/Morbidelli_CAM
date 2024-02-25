import 'package:flutter/material.dart';

import '../base/data.dart';
import 'go_info.dart';

class G0Data extends Data {
  int id;
  int? correct;
  @override
  double? x;
  @override
  double? y;
  @override
  double? z;
  @override
  int? fix;
  G0Data({required this.id, this.x, this.y, this.z, this.fix, this.correct});

  Widget getInfoButton() {
    return G0Info(id: id);
  }

  String getXXLData(drill) {
    return "\nXG0 X=${convertX()} Y=${convertY()} Z=$z T=${drill.id}";
  }
}
