import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import "package:yaml/yaml.dart";
import 'AppBar/drill/load_drill.dart';


class ModelContentNotifier extends StateNotifier<String> {
  ModelContentNotifier() : super("");

  set(String file) {
    state = file;
  }
  void readObject(){
    set(File('assets/default.obj').readAsStringSync());
  }
}

final modelContentProvider =
StateNotifierProvider<ModelContentNotifier, String>(
        (ref) => ModelContentNotifier());

class ModelViewNotifier extends StateNotifier<String> {
  ModelViewNotifier() : super("Top");

  set(String file) {
    state = file;
  }

  void set_Top(){
    set("Top");
  }

  void set_Front(){
    set("Front");
  }

  void set_Side(){
    set("Side");
  }
}

final modelViewProvider =
StateNotifierProvider<ModelViewNotifier, String>(
        (ref) => ModelViewNotifier());

class ModelApearanceNotifier extends StateNotifier<String> {
  ModelApearanceNotifier() : super("Solid");

  set(String file) {
    state = file;
  }

  void set_Solid(){
    set("Solid");
  }

  void set_Wireframe(){
    set("Wireframe");
  }

  void set_Points(){
    set("Points");
  }
}

final modelApearanceProvider =
StateNotifierProvider<ModelApearanceNotifier, String>(
        (ref) => ModelApearanceNotifier());

class Drill_class_Notifier extends StateNotifier<List> {
  Drill_class_Notifier() : super([]);

  set(List list) {
    state = list;
  }

  Future<void> init_drills() async {
    final data = await rootBundle.loadString('assets/drills.yaml');
    final mapData = loadYaml(data);

    set([]);
    //print(mapData);
    mapData.forEach((key, value) {
      List drill_button_class = state;
      drill_button_class.add(Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],

      ));
      set(drill_button_class);
    });
  }

  void refresh_drills(mapData) {
    set([]);
    //print(mapData);
    mapData.forEach((key, value) {
      List drill_button_class = state;
      drill_button_class.add(Drill(
        name: key,
        d: value["d"],
        l: value["l"],
        form: value["form"],
        dt: value["dt"],
        a: value["a"],

      ));
      set(drill_button_class);
    });
  }

}

final Drill_class_Provider =
StateNotifierProvider<Drill_class_Notifier, List>(
        (ref) => Drill_class_Notifier());
