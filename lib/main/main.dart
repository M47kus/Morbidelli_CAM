import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/main/load_settings.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';
import '../AppBar/Files/files.dart';
import '../AppBar/edit/edit.dart';
import '../AppBar/view.dart';
import '../AppBar/simulate.dart';
import '../AppBar/drill/drill.dart';
import '../edit_overlay/overlay.dart';
import '../model_editor/editor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSettings();
  runApp(const ProviderScope(child: MorbidelliCAM()));
}

class MorbidelliCAM extends ConsumerStatefulWidget {
  const MorbidelliCAM({super.key});

  @override
  ConsumerState<MorbidelliCAM> createState() => _MorbidelliCAMState();
}

class _MorbidelliCAMState extends ConsumerState<MorbidelliCAM> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(drillclassprovider.notifier)
        .initDrills(); //read drills.yaml + create Drill classes
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
