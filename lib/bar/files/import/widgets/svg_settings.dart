import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill_class.dart';
import 'package:morbidelli_cam/bar/files/import/functions/import.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

import '../../../../provider/global.dart';

enum SVGConvertType { lines, circles }

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
  final List<bool> _selectedType = [false, true];

  SVGConvertType convertType = SVGConvertType.circles;
  double maxDetail = 40;
  int detailDivider = 1;

  @override
  void initState() {
    super.initState();
    drilltxt.text = ref.read(drillclassprovider).values.toList()[0].name;
    dephttxt.text = 1.toString();

    if (_selectedType[0]) {
      detailDivider = 39;
      convertType = SVGConvertType.lines;
    } else {
      detailDivider = (39 / 3).round();
      convertType = SVGConvertType.circles;
    }
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
            const Text("Convert roundings to: "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                  isSelected: _selectedType,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedType.length; i++) {
                        _selectedType[i] = i == index;
                      }

                      if (_selectedType[0]) {
                        detailDivider = 39;
                        convertType = SVGConvertType.lines;
                      } else {
                        detailDivider = (39 / 3).round();
                        convertType = SVGConvertType.circles;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  children: const [Text("Lines"), Text("Circles")]),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Detail"),
            ),
            Slider(
                value: detail,
                max: maxDetail,
                min: 1,
                divisions: detailDivider,
                label: detail.toString(),
                onChanged: (value) {
                  setState(() {
                    detail = value.round().toDouble();
                  });
                }),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              importDepth = double.parse(dephttxt.text);
              importDrill = ref.read(drillclassprovider)[drilltxt.text];
              importDetail = detail;
              await importFile(ref, widget.extension, convertType);
              Navigator.of(context).pop();
            },
            child: const Text("Import file"))
      ],
    );
  }
}
