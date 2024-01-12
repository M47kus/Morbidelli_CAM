import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:yaml/yaml.dart";
import 'AppBar/drill/drill_class.dart';
import 'edit_overlay/path_directory.dart';

//Presented Model in Editor
class ModelContentNotifier extends StateNotifier<String> {
  ModelContentNotifier() : super("");

  set(String file) {
    state = file;
  }

  void readObject() {
    set(File('assets/default.obj').readAsStringSync());
  }
}

final modelContentProvider =
    StateNotifierProvider<ModelContentNotifier, String>(
        (ref) => ModelContentNotifier());

//change view for Model
class ModelViewNotifier extends StateNotifier<String> {
  ModelViewNotifier() : super("Top");

  set(String file) {
    state = file;
  }

  void set_Top() {
    set("Top");
  }

  void set_Front() {
    set("Front");
  }

  void set_Side() {
    set("Side");
  }
}

final modelViewProvider = StateNotifierProvider<ModelViewNotifier, String>(
    (ref) => ModelViewNotifier());

//change Appearance for Model
class ModelApearanceNotifier extends StateNotifier<String> {
  ModelApearanceNotifier() : super("Solid");

  set(String file) {
    state = file;
  }

  void set_Solid() {
    set("Solid");
  }

  void set_Wireframe() {
    set("Wireframe");
  }

  void set_Points() {
    set("Points");
  }
}

final modelApearanceProvider =
    StateNotifierProvider<ModelApearanceNotifier, String>(
        (ref) => ModelApearanceNotifier());

//Drill Notifier which updates the Drill classes
class Drill_class_Notifier extends StateNotifier<List> {
  Drill_class_Notifier() : super([]);

  set(List list) {
    state = list;
  }

  //load from file at startup
  Future<void> init_drills() async {
    final data = await rootBundle.loadString('assets/drills.yaml');
    final mapData = loadYaml(data);

    set([]);
    //print(mapData);
    mapData.forEach((key, value) {
      List drillButtonClass = state;
      drillButtonClass.add(Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],
      ));
      set(drillButtonClass);
    });
  }

  //update all Drill classes
  void refresh_drills(mapData) {
    set([]);
    //print(mapData);
    mapData.forEach((key, value) {
      List drillButtonClass = state;
      drillButtonClass.add(Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],
      ));
      set(drillButtonClass);
    });
  }
}

final Drill_class_Provider = StateNotifierProvider<Drill_class_Notifier, List>(
    (ref) => Drill_class_Notifier());

//Path Editor hide
class Show_Path_Editor_Notifier extends StateNotifier<bool> {
  Show_Path_Editor_Notifier() : super(false);

  set(bool data) {
    state = data;
  }
}

final show_path_editor_provider =
    StateNotifierProvider<Show_Path_Editor_Notifier, bool>(
        (ref) => Show_Path_Editor_Notifier());

//Path object
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


