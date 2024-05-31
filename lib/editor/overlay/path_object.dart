import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_parse.dart';

class PathSubObject extends ConsumerStatefulWidget {
  const PathSubObject({super.key});

  @override
  ConsumerState<PathSubObject> createState() => _PathSubObjectState();
}

class _PathSubObjectState extends ConsumerState<PathSubObject> {
  @override
  Widget build(BuildContext context) {
    List subobjectList = ref.watch(entityProvider);
    return ReorderableListView(
      children: [
        for (int id = 0; id < subobjectList.length; id++)
          subobjectList[id].getInfoButton(id)
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
    );
  }
}
