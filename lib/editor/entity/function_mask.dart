import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/circle3p/cir3p_mask.dart';
import 'package:morbidelli_cam/editor/entity/drill/drill_mask.dart';
import 'package:morbidelli_cam/editor/entity/g0/go_mask.dart';
import 'package:morbidelli_cam/editor/entity/g1/g1_mask.dart';
import '../data_parse.dart';
import '../../provider/path_privider_lib.dart';

//Mask for adding new commands to cnc list
class PathMask extends ConsumerWidget {
  const PathMask({super.key});

  static const IconData arrowDropUpSharp =
      IconData(0xe799, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        //close Button
        // IconButton(
        //   icon: const Icon(arrowDropUpSharp),
        //   onPressed: () {
        //     //close entity editor
        //     int dirId = ref.read(pathDirectoryIdProvider);
        //     ref.watch(showCreatorProvider.notifier).set(false);
        //     ref.read(entityProvider.notifier).removeObject(dirId, 0);
        //     ref.read(pathDirectoryLockProvider.notifier).set(false);
        //
        //     //close edit overlay
        //     ref.read(cncModeProvider.notifier).set(false);
        //     ref.read(pathDirectoryIdProvider.notifier).set(0);
        //     ref.read(pathDirectoryLockProvider.notifier).set(false);
        //     ref.read(showModelProvider.notifier).set(true);
        //   },
        // ),
        //G0 Button
        DrillMask(),
        G0Mask(),
        G1Mask(),
        Cir3PMask()
      ],
    );
  }
}
