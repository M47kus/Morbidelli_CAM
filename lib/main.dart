import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/drill/load_drill.dart';
import 'package:morbidelli_cam/load_settings.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'AppBar/Files/files.dart';
import 'AppBar/edit/edit.dart';
import 'AppBar/mode.dart';
import 'AppBar/view.dart';
import 'AppBar/simulate.dart';
import 'AppBar/drill/drill.dart';
import 'editor/editor.dart';

void main() {
  runApp(ProviderScope(child: Morbidelli_CAM()));
}

class Morbidelli_CAM extends ConsumerWidget {
  const Morbidelli_CAM({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    init_settings();
    ref.read(Drill_class_Provider.notifier).init_drills();
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          useMaterial3: true
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AppBar_Files(),
          AppBar_Edit(),
          AppBar_Mode(),
          AppBar_View(),
          AppBar_drill(),
          AppBar_simulate()
        ],
      ),
      body: Editor(),
    );
  }
}
