import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/mask.dart';
import 'drill_data.dart';

//icon Button in Edit Mask (top)
class DrillMask extends ConsumerWidget with Mask {
  const DrillMask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, DrillData(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/drill.jpg",
            ),
            const Text("Drill"), // <-- Text
          ],
        ),
      ),
    );
  }
}
