import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/data_parse.dart';
import 'package:morbidelli_cam/editor/overlay/var_object.dart';
import 'package:morbidelli_cam/provider/global.dart';

import '../../provider/provider_lib.dart';
import '../model/model_render.dart';

class VarList extends ConsumerStatefulWidget {
  VarList({super.key});

  @override
  ConsumerState<VarList> createState() => _VarListState();
}

class _VarListState extends ConsumerState<VarList> {
  static const IconData removeButton =
      IconData(0xe518, fontFamily: 'MaterialIcons');
  static const IconData addButton =
      IconData(0xe050, fontFamily: 'MaterialIcons');

  List selectedItems = [];

  @override
  Widget build(BuildContext context) {
    Map varList = globalVar.state;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0), // here the desired height
          child: AppBar(
            leading: const Center(child: Text("Variables")),
            leadingWidth: 75,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    globalVar.add(globalVar.getNewKey(), 0.0);
                  });
                },
                icon: const Icon(addButton),
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -3),
              ),
              IconButton(
                onPressed: () {
                  for (String entity in selectedItems) {
                    setState(() {
                      globalVar.remove(entity);
                    });
                  }
                },
                icon: const Icon(removeButton),
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -3),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    LineAxis axis = LineAxis.f;
                    ref.read(entityProvider.notifier).update();
                    ref.read(entityProvider.notifier).parseLine3D(ref, axis);
                    String wavefront = modelBase();
                    ref.read(modelContentProvider.notifier).set(wavefront);
                  });
                },
                icon: const Icon(Icons.refresh, color: Colors.lightGreen,),
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -3),
              ),
            ],
          ),
        ),
        body: ListView(reverse: true, children: [
          for (var data in varList.keys)
            VarEntity(
              keyid: data,
              selectFunction: (key, select) {
                if (select) {
                  selectedItems.add(key);
                } else {
                  selectedItems.remove(key);
                }
              },
              updateFunction: () {
                setState(() {});
              },
            )
        ]));
  }
}
