import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/mask.dart';
import 'g1_data.dart';

//icon Button in Edit Mask (top)
class G1Mask extends ConsumerWidget with Mask {
  const G1Mask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return pathMask(
      child: InkWell(
        onTap: () {
          onTab(ref, G1Data(id: 0));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/Xl2p.bmp",
            ),
            const Text("G1"), // <-- Text
          ],
        ),
      ),
    );
  }
}
