import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/load_settings.dart';
import 'package:morbidelli_cam/path_privider_lib.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'AppBar/Files/files.dart';
import 'AppBar/edit/edit.dart';
import 'AppBar/view.dart';
import 'AppBar/simulate.dart';
import 'AppBar/drill/drill.dart';
import 'edit_overlay/overlay.dart';
import 'model_editor/editor.dart';

void main() {
  runApp(const ProviderScope(child: MorbidelliCAM()));
}

class MorbidelliCAM extends ConsumerWidget {
  const MorbidelliCAM({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initSettings(); //read settings from yaml + TextEditingController
    ref
        .read(drillclassprovider.notifier)
        .initDrills(); //read drills.yaml + create Drill classes
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [
            AppBarFiles(),
            AppBarEdit(),
            AppBar_View(),
            AppBarDrill(),
            AppBar_simulate()
          ],
        ),
        body: Stack(
          children: [
            if (ref.watch(showModelProvider) == true) const Editor(),
            const PathEditor()
          ],
        ));
  }
}
