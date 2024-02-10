import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/Files/import/import.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/main/load_settings.dart';

import '../../../provider/provider_lib.dart';
import '../../drill/drill_class.dart';

enum ImportFileType { svg, obj }

class ImportRoute extends ConsumerStatefulWidget {
  const ImportRoute({super.key});

  @override
  ConsumerState<ImportRoute> createState() => _ImportRouteState();
}

class _ImportRouteState extends ConsumerState<ImportRoute> {
  TextEditingController drilltxt = TextEditingController();
  TextEditingController dephttxt = TextEditingController();
  double detail = importDetail;
  ImportFileType importType = ImportFileType.svg;
  String extension = "svg";

  void initState() {
    super.initState();
    drilltxt.text = ref.read(drillclassprovider).values.toList()[0].name;
    dephttxt.text = 1.toString();
  }

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
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              importType = ImportFileType.obj;
                              extension = "obj";
                            });
                          },
                          child: const Text("OBJ")),
                    )
            ],
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Drill",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenu<Drill>(
                    initialSelection:
                        ref.read(drillclassprovider)[drilltxt.text],
                    controller: drilltxt,
                    requestFocusOnTap: true,
                    dropdownMenuEntries: ref
                        .read(drillclassprovider)
                        .values
                        .map<DropdownMenuEntry<Drill>>((Drill drill) {
                      return DropdownMenuEntry<Drill>(
                        value: drill,
                        label: drill.name,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: const Divider(),
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: ConfigTextInput(label: "Depht", controller: dephttxt),
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: const Divider(),
          ),
          Visibility(
            visible: importType == ImportFileType.svg,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Detail"),
                ),
                Slider(
                    value: detail,
                    max: 20,
                    min: 1,
                    divisions: 19,
                    label: detail.toString(),
                    onChanged: (value) {
                      setState(() {
                        detail = value;
                      });
                    }),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                importDepth = double.parse(dephttxt.text);
                importDrill = ref.read(drillclassprovider)[drilltxt.text];
                importDetail = detail;
                await importFile(ref, extension);
                print("finsih");
                Navigator.of(context).pop();
              },
              child: const Text("Import file"))
        ],
      ),
    );
  }
}
