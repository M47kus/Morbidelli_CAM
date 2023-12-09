import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';


class ModelContentNotifier extends StateNotifier<String> {
  ModelContentNotifier() : super("");

  set(String file) {
    state = file;
  }
  void readObject(){
    set(File('assets/rect.obj').readAsStringSync());
  }
}

final modelContentProvider =
StateNotifierProvider<ModelContentNotifier, String>(
        (ref) => ModelContentNotifier());

class ModelViewNotifier extends StateNotifier<String> {
  ModelViewNotifier() : super("Solid");

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

final modelViewProvider =
StateNotifierProvider<ModelViewNotifier, String>(
        (ref) => ModelViewNotifier());