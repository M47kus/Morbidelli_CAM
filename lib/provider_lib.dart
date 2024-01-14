import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:yaml/yaml.dart";
import 'AppBar/drill/drill_class.dart';

//Presented Model in Editor
class ModelContentNotifier extends StateNotifier<String> {
  ModelContentNotifier() : super("");

  set(String file) {
    state = file;
  }

  void readObject(path) {
    set(File(path).readAsStringSync());
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

  void setTop() {
    set("Top");
  }

  void setFront() {
    set("Front");
  }

  void setSide() {
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

  void setSolid() {
    set("Solid");
  }

  void setWireframe() {
    set("Wireframe");
  }

  void setPoints() {
    set("Points");
  }
}

final modelApearanceProvider =
    StateNotifierProvider<ModelApearanceNotifier, String>(
        (ref) => ModelApearanceNotifier());

//Drill Notifier which updates the Drill classes
class DrillClassNotifier extends StateNotifier<List> {
  DrillClassNotifier() : super([]);

  set(List list) {
    state = list;
  }

  //load from file at startup
  Future<void> initDrills() async {
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
  void refreshDrills(mapData) {
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

final drillclassprovider = StateNotifierProvider<DrillClassNotifier, List>(
    (ref) => DrillClassNotifier());

//Path Editor hide
class ShowPathEditorNotifier extends StateNotifier<bool> {
  ShowPathEditorNotifier() : super(false);

  set(bool data) {
    state = data;
  }
}
