import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/edit_overlay/create_path.dart';
import "package:yaml/yaml.dart";
import 'AppBar/drill/drill_class.dart';

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
class Path_Directory_Notifier extends StateNotifier<List> {
  Path_Directory_Notifier() : super([]);

  set(List data) {
    state = data;
  }
  add(Path_Object data) {
    state = List.from(state)..add(data);
  }
}

final path_directory_provider =
StateNotifierProvider<Path_Directory_Notifier, List>(
        (ref) => Path_Directory_Notifier());
