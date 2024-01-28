import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/mask.dart';
import 'cir3p_edit.dart';

//icon Button in Edit Mask (top)
class Cir3PMask extends ConsumerWidget with Mask {
  const Cir3PMask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, Cir3PData(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/bogen.pgm",
            ),
            const Text("Cir3P"), // <-- Text
          ],
        ),
      ),
    );
  }
}
