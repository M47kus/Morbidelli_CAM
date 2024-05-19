import 'package:flutter_riverpod/flutter_riverpod.dart';

//if true the edit overlay will be shown. used in overlay.dart
//Path Editor hide
class CNCModeNotifier extends StateNotifier<bool> {
  CNCModeNotifier() : super(true);

  set(bool data) {
    state = data;
  }
}

final cncModeProvider =
    StateNotifierProvider<CNCModeNotifier, bool>(
        (ref) => CNCModeNotifier());

//Path edit object id
class PathObjectIdNotifier extends StateNotifier<int> {
  PathObjectIdNotifier() : super(0);

  set(int data) {
    state = data;
  }
}

final pathObjectIdProvider = StateNotifierProvider<PathObjectIdNotifier, int>(
    (ref) => PathObjectIdNotifier());

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
