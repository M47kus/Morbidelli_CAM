import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/base/info.dart';
import 'package:morbidelli_cam/load_settings.dart';

import '../../path_privider_lib.dart';

//Detailed info Button on right side
class G0_Info extends ConsumerWidget with Info {
  final int id;
  G0_Info({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {
            OnTab(ref, id);
          },
          child: const Text("G0")),
    );
  }
}
