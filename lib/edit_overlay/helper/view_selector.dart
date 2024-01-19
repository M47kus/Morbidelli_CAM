import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/provider_lib.dart';

class ViewSelector extends ConsumerWidget {
  const ViewSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 145,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton.filledTonal(
                onPressed: () {
                  ref.read(modelViewProvider.notifier).setTop();
                },
                icon: const Text("T")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton.filledTonal(
                    onPressed: () {
                      ref.read(modelViewProvider.notifier).setSideLeft();
                    },
                    icon: const Text("SL")),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton.filledTonal(
                    onPressed: () {
                      ref.read(modelViewProvider.notifier).setFront();
                    },
                    icon: const Text("F")),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton.filledTonal(
                    onPressed: () {
                      ref.read(modelViewProvider.notifier).setSideRight();
                    },
                    icon: const Text("SR")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
