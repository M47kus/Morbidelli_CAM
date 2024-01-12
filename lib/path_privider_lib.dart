import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'edit_overlay/path_directory.dart';

//if true the edit overlay will be shown. used in overlay.dart
final show_path_editor_provider =
StateNotifierProvider<Show_Path_Editor_Notifier, bool>(
        (ref) => Show_Path_Editor_Notifier());

//list of buttons for path objects (on left side in overlay)
class Path_Directory_Notifier extends StateNotifier<List<Path_Directory>> {
  Path_Directory_Notifier() : super([]);

  set(List<Path_Directory> data) {
    state = data;
  }

  add(Path_Directory data) {
    state = List.from(state)..add(data);
  }
}

final path_directory_provider =
StateNotifierProvider<Path_Directory_Notifier, List<Path_Directory>>(
        (ref) => Path_Directory_Notifier());

//lock path objects
class Path_Directory_Lock_Notifier extends StateNotifier<bool> {
  Path_Directory_Lock_Notifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final path_directory_lock_provider =
StateNotifierProvider<Path_Directory_Lock_Notifier, bool>(
        (ref) => Path_Directory_Lock_Notifier());

//Path edit object id
class Path_Directory_Id_Notifier extends StateNotifier<int> {
  Path_Directory_Id_Notifier() : super(0);

  set(int data) {
    state = data;
  }
}

final path_directory_id_provider = StateNotifierProvider<Path_Directory_Id_Notifier, int>(
        (ref) => Path_Directory_Id_Notifier());


//Path edit object id
class Path_Object_Id_Notifier extends StateNotifier<int> {
  Path_Object_Id_Notifier() : super(0);

  set(int data) {
    state = data;
  }
}

final path_object_id_provider = StateNotifierProvider<Path_Object_Id_Notifier, int>(
        (ref) => Path_Object_Id_Notifier());


//hide model
class Show_Model_Notifier extends StateNotifier<bool> {
  Show_Model_Notifier() : super(true);

  set(bool data) {
    state = data;
  }
}

final show_model_provider = StateNotifierProvider<Show_Model_Notifier, bool>(
        (ref) => Show_Model_Notifier());

//hide creator
class Show_Creator_Notifier extends StateNotifier<bool> {
  Show_Creator_Notifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final show_creator_provider = StateNotifierProvider<Show_Creator_Notifier, bool>(
        (ref) => Show_Creator_Notifier());


//all code entitys in map
class Path_Entity_Notifier extends StateNotifier<Map<int, Map>> {
  Path_Entity_Notifier() : super({0:{}});

  set(Map<int, Map> data) {
    state = data;
  }

  new_directory(int id) {
    Map<int, Map> old = Map.from(state);
    old[id] = {};
    state = old;

  }

  get_new_obj_id(int dir_id) {
    List keys = Map.from(state)[dir_id]!.keys.toList();
    int id = 1;
    if(keys.length > 0) {id = keys.reduce((curr, next) => curr > next? curr: next) + 1;}
    return id;
  }

  new_object(int dir_id, int obj_id, data) {
    Map<int, Map> old = Map.from(state);
    old[dir_id]![obj_id] = data;
    state = old;
  }

  remove_object(int dir_id, int obj_id) {
    Map<int, Map> old = Map.from(state);
    old[dir_id]!.remove(obj_id);
    state = old;
  }

}

final path_entity_provider =
StateNotifierProvider<Path_Entity_Notifier, Map<int, Map>>(
        (ref) => Path_Entity_Notifier());
