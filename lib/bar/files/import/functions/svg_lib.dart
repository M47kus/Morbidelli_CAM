import 'dart:math';

import 'package:morbidelli_cam/bar/files/import/widgets/svg_settings.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/entity/g0/go_data.dart';
import 'package:morbidelli_cam/editor/entity/g1/g1_data.dart';

import '../../../../editor/entity/circle3p/cir3p_data.dart';
import '../../../../editor/entity/circle3p/cir3p_edit.dart';
import '../../../../provider/global.dart';

Map svGKeys = {
  "M": (x, y) {
    return SvgM(x: x, y: y);
  },
  "L": (x, y) {
    return SvgL(x: x, y: y);
  },
  "H": (x, y) {
    return SvgH(x: x, y: y);
  },
  "V": (x, y) {
    return SvgV(x: x, y: y);
  },
  "Z": (x, y) {
    return SvgZ(x: x, y: y);
  },
  "C": (
    sx,
    sy,
    x1,
    y1,
    x2,
    y2,
    x,
    y,
  ) {
    return SvgC(x: x, y: y, x1: x1, y1: y1, x2: x2, y2: y2, sx: sx, sy: sy);
  },
  "A": (rx, ry, a, l, s, x, y) {
    return SvgA(x: x, y: y, rx: rx, ry: ry, a: a, l: l, s: s);
  }
};
Map svGParams = {"M": 2, "L": 2, "H": 1, "V": 1, "Z": 0, "C": 6, "A": 7};

class SvgM {
  final double x;
  final double y;
  SvgM({required this.x, required this.y});

  void convert(ref, [convertType]) {
    int objId = ref.read(entityProvider.notifier).getNewObjId();
    ref.read(entityProvider.notifier).newObject(  
        G0Data(
          id: objId,
          x: x.toString(),
          y: y.toString(),
          z: importDepth.toString(),
          fix: 1,
        ));
  }
}

class SvgL {
  final double x;
  final double y;
  SvgL({required this.x, required this.y});

  void convert(ref, [convertType]) {
    int objId = ref.read(entityProvider.notifier).getNewObjId();
    ref.read(entityProvider.notifier).newObject(
        G1Data(
          id: objId,
          x: x.toString(),
          y: y.toString(),
          z: importDepth.toString(),
          fix: 1,
        ));
  }
}

class SvgH {
  final double x;
  final double y;
  SvgH({required this.x, required this.y});

  void convert(ref, [convertType]) {
    int objId = ref.read(entityProvider.notifier).getNewObjId();
    ref.read(entityProvider.notifier).newObject(
        G1Data(
          id: objId,
          x: x.toString(),
          y: y.toString(),
          z: importDepth.toString(),
          fix: 1,
        ));
  }
}

class SvgV {
  final double x;
  final double y;
  SvgV({required this.x, required this.y});

  void convert(ref, [convertType]) {
    int objId = ref.read(entityProvider.notifier).getNewObjId();
    ref.read(entityProvider.notifier).newObject(
        G1Data(
          id: objId,
          x: x.toString(),
          y: y.toString(),
          z: importDepth.toString(),
          fix: 1,
        ));
  }
}

class SvgZ {
  final double x;
  final double y;
  SvgZ({required this.x, required this.y});

  void convert(ref, [convertType]) {
    int objId = ref.read(entityProvider.notifier).getNewObjId();
    ref.read(entityProvider.notifier).newObject(
        G1Data(
          id: objId,
          x: x.toString(),
          y: y.toString(),
          z: importDepth.toString(),
          fix: 1,
        ));
  }
}

class SvgC {
  final double x;
  final double y;
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double sx;
  final double sy;
  SvgC(
      {required this.x,
      required this.y,
      required this.x1,
      required this.y1,
      required this.x2,
      required this.y2,
      required this.sx,
      required this.sy});

  void convert(ref, [convertType]) {
    int n = importDetail.round(); //must be follow this schema: (n-1)/3 = int
    Point A = Point(sx, sy);
    Point B = Point(x1, y1);
    Point C = Point(x2, y2);
    Point D = Point(x, y);

    List points = [];

    for (double t = 1; t >= 0; t -= 1 / n) {
      // double px = (1 - t) * ((1 - t) * ((1 - t) * A.x + t * B.x) + t * ((1 - t) * B.x + t * C.x)) + t * ((1 - t) * ((1 - t) * B.x + t * C.x) + t * ((1 - t) * D.x + t * D.x));
      // double py = (1 - t) * ((1 - t) * ((1 - t) * A.y + t * B.y) + t * ((1 - t) * B.y + t * C.y)) + t * ((1 - t) * ((1 - t) * B.y + t * C.y) + t * ((1 - t) * C.y + t * D.y));
      //print(t);
      Point E = Point(t*A.x+(1-t)*B.x, t*A.y+(1-t)*B.y);
      Point F = Point(t*B.x+(1-t)*C.x, t*B.y+(1-t)*C.y);
      Point G = Point(t*C.x+(1-t)*D.x, t*C.y+(1-t)*D.y);

      Point H = Point(t*E.x+(1-t)*F.x, t*E.y+(1-t)*F.y);
      Point I = Point(t*F.x+(1-t)*G.x, t*F.y+(1-t)*G.y);

      Point J = Point(t*H.x+(1-t)*I.x, t*H.y+(1-t)*I.y);

      //print("$A $B $C $D : $E $F $G : $H $I : $J");
      points.add(J);
    }

    for (int entityId = 1; entityId < points.length; entityId++) {
      if (entityId < points.length) {
        if (convertType == null || convertType == SVGConvertType.circles) {
          if (entityId.isOdd) {
            int objId = ref.read(entityProvider.notifier).getNewObjId();
            ref.read(entityProvider.notifier).newObject(
                Cir3PData(
                  id: objId,
                  x: points[entityId].x.toString(),
                  y: points[entityId].y.toString(),
                  z: importDepth.toString(),
                  xp: points[entityId + 1].x.toString(),
                  yp: points[entityId + 1].y.toString(),
                  zp: importDepth.toString(),
                  rotation: Cir3PAxisRotation.dynamic,
                  fix: 1,
                  fixp: 1,
                ));
          }
        } else {
          int objId = ref.read(entityProvider.notifier).getNewObjId();
          ref.read(entityProvider.notifier).newObject(
              G1Data(
                  id: objId,
                  x: points[entityId].x.toString(),
                  y: points[entityId].y.toString(),
                  z: importDepth.toString(),
                  fix: 1));
        }
      }
    }
  }
}

class SvgA {
  final double x;
  final double y;
  final double rx;
  final double ry;
  final double a;
  final double l;
  final double s;
  SvgA(
      {required this.x,
      required this.y,
      required this.rx,
      required this.ry,
      required this.a,
      required this.l,
      required this.s});
}
