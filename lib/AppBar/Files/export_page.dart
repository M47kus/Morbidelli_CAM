import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/export_functions/export.dart';

import '../export_functions/export_data.dart';

class ExportRoute extends ConsumerStatefulWidget {
  const ExportRoute({super.key});

  @override
  ConsumerState<ExportRoute> createState() => _ExportRouteState();
}

class _ExportRouteState extends ConsumerState<ExportRoute> {
  ExportFormat defaultFormat = ExportFormat.xilog;
  ExportFormat selectedFormat = ExportFormat.xilog;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Export Format",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownMenu<ExportFormat>(
                  initialSelection: ExportFormat.xilog,
                  onSelected: (ExportFormat? format) {
                    setState(() {
                      selectedFormat = format ?? defaultFormat;
                    });
                  },
                  requestFocusOnTap: true,
                  dropdownMenuEntries: exportFormatTitle
                      .map<DropdownMenuEntry<ExportFormat>>((drill) {
                    return DropdownMenuEntry<ExportFormat>(
                      value: drill,
                      label: ExportExtension(drill).name,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  await exportXXL(ref);
                  Navigator.of(context).pop();
                },
                child: Text("Export ${selectedFormat.extension}")),
          )
        ],
      ),
    );
  }
}
