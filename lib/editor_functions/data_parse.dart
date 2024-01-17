import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:ditredi/ditredi.dart';

import '../edit_overlay/g0/go_edit.dart';
import '../edit_overlay/g1/g1_edit.dart';
import '../provider/path_privider_lib.dart';


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

  void toGFormat(ref) {
    int? lineStart;
    List spline = [];

    //Directorys
    for (int dirId in ref.read(entityProvider).keys) {
      //All Entitys from top to bottom
      for (var entity in ref.read(entityProvider)[dirId].values) {


        if (entity is G0Data) {
        } else if (entity is G1Data && lineStart != null) {
          if (entity.id > lineStart) {
            spline.add(entity);
          }
        }
      }
    }
  }

  Group3D toLines(ref) {
    List<Line3D> modelLines = [];
    int? lineStart;
    List spline = [];

    for (int dirId in state.keys) {
      if (ref.watch(shownSplinesProvider)[dirId] != null) {
        if (ref.read(shownSplinesProvider)[dirId]) {
          for (var entity in state[dirId]!.values) {
            if (entity is G0Data) {
              if (spline.isNotEmpty) {
                for (int index = 0; index < spline.length; index++) {
                  if (index < spline.length - 1) {
                    modelLines.add(Line3D(
                        Vector3(spline[index].modelX(), spline[index].modelZ(),
                            spline[index].modelY()),
                        Vector3(
                            spline[index + 1].modelX(),
                            spline[index + 1].modelZ(),
                            spline[index + 1].modelY()),
                        width: 1));
                  }
                }
                spline.clear();
              }

              lineStart = entity.id;
              spline.add(entity);
            } else if (entity is G1Data && lineStart != null) {
              if (entity.id > lineStart) {
                spline.add(entity);
              }
            }
          }

          if (spline.isNotEmpty) {
            for (int index = 0; index < spline.length; index++) {
              if (index < spline.length - 1) {
                modelLines.add(Line3D(
                    Vector3(spline[index].modelX(), spline[index].modelZ(),
                        spline[index].modelY()),
                    Vector3(spline[index + 1].modelX(),
                        spline[index + 1].modelZ(), spline[index + 1].modelY()),
                    width: 1));
              }
            }
            spline.clear();
          }
        }
      }
    }
    return Group3D(modelLines);
  }

}

final entityProvider = StateNotifierProvider<EntityNotifier, Map<int, Map>>(
        (ref) => EntityNotifier());

