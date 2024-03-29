import 'package:flutter/material.dart';

import '../base/data.dart';
import 'g1_info.dart';

class G1Data extends Data {
  int id;
  @override
  double? x;
  @override
  double? y;
  @override
  double? z;
  @override
  int? fix;
  G1Data({required this.id, this.x, this.y, this.z, this.fix});

  Widget getInfoButton() {
    return G1Info(id: id);
  }

  String getXXLData() {
    return "\nXL2P X=${convertX()} Y=${convertY()} Z=$z";
  }
}
