import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/files/import/widgets/obj_settings.dart';
import 'package:morbidelli_cam/bar/files/import/widgets/svg_settings.dart';

enum ImportFileType { svg, obj }

class ImportRoute extends ConsumerStatefulWidget {
  const ImportRoute({super.key});

  @override
  ConsumerState<ImportRoute> createState() => _ImportRouteState();
}

class _ImportRouteState extends ConsumerState<ImportRoute> {
  ImportFileType importType = ImportFileType.svg;
  String extension = "svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Import"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              importType == ImportFileType.svg
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {
                            setState(() {
                              importType = ImportFileType.svg;
                              extension = "svg";
                            });
                          },
                          child: const Text("SVG")),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              importType = ImportFileType.svg;
                              extension = "svg";
                            });
                          },
                          child: const Text("SVG")),
                    ),
              const VerticalDivider(),
              importType == ImportFileType.obj
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                          onPressed: () {
                            setState(() {
                              importType = ImportFileType.obj;
                              extension = "obj";
                            });
                          },
                          child: const Text("OBJ")),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        //todo: fix obj import, re render must be deactivaded when obj import is used, parse dx, dy, dz from obj file, change edit base system to global variable system
                          onPressed: null, //() {
                          //   setState(() {
                          //     importType = ImportFileType.obj;
                          //     extension = "obj";
                          //   });
                          // },
                          child: Text("OBJ")),
                    )
            ],
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: ShowSVGSettings(extension: extension),
          ),
          Visibility(
              visible: importType == ImportFileType.obj,
              child: ShowOBJSettings(
                extension: extension,
              )),
        ],
      ),
    );
  }
}
