import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'edit_overlay/path_directory.dart';

//if true the edit overlay will be shown. used in overlay.dart
final showPathEditorProvider =
    StateNotifierProvider<ShowPathEditorNotifier, bool>(
        (ref) => ShowPathEditorNotifier());

//list of buttons for path objects (on left side in overlay)
class PathDirectoryNotifier extends StateNotifier<List<Path_Directory>> {
  PathDirectoryNotifier() : super([]);

  set(List<Path_Directory> data) {
    state = data;
  }

  add(Path_Directory data) {
    state = List.from(state)..add(data);
  }
}

final pathDirectoryProvider =
    StateNotifierProvider<PathDirectoryNotifier, List<Path_Directory>>(
        (ref) => PathDirectoryNotifier());

//lock path objects
class PathDirectoryLockNotifier extends StateNotifier<bool> {
  PathDirectoryLockNotifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final pathDirectoryLockProvider =
    StateNotifierProvider<PathDirectoryLockNotifier, bool>(
        (ref) => PathDirectoryLockNotifier());

//Path edit object id
class PathDirectoryIdNotifier extends StateNotifier<int> {
  PathDirectoryIdNotifier() : super(0);

  set(int data) {
    state = data;
  }
}

final pathDirectoryIdProvider =
    StateNotifierProvider<PathDirectoryIdNotifier, int>(
        (ref) => PathDirectoryIdNotifier());

//Path edit object id
class PathObjectIdNotifier extends StateNotifier<int> {
  PathObjectIdNotifier() : super(0);

  set(int data) {
    state = data;
  }
}

final pathObjectIdProvider = StateNotifierProvider<PathObjectIdNotifier, int>(
    (ref) => PathObjectIdNotifier());

//hide model
class ShowModelNotifier extends StateNotifier<bool> {
  ShowModelNotifier() : super(true);

  set(bool data) {
    state = data;
  }
}

final showModelProvider = StateNotifierProvider<ShowModelNotifier, bool>(
    (ref) => ShowModelNotifier());

//hide creator
class ShowCreatorNotifier extends StateNotifier<bool> {
  ShowCreatorNotifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final showCreatorProvider = StateNotifierProvider<ShowCreatorNotifier, bool>(
    (ref) => ShowCreatorNotifier());

//all code entitys in map
class PathEntityNotifier extends StateNotifier<Map<int, Map>> {
  PathEntityNotifier() : super({0: {}});

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
}

final pathEntityProvider =
    StateNotifierProvider<PathEntityNotifier, Map<int, Map>>(
        (ref) => PathEntityNotifier());
