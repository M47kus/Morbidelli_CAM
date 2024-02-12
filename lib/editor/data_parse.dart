import 'dart:math';
import 'dart:ui';

import 'package:ditredi/ditredi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math_64.dart';
import '../bar/drill/drill_class.dart';
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

  //todo: later in export format to Data classes with drill info

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
              relativePos = Vector3(entity.modelX(lineAxis),
                  entity.modelZ(lineAxis), entity.modelY(lineAxis));
            } else if (entity is G1Data) {
              Vector3 movePos = Vector3(entity.modelX(lineAxis),
                  entity.modelZ(lineAxis), entity.modelY(lineAxis));
              lines.add(Line3D(relativePos, movePos,
                  width: 1.5, color: const Color.fromARGB(255, 58, 211, 21)));
              relativePos = movePos;
            } else if (entity is Cir3PData) {
              //todo
              Vector2 center;
              double radius;
              (center, radius) = findCircle(
                  relativePos.x,
                  relativePos.z,
                  entity.modelX(lineAxis),
                  entity.modelY(lineAxis),
                  entity.modelXP(lineAxis),
                  entity.modelYP(lineAxis));
              Vector2 vA =
                  Vector2(relativePos.x - center.x, relativePos.z - center.y);
              Vector2 vB = Vector2(entity.modelX(lineAxis)! - center.x,
                  entity.modelY(lineAxis)! - center.y);
              Vector2 vC = Vector2(entity.modelXP(lineAxis)! - center.x,
                  entity.modelYP(lineAxis)! - center.y);

              double aA = atan2(vA.y, vA.x);
              double aB = atan2(vB.y, vB.x);
              double aC = atan2(vC.y, vC.x);

              print("$aA $aB $aC");

              double aStart = aA;
              double aEnd = aC;

              if (aA < 0) aStart = aA + pi * 2;
              if (aC < 0) aEnd = aC + pi * 2;

              // if (entity.rotation == Cir3PAxisRotation.dynamic) {
              //   aStart = [aA, aB, aC].reduce(min);
              //   aEnd = [aA, aB, aC].reduce(max);
              // }

              double t = 25;

              if (entity.rotation == Cir3PAxisRotation.left) {
                for (double i = 0; i >= -t; i--) {
                  double a =
                      ((pi * 2 - (aStart - aEnd)).abs() / t * i) + aStart;

                  Vector3 movePos = Vector3(center.x + radius * cos(a),
                      entity.modelZ(lineAxis), center.y + radius * sin(a));

                  lines.add(Line3D(relativePos, movePos,
                      width: 1.5,
                      color: const Color.fromARGB(255, 58, 211, 21)));
                  relativePos = movePos;
                }
              } else {
                for (double i = t; i >= 0; i--) {
                  double a = ((aStart - aEnd).abs() / t * i) + aStart;

                  Vector3 movePos = Vector3(center.x + radius * cos(a),
                      entity.modelZ(lineAxis), center.y + radius * sin(a));

                  lines.add(Line3D(relativePos, movePos,
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
