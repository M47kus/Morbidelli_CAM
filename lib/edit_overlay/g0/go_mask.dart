import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';

import '../base/mask.dart';

//icon Button in Edit Mask (top)
class G0Mask extends ConsumerWidget with Mask {
  const G0Mask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, G0Data(id: 0));
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
