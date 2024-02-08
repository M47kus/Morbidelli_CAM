import 'dart:math';
import 'dart:ui';

import 'package:ditredi/ditredi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/circle3p/cir3p_edit.dart';
import 'package:morbidelli_cam/edit_overlay/drill/drill_edit.dart';
import 'package:morbidelli_cam/edit_overlay/helper/3PCircle.dart';
import 'package:vector_math/vector_math_64.dart';

import '../AppBar/drill/drill_class.dart';
import '../edit_overlay/g0/go_edit.dart';
import '../edit_overlay/g1/g1_edit.dart';
import '../provider/path_privider_lib.dart';
import '../provider/provider_lib.dart';

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

  //convert all entitys in state to Line3D
  Group3D toVisibleLines(ref, LineAxis axis) {
    List<Line3D> modelLines = []; //final Line3D list
    int? lineStart; //start id of entity to ignore all unrelevant entitys
    List spline = [];

    for (int dirId in state.keys) {
      if (ref.watch(shownSplinesProvider)[dirId] != null) {
        if (ref.read(shownSplinesProvider)[dirId]) {
          for (var entity in state[dirId]!.values) {
            if (entity is G0Data) {
              (modelLines, spline) = _addModelLine(modelLines, spline, axis);

              lineStart = entity.id;
              spline.add(entity);
            } else if (entity is G1Data && lineStart != null) {
              if (entity.id > lineStart) {
                spline.add(entity);
              }
            } else if (entity is Cir3PData && lineStart != null) {
              if (entity.id > lineStart) {
                spline.add(entity);
              }
            }
          }

          (modelLines, spline) = _addModelLine(modelLines, spline, axis);
        }
      }
    }
    return Group3D(modelLines);
  }

  //pull spline data to modellines and empty spline
  (List<Line3D>, List) _addModelLine(modelLines, spline, LineAxis axis) {
    if (spline.isNotEmpty) {
      for (int index = 0; index < spline.length; index++) {
        if (index < spline.length - 1) {
          modelLines.add(Line3D(
              Vector3(spline[index].modelX(axis), spline[index].modelZ(axis),
                  spline[index].modelY(axis)),
              Vector3(
                  spline[index + 1].modelX(axis),
                  spline[index + 1].modelZ(axis),
                  spline[index + 1].modelY(axis)),
              width: 1.5,
              color: const Color.fromARGB(255, 58, 211, 21)));
        }
      }
      spline.clear();
    }
    return (modelLines, spline);
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
              relativePos = Vector3(entity.modelX(lineAxis),
                  entity.modelZ(lineAxis), entity.modelY(lineAxis));
            } else if (entity is G1Data) {
              Vector3 movePos = Vector3(entity.modelX(lineAxis),
                  entity.modelZ(lineAxis), entity.modelY(lineAxis));
              lines.add(Line3D(relativePos, movePos,
                  width: 1.5, color: const Color.fromARGB(255, 58, 211, 21)));
              relativePos = movePos;
            } else if (entity is Cir3PData) {
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

              double aStart = aA < aC ? aA : aC;
              double aEnd = aA > aC ? aA : aC;

              if (entity.rotation == Cir3PAxisRotation.dynamic) {
                print("dynamic");
                aStart = [aA, aB, aC].reduce(min);
                aEnd = [aA, aB, aC].reduce(max);
              }

              double t = 25;

              if (entity.rotation == Cir3PAxisRotation.left) {
                for (double i = 0; i >= -t; i--) {
                  double a =
                      ((pi * 2 - (aEnd - aStart)).abs() / t * i) + aStart;

                  Vector3 movePos = Vector3(center.x + radius * cos(a),
                      entity.modelZ(lineAxis), center.y + radius * sin(a));

                  lines.add(Line3D(relativePos, movePos,
                      width: 1.5,
                      color: const Color.fromARGB(255, 58, 211, 21)));
                  relativePos = movePos;
                }
              } else {
                for (double i = 0; i <= t; i++) {
                  double a = ((aEnd - aStart).abs() / t * i) + aStart;

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
