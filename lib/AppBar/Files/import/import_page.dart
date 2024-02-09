import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../../provider/provider_lib.dart';
import '../../drill/drill_class.dart';

class ImportRoute extends ConsumerStatefulWidget {
  const ImportRoute({super.key});

  @override
  ConsumerState<ImportRoute> createState() => _ImportRouteState();
}

class _ImportRouteState extends ConsumerState<ImportRoute> {
  TextEditingController drilltxt = TextEditingController();
  TextEditingController dephttxt = TextEditingController();
  double detail = 10;

  void initState() {
    super.initState();
    drilltxt.text = ref.read(drillclassprovider).values.toList()[0].name;
    dephttxt.text = 1.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
          Divider(),
          ConfigTextInput(label: "Depht", controller: dephttxt),
          Divider(),
          Slider(
              value: detail,
              max: 20,
              min: 1,
              label: detail.toString(),
              onChanged: (value) {
                setState(() {
                  detail = value;
                });
              })
        ],
      ),
    );
  }
}
