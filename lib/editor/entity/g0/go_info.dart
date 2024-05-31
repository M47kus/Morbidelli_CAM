import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/info.dart';

//Detailed info Button on right side
class G0Info extends ConsumerWidget with Info {
  final int id;
  G0Info({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
      child: ListTile(
        onTap: () {onTab(ref, id);},
        dense: true,
        tileColor: Colors.black12,
        visualDensity: VisualDensity(vertical: -4),
        leading: const Text("G0", style: TextStyle(fontSize: 12),),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: getEntityData(ref, id),
        ),
      )
    );
  }
}
