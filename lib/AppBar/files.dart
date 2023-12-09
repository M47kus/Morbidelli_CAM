import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider_lib.dart';
import 'Files/import.dart';

class AppBar_Files extends ConsumerStatefulWidget {
  AppBar_Files({super.key});

  @override
  ConsumerState<AppBar_Files> createState() => _AppBar_FilesState();
}

class _AppBar_FilesState extends ConsumerState<AppBar_Files> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PopupMenuButton(
            icon: const Text("Files"),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Import"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Save"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Open"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Settings"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Export"),
                ),
              ];
            },
            onSelected: (value) async {
              if (value == 0) {

              } else if (value == 1) {
                print("1");
              } else if (value == 2) {
                var imported_file = await change_file(state: ref.read(modelContentProvider));
                ref.read(modelContentProvider.notifier).set(imported_file);
              } else if (value == 3) {
                print("3");
              } else if (value == 4) {
                print("4");
              }
            }));
  }
}
