import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:yaml/yaml.dart";
import '../AppBar/drill/drill_class.dart';

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
    set("Free");
    set("Top");
  }

  void setFront() {
    set("Free");
    set("Front");
  }

  void setSideRight() {
    set("Free");
    set("SideRight");
  }

  void setSideLeft() {
    set("Free");
    set("SideLeft");
  }

  void setFree() {
    set("Free");
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
class DrillClassNotifier extends StateNotifier<Map<String, Drill>> {
  DrillClassNotifier() : super({});

  set(Map<String, Drill> list) {
    state = list;
  }

  //load from file at startup
  Future<void> initDrills() async {
    final data = await rootBundle.loadString('assets/drills.yaml');
    final mapData = loadYaml(data);
    ;
    //print(mapData);
    mapData.forEach((key, value) {
      Map<String, Drill> drillButtonClass = state;
      drillButtonClass[key.toString()] = Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],
      );
      state = drillButtonClass;
    });
  }

  //update all Drill classes
  void refreshDrills(mapData) {
    //print(mapData);
    mapData.forEach((key, value) {
      Map<String, Drill> drillButtonClass = state;
      drillButtonClass[key] = Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],
      );
      state = drillButtonClass;
    });
  }
}

final drillclassprovider =
    StateNotifierProvider<DrillClassNotifier, Map<String, Drill>>(
        (ref) => DrillClassNotifier());

