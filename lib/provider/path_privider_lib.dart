import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/overlay/path_directory.dart';

//if true the edit overlay will be shown. used in overlay.dart
//Path Editor hide
class ShowPathEditorNotifier extends StateNotifier<bool> {
  ShowPathEditorNotifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final showPathEditorProvider =
    StateNotifierProvider<ShowPathEditorNotifier, bool>(
        (ref) => ShowPathEditorNotifier());

//list of buttons for path objects (on left side in overlay)
class PathDirectoryNotifier extends StateNotifier<Map<int, PathDirectory>> {
  PathDirectoryNotifier() : super({});

  set(Map<int, PathDirectory> data) {
    state = data;
  }

  getNewId() {
    List keys = Map.from(state).keys.toList();
    int id = 1;
    if (keys.isNotEmpty) {
      id = keys.reduce((curr, next) => curr > next ? curr : next) + 1;
    }
    return id;
  }

  add(int dirId, PathDirectory data) {
    Map<int, PathDirectory> old = Map.from(state);
    old[dirId] = data;
    state = old;
  }

  remove(int dirId) {
    Map<int, PathDirectory> old = Map.from(state);
    old.remove(dirId);
    state = old;
  }
}

final pathDirectoryProvider =
    StateNotifierProvider<PathDirectoryNotifier, Map<int, PathDirectory>>(
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

class ShownSplinesNotifier extends StateNotifier<Map<int, bool>> {
  ShownSplinesNotifier() : super({});

  set(Map<int, bool> data) {
    state = data;
  }

  update(int dirId, data) {
    Map<int, bool> old = Map.from(state);
    old[dirId] = data;
    state = old;
  }
}

final shownSplinesProvider =
    StateNotifierProvider<ShownSplinesNotifier, Map<int, bool>>(
        (ref) => ShownSplinesNotifier());
