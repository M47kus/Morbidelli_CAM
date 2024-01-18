import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/base/info.dart';

//Detailed info Button on right side
class DrillInfo extends ConsumerWidget with Info {
  final int id;
  DrillInfo({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {
            onTab(ref, id);
          },
          child: getEntityData(ref, id, "Drill")),
    );
  }
}
