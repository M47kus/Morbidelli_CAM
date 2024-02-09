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

enum ModelView{
  top, front, sideLeft, sideRight, free
}

//change view for Model
class ModelViewNotifier extends StateNotifier<ModelView> {
  ModelViewNotifier() : super(ModelView.top);

  set(ModelView file) {
    state = file;
  }

  void setTop() {
    state = ModelView.free;
    state = ModelView.top;
  }

  void setFront() {
    state = ModelView.free;
    state = ModelView.front;
  }

  void setSideRight() {
    state = ModelView.free;
    state = ModelView.sideRight;
  }

  void setSideLeft() {
    state = ModelView.free;
    state = ModelView.sideLeft;
  }

  void setFree() {
    state = ModelView.free;
  }
}

enum ModelApearance{
  solid, wire, points
}

final modelViewProvider = StateNotifierProvider<ModelViewNotifier, ModelView>(
    (ref) => ModelViewNotifier());

//change Appearance for Model
class ModelApearanceNotifier extends StateNotifier<ModelApearance> {
  ModelApearanceNotifier() : super(ModelApearance.solid);

  set(ModelApearance file) {
    state = file;
  }

  void setSolid() {
    state = ModelApearance.solid;
  }

  void setWireframe() {
    state = ModelApearance.wire;
  }

  void setPoints() {
    state = ModelApearance.points;
  }
}

final modelApearanceProvider =
    StateNotifierProvider<ModelApearanceNotifier, ModelApearance>(
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
    //print(mapData);
    mapData.forEach((key, value) {
      Map<String, Drill> drillButtonClass = state;
      drillButtonClass[key.toString()] = Drill(
        name: key,
        id: value["id"],
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
        id: value["id"],
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

