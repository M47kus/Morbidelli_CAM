import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';

import '../data_parse.dart';

class PathSubObject extends ConsumerStatefulWidget {
  const PathSubObject({super.key});

  @override
  ConsumerState<PathSubObject> createState() => _PathSubObjectState();
}

class _PathSubObjectState extends ConsumerState<PathSubObject> {
  List selectedItems = [];
  static const IconData deleteOutlined =
      IconData(0xefa8, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    List subobjectList = ref.watch(entityProvider);

    return Scaffold(
      appBar: ref.watch(pathObjectEdit)
          ? PreferredSize(
              preferredSize:
                  const Size.fromHeight(30.0), // here the desired height
              child: AppBar(
                leading: const Center(child: Text("Edit")),
                leadingWidth: 75,
                actions: [
                  IconButton(
                      visualDensity:
                          const VisualDensity(horizontal: -3, vertical: -3),
                      onPressed: () {
                        for (int itemId in selectedItems) {
                          ref
                              .read(entityProvider.notifier)
                              .removeObject(itemId);
                        }
                        selectedItems.clear();
                        ref.read(pathObjectEdit.notifier).set(false);
                      },
                      icon: const Icon(deleteOutlined)),
                ],
              ),
            )
          : null,
      body: ReorderableListView(
        children: [
          for (int id = 0; id < subobjectList.length; id++)
            subobjectList[id].getInfoButton(id, (key, select) {
              setState(() {
                if (select) {
                  selectedItems.add(key);
                } else {
                  selectedItems.remove(key);
                }
                if (selectedItems.isEmpty) {
                  ref.read(pathObjectEdit.notifier).set(false);
                } else {
                  ref.read(pathObjectEdit.notifier).set(true);
                }
                print(selectedItems);
              });
            })
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = ref.read(entityProvider)[oldIndex];
            ref.read(entityProvider.notifier).removeIndex(oldIndex);
            ref.read(entityProvider.notifier).insertObject(newIndex, item);
          });
        },
      ),
    );
  }
}
