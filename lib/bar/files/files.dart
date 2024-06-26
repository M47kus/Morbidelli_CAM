import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/files/export/export_page.dart';
import 'import/functions/convert_svg.dart';
import 'import/widgets/import_page.dart';
import 'settings/settings.dart';

//files Tab in MainWindow
class AppBarFiles extends ConsumerStatefulWidget {
  const AppBarFiles({super.key});

  @override
  ConsumerState<AppBarFiles> createState() => _AppBarFilesState();
}

class _AppBarFilesState extends ConsumerState<AppBarFiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SizedBox(
          child: PopupMenuButton(
            iconSize: 15,
              icon: const Text("Files", style: TextStyle(fontSize: 12),),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Save"),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Open"),
                  ),
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Import"),
                  ),
                  const PopupMenuItem<int>(
                    value: 4,
                    child: Text("Export"),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("Settings"),
                  ),
                ];
              },
              //ButtonPress functions
              onSelected: (value) async {
                if (value == 0) {
                  //Import
                  //open file picker, get file
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImportRoute()));
                  //set model content to file content
                } else if (value == 1) {
                  //Save
                } else if (value == 2) {
                  convertSVG("/home/markus/IdeaProjects/Zeichnung.svg", ref);
                  //Open
                } else if (value == 3) {
                  //Settings
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsMenu()));
                } else if (value == 4) {
                  //Export
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExportRoute()));
                }
              }),
        ));
  }
}
