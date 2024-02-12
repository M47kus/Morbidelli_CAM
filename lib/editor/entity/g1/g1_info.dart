import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/base/info.dart';

//Detailed info Button on right side
class G1Info extends ConsumerWidget with Info {
  final int id;
  G1Info({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {
            onTab(ref, id);
          },
          child: getEntityData(ref, id, "G1")),
    );
  }
}
