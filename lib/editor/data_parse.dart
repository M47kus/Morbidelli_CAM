import 'dart:math';
import 'dart:ui';

import 'package:ditredi/ditredi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/data.dart';
import 'package:vector_math/vector_math_64.dart';
import '../bar/drill/drill_class.dart';
import '../bar/files/settings/load_settings.dart';
import '../helper/math/circle_3p.dart';
import '../provider/path_privider_lib.dart';
import '../provider/provider_lib.dart';
import 'entity/circle3p/cir3p_data.dart';
import 'entity/circle3p/cir3p_edit.dart';
import 'entity/drill/drill_data.dart';
import 'entity/g0/go_data.dart';
import 'entity/g1/g1_data.dart';

enum LineAxis { x, xr, y, z, f }

//all code entitys in map
class EntityNotifier extends StateNotifier<Map<int, Map>> {
  EntityNotifier() : super({0: {}});

  set(Map<int, Map> data) {
    state = data;
  }

  newDirectory(int id) {
    Map<int, Map> old = Map.from(state);
    old[id] = {};
    state = old;
  }

  getNewObjId(int dirId) {
    List keys = Map.from(state)[dirId]!.keys.toList();
    int id = 1;
    if (keys.isNotEmpty) {
      id = keys.reduce((curr, next) => curr > next ? curr : next) + 1;
    }
    return id;
  }

  newObject(int dirId, int objId, data) {
    Map<int, Map> old = Map.from(state);
    old[dirId]![objId] = data;
    state = old;
  }

  removeObject(int dirId, int objId) {
    Map<int, Map> old = Map.from(state);
    old[dirId]!.remove(objId);
    state = old;
  }

  removeDirectory(int dirId) {
    Map<int, Map> old = Map.from(state);
    old.remove(dirId);
    state = old;
  }

  Group3D parseLine3D(ref, LineAxis lineAxis) {
    List<Line3D> lines = [];

    for (int dirId in state.keys) {
      if (ref.watch(shownSplinesProvider)[dirId] != null) {
        if (ref.read(shownSplinesProvider)[dirId]) {
          Vector3 relativePos = Vector3(0, 0, 0);
          Drill selectedDrill = ref
              .read(drillclassprovider)
              .values
              .toList()[0]; //select first drill in list

          for (var entity in state[dirId]!.values) {
            if (entity is DrillData) {
              selectedDrill = entity.drill!;
            } else if (entity is G0Data) {
              relativePos =
                  Vector3(entity.convertX(), entity.z!, entity.convertY());
            } else if (entity is G1Data) {
              Vector3 movePos =
                  Vector3(entity.convertX(), entity.z!, entity.convertY());
              lines.add(Line3D(
                  relativePos.model(lineAxis), movePos.model(lineAxis),
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
              Vector2 vC = Vector2(entity.convertXP()! - center.x,
                  entity.convertYP()! - center.y);

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
                    cirz -= (startPoint.y - entity.z!) / ((t + 1) / 2);
                  } else {
                    cirz -= (entity.z! - entity.zp!) / ((t + 1) / 2);
                  }

                  Vector3 movePos = Vector3(center.x + radius * cos(a), cirz,
                      center.y + radius * sin(a));

                  reverseLines.add(Line3D(
                      relativePos.model(lineAxis), movePos.model(lineAxis),
                      width: 1.5,
                      color: const Color.fromARGB(255, 58, 211, 21)));
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
                    cirz -= (startPoint.y - entity.z!) / ((t + 1) / 2);
                  } else {
                    cirz -= (entity.z! - entity.zp!) / ((t + 1) / 2);
                  }

                  Vector3 movePos = Vector3(center.x + radius * cos(a), cirz,
                      center.y + radius * sin(a));

                  lines.add(Line3D(
                      relativePos.model(lineAxis), movePos.model(lineAxis),
                      width: 1.5,
                      color: const Color.fromARGB(255, 58, 211, 21)));
                  relativePos = movePos;
                }
              }
            }
          }
        }
      }
    }
    return Group3D(lines);
  }
}

final entityProvider = StateNotifierProvider<EntityNotifier, Map<int, Map>>(
    (ref) => EntityNotifier());
