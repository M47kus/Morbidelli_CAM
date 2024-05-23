
import 'package:flutter/material.dart';

import '../bar/drill/drill_class.dart';

InternalVar globalVar = InternalVar();

final TextEditingController modelScaleUnit = TextEditingController(text: "X");
TextEditingController defaultDX = TextEditingController();
TextEditingController defaultDY = TextEditingController();
TextEditingController defaultDZ = TextEditingController();
TextEditingController circleTMin = TextEditingController();

double modelDX = 0;
double modelDY = 0;
double modelDZ = 0;

double importDepth = 1.0;
Drill? importDrill;
double importDetail = 16;



class InternalVar {
  Map<String,double> state = {};
  InternalVar();

  set(Map<String, double> data) {
    state = data;
  }

  add(String key, double par) {
    Map<String, double> old = Map.from(state);
    old[key] = par;
    state = old;
  }

  update(String oldkey, String key, double par) {
    Map<String, double> old = Map.from(state);
    old.remove(oldkey);
    old[key] = par;
    state = old;
  }

  remove(String objId) {
    Map<String, double> old = Map.from(state);
    old.remove(objId);
    state = old;
  }

  getNewKey() {
    int id = 1;
    if (state.keys.isNotEmpty) {
      List keyids = [];
      for (String key in state.keys) {
        if (key.length >= 4) {
          if (key.substring(0, 3) == "var") {
            try {
              if (key.length == 4) {
                id = int.parse(key[3]);
              } else if (key.length == 5) {
                id = int.parse(key.substring(3, 5));
              } else if (key.length == 6) {
                id = int.parse(key.substring(3, 6));
              }

              keyids.add(id);
            } finally {}
          }
        }
      }

      if (keyids.isNotEmpty) {
        id = keyids.reduce((curr, next) => curr > next ? curr : next) + 1;
      }
    }
    return "var$id";
  }
}

