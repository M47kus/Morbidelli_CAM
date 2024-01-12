import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

import '../base/mask.dart';

//icon Button in Edit Mask (top)
class G0_Mask extends ConsumerWidget with Mask {
  const G0_Mask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PathMask(
      child: InkWell(
        onTap: () {
          OnTab(ref, G0_Data(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/B.bmp",
            ),
            const Text("G0"), // <-- Text
          ],
        ),
      ),
    );
  }
}
