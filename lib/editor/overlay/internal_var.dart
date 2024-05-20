import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/overlay/var_object.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

class VarList extends ConsumerWidget {
  VarList({super.key});
  static const IconData removeButton =
      IconData(0xe518, fontFamily: 'MaterialIcons');
  static const IconData addButton =
      IconData(0xe050, fontFamily: 'MaterialIcons');

  List selectedItems = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map varList = ref.watch(varProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0), // here the desired height
          child: AppBar(
            leading: const Center(child: Text("Variables")),
            leadingWidth: 75,
            actions: [
              IconButton(
                onPressed: () {
                  ref
                      .read(varProvider.notifier)
                      .add(ref.read(varProvider.notifier).getNewKey(), 0.0);
                },
                icon: const Icon(addButton),
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -3),
              ),
              IconButton(
                onPressed: () {
                  for (String entity in selectedItems) {
                    ref.read(varProvider.notifier).remove(entity);
                  }
                },
                icon: const Icon(removeButton),
                visualDensity:
                    const VisualDensity(horizontal: -3, vertical: -3),
              )
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
            )
        ]));
  }
}
