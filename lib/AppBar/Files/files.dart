import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/Files/settings.dart';
import '../../provider_lib.dart';
import 'import.dart';

//files Tab in MainWindow
class AppBar_Files extends ConsumerStatefulWidget {
  const AppBar_Files({super.key});

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
            //ButtonPress functions
            onSelected: (value) async {
              if (value == 0) {
                //Import
                //open file picker, get file
                var importedFile =
                await change_file(state: ref.read(modelContentProvider));
                //set model content to file content
                ref.read(modelContentProvider.notifier).set(importedFile);
              } else if (value == 1) {
                //Save
              } else if (value == 2) {
                //Open

              } else if (value == 3) {
                //Settings
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Settings_Menu()));
              } else if (value == 4) {
                //Export
              }
            }));
  }
}
