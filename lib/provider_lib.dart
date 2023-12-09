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