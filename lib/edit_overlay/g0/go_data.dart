import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

import '../../provider_lib.dart';

//Detailed info Button on right side
class G0_Data extends ConsumerStatefulWidget {
  const G0_Data({super.key});

  @override
  ConsumerState<G0_Data> createState() => _G0_DataState();
}

class _G0_DataState extends ConsumerState<G0_Data> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {
            //show creation window
            ref.read(path_creator_provider.notifier).set(const G0_Creator());
            //disable directory buttons
            ref.read(path_directory_lock_provider.notifier).set(true);
          },
          child: const Text("G0")),
    );
  }
}
