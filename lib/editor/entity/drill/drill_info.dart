import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/info.dart';

//Detailed info Button on right side
class DrillInfo extends ConsumerWidget with Info {
  final int id;
  DrillInfo({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
      child: ListTile(
        onTap: () {onTab(ref, id);},
        dense: true,
        tileColor: Colors.black12,
        visualDensity: VisualDensity(vertical: -4),
        leading: const Text("Drill", style: TextStyle(fontSize: 12),),
        trailing: getEntityData(ref, id),
      )
    );
  }
}
