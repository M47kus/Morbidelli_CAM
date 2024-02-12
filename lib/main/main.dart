import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/drill/drill.dart';
import 'package:morbidelli_cam/bar/edit/edit.dart';
import 'package:morbidelli_cam/bar/files/files.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/bar/view/view.dart';
import 'package:morbidelli_cam/editor/model/editor.dart';
import 'package:morbidelli_cam/editor/overlay/overlay.dart';
import 'package:morbidelli_cam/provider/path_privider_lib.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

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

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ref
        .read(drillclassprovider.notifier)
        .initDrills(); //read drills.yaml + create Drill classes
    return Scaffold(
        appBar: AppBar(
          actions: const [
            AppBarFiles(),
            AppBarEdit(),
            AppBarView(),
            AppBarDrill(),
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
