import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/mask.dart';
import 'group_data.dart';

//icon Button in Edit Mask (top)
class GroupMask extends ConsumerWidget with Mask {
  const GroupMask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, GroupData(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/drill.jpg",
            ),
            const Text("Group"), // <-- Text
          ],
        ),
      ),
    );
  }
}
