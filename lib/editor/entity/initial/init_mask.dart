import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/mask.dart';
import 'init_data.dart';

//icon Button in Edit Mask (top)
class InitMask extends ConsumerWidget with Mask {
  const InitMask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, InitData(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/B.bmp",
            ),
            const Text("Init"), // <-- Text
          ],
        ),
      ),
    );
  }
}
