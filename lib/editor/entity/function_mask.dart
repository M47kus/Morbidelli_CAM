import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/entity/circle3p/cir3p_mask.dart';
import 'package:morbidelli_cam/editor/entity/drill/drill_mask.dart';
import 'package:morbidelli_cam/editor/entity/g0/go_mask.dart';
import 'package:morbidelli_cam/editor/entity/g1/g1_mask.dart';
import 'package:morbidelli_cam/editor/entity/group/group_mask.dart';
import 'package:morbidelli_cam/editor/entity/initial/init_mask.dart';

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
        //G0 Button
        InitMask(),
        DrillMask(),
        G0Mask(),
        G1Mask(),
        Cir3PMask(),
        VerticalDivider(),
        GroupMask()
      ],
    );
  }
}
