import 'package:flutter/material.dart';

import '../base/data.dart';
import 'g1_info.dart';

class G1Data extends Data {
  int id;
  @override
  String? x;
  @override
  String? y;
  @override
  String? z;
  @override
  int? fix;
  G1Data({required this.id, this.x, this.y, this.z, this.fix});

  Widget getInfoButton(keyId) {
    return G1Info(id: id, key: Key("$keyId"),);
  }

  String getXXLData() {
    return "\nXL2P X=${convertX()} Y=${convertY()} Z=$z";
  }
}
