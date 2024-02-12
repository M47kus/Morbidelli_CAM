import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';
import 'package:morbidelli_cam/bar/files/import/import.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

class ShowSVGSettings extends ConsumerStatefulWidget {
  final String extension;
  const ShowSVGSettings({
    super.key,
    required this.extension,
  });

  @override
  ConsumerState<ShowSVGSettings> createState() => _ShowSVGSettingsState();
}

class _ShowSVGSettingsState extends ConsumerState<ShowSVGSettings> {
  TextEditingController drilltxt = TextEditingController();
  TextEditingController dephttxt = TextEditingController();
  double detail = importDetail;

  @override
  void initState() {
    super.initState();
    drilltxt.text = ref.read(drillclassprovider).values.toList()[0].name;
    dephttxt.text = 1.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                initialSelection: ref.read(drillclassprovider)[drilltxt.text],
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
        const Divider(),
        ConfigTextInput(label: "Depht", controller: dephttxt),
        const Divider(),
        Row(
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
        ElevatedButton(
            onPressed: () async {
              importDepth = double.parse(dephttxt.text);
              importDrill = ref.read(drillclassprovider)[drilltxt.text];
              importDetail = detail;
              await importFile(ref, widget.extension);
              Navigator.of(context).pop();
            },
            child: const Text("Import file"))
      ],
    );
  }
}
