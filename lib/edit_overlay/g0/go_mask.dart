import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/edit_overlay/g0/go_edit.dart';
import 'package:morbidelli_cam/provider_lib.dart';

//icon Button in Edit Mask (top)
class G0_Mask extends ConsumerWidget {
  const G0_Mask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: const Size(65, 65),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {
                //show creation window
                ref
                    .read(path_creator_provider.notifier)
                    .set(const G0_Creator());
                //disable directory buttons
                ref.read(path_directory_lock_provider.notifier).set(true);
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
          ),
        ),
      ),
    );
  }
}
