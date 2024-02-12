import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/files/import/import.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

class ShowOBJSettings extends ConsumerStatefulWidget {
  final String extension;
  const ShowOBJSettings({super.key, required this.extension});

  @override
  ConsumerState<ShowOBJSettings> createState() => _ShowOBJSettingsState();
}

class _ShowOBJSettingsState extends ConsumerState<ShowOBJSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConfigTextInput(
            label: "Scale Unit obj import", controller: modelScaleUnit),
        ElevatedButton(
            onPressed: () async {
              await importFile(ref, widget.extension);
              Navigator.of(context).pop();
            },
            child: const Text("Import file"))
      ],
    );
  }
}
