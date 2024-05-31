import 'dart:math';
import 'dart:ui';

import 'package:ditredi/ditredi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/helper/extensions/parse_internal_var.dart';
import 'package:morbidelli_cam/helper/extensions/view_lines.dart';
import 'package:vector_math/vector_math_64.dart';
import '../helper/math/circle_3p.dart';
import '../provider/global.dart';
import 'entity/circle3p/cir3p_data.dart';
import 'entity/circle3p/cir3p_edit.dart';
import 'entity/drill/drill_data.dart';
import 'entity/g0/go_data.dart';
import 'entity/g1/g1_data.dart';
import 'entity/initial/init_data.dart';

enum LineAxis { x, xr, y, z, f }

//all code entitys in map
class EntityNotifier extends StateNotifier<List> {
  EntityNotifier() : super([InitData(
        id: 1,
        x: "DX",
        y: "DY",
        z: "DZ",
        bx: "0",
        by: "0",
        bz: "0",
      )]);

  getEntity(int id) {
    if (state.any((element) => element.id == id)) {
      return state.firstWhere((entity) => entity.id == id);
    } else {
      return null;
    }
  }

  getIndex(int id) {
    if (state.any((element) => element.id == id)) {
      return state.indexWhere((entity) => entity.id == id);
    } else {
      return null;
    }
  }

  getNewObjId() {
    List keys = [];
    for (var element in state) {
      keys.add(element.id);
    }
    int id = 1;
    if (keys.isNotEmpty) {
      id = keys.reduce((curr, next) => curr > next ? curr : next) + 1;
    }
    return id;
  }

  newObject(data) {
    List old = List.from(state);
    old.add(data);
    state = old;
  }

  insertObject(id, data) {
    List old = List.from(state);
    old.insert(id, data);
    state = old;
  }

  removeObject(int objId) {
    List old = List.from(state);
    if (getEntity(objId) != null) {
      old.remove(getEntity(objId));
    }

    state = old;
  }

  removeIndex(int objId) {
    List old = List.from(state);
    if (old[objId] != null) {
      old.removeAt(objId);
    }

    state = old;
  }

  update(int objId, data) {
    List old = List.from(state);
    old[getIndex(objId)] = data;
    state = old;
  }

  Group3D parseLine3D(ref, LineAxis lineAxis) {
    List<Line3D> lines = [];

    Vector3 relativePos = Vector3(0, 0, 0);
    // Drill selectedDrill = ref
    //     .read(drillclassprovider)
    //     .values
    //     .toList()[0];

    List keyList = [];
    for (var element in state) {
      keyList.add(element.id);
    }
    print(keyList);
    for (int keyId in keyList) {
      var entity = getEntity(keyId);

      if (entity is InitData) {
        modelDX = entity.x.parseInternalVar()!;
        modelDY = entity.y.parseInternalVar()!;
        modelDZ = entity.z.parseInternalVar()!;
      } else if (entity is DrillData) {
        //selectedDrill = entity.drill!;
      } else if (entity is G0Data) {
        relativePos = Vector3(
            entity.convertX(), entity.z.parseInternalVar()!, entity.convertY());
      } else if (entity is G1Data) {
        Vector3 movePos = Vector3(
            entity.convertX(), entity.z.parseInternalVar()!, entity.convertY());
        lines.add(Line3D(relativePos.model(lineAxis), movePos.model(lineAxis),
            width: 1.5, color: const Color.fromARGB(255, 58, 211, 21)));
        relativePos = movePos;
      } else if (entity is Cir3PData) {
        Vector2 center;
        double radius;
        (center, radius) = findCircle(
            relativePos.x,
            relativePos.z,
            entity.convertX(),
            entity.convertY(),
            entity.convertXP(),
            entity.convertYP());
        Vector3 startPoint = relativePos;
        Vector2 vA =
            Vector2(relativePos.x - center.x, relativePos.z - center.y);
        Vector2 vB = Vector2(
            entity.convertX()! - center.x, entity.convertY()! - center.y);
        Vector2 vC = Vector2(
            entity.convertXP()! - center.x, entity.convertYP()! - center.y);

        int t = 6; //circle detail

        int lSegment = 5;
        Vector2 vAC = Vector2(entity.convertXP() - relativePos.x,
            entity.convertYP() - relativePos.z);
        double lAC = sqrt(pow(vAC.x, 2) + pow(vAC.y, 2));
        if (lAC / lSegment <= int.parse(circleTMin.text)) {
          t = int.parse(circleTMin.text);
        } else {
          t = (lAC / lSegment).round();
        }

        double aA = atan2(vA.y, vA.x);
        double aB = atan2(vB.y, vB.x);
        double aC = atan2(vC.y, vC.x);

        if (aC < 0) aC += pi * 2;
        if (aA < 0) aA += pi * 2;
        if (aB < 0) aB += pi * 2;

        // print("o $aA $aB $aC"):

        Cir3PAxisRotation dynamicRotation = Cir3PAxisRotation.dynamic;

        if (entity.rotation == Cir3PAxisRotation.dynamic) {
          double aStartr = aA;
          double aEndr = aC;

          if (aStartr > aEndr) aStartr -= pi * 2;

          if (aB > aStartr && aB < aEndr ||
              aB - pi * 2 > aStartr && aB - pi * 2 < aEndr) {
            dynamicRotation = Cir3PAxisRotation.right;
          }

          double aStartl = aC;
          double aEndl = aA;

          if (aStartl > aEndl) aStartl -= pi * 2;

          if (aB > aStartl && aB < aEndl ||
              aB - pi * 2 > aStartl && aB - pi * 2 < aEndl) {
            dynamicRotation = Cir3PAxisRotation.left;
          }
        }

        if (entity.rotation == Cir3PAxisRotation.left ||
            dynamicRotation == Cir3PAxisRotation.left) {
          List reverseLines = [];
          double aStart = aC;
          double aEnd = aA;

          if (aStart > aEnd) aStart -= pi * 2;

          double cirz = startPoint.y;

          for (double i = 1; i >= 0; i -= 1 / t) {
            double a = ((1 - i) * aStart + i * aEnd);

            if (i >= 0.5 - (1 / t) / 2) {
              cirz -=
                  (startPoint.y - entity.z.parseInternalVar()!) / ((t + 1) / 2);
            } else {
              cirz -= (entity.z.parseInternalVar()! -
                      entity.zp.parseInternalVar()!) /
                  ((t + 1) / 2);
            }

            Vector3 movePos = Vector3(
                center.x + radius * cos(a), cirz, center.y + radius * sin(a));

            reverseLines.add(Line3D(
                relativePos.model(lineAxis), movePos.model(lineAxis),
                width: 1.5, color: const Color.fromARGB(255, 58, 211, 21)));
            relativePos = movePos;
          }
          for (var line in reverseLines.reversed) {
            lines.add(line);
          }
        } else if (entity.rotation == Cir3PAxisRotation.right ||
            dynamicRotation == Cir3PAxisRotation.right) {
          double aStart = aA;
          double aEnd = aC;

          if (aStart > aEnd) aStart -= pi * 2;

          double cirz = startPoint.y;

          for (double i = 0; i <= 1; i += 1 / t) {
            double a = ((1 - i) * aStart + i * aEnd);

            if (i <= 0.5 + (1 / t) / 2) {
              cirz -=
                  (startPoint.y - entity.z.parseInternalVar()!) / ((t + 1) / 2);
            } else {
              cirz -= (entity.z.parseInternalVar()! -
                      entity.zp.parseInternalVar()!) /
                  ((t + 1) / 2);
            }

            Vector3 movePos = Vector3(
                center.x + radius * cos(a), cirz, center.y + radius * sin(a));

            lines.add(Line3D(
                relativePos.model(lineAxis), movePos.model(lineAxis),
                width: 1.5, color: const Color.fromARGB(255, 58, 211, 21)));
            relativePos = movePos;
          }
        }
      }
    }

    return Group3D(lines);
  }
}

final entityProvider =
    StateNotifierProvider<EntityNotifier, List>((ref) => EntityNotifier());
