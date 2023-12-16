import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/load_settings.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'AppBar/Files/files.dart';
import 'AppBar/edit/edit.dart';
import 'AppBar/view.dart';
import 'AppBar/simulate.dart';
import 'AppBar/drill/drill.dart';
import 'editor/editor.dart';

void main() {
  runApp(const ProviderScope(child: Morbidelli_CAM()));
}

class Morbidelli_CAM extends ConsumerWidget {
  const Morbidelli_CAM({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    init_settings();  //read settings from yaml + TextEditingController
    ref.read(Drill_class_Provider.notifier).init_drills(); //read drills.yaml + create Drill classes
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          useMaterial3: true
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          AppBar_Files(),
          AppBar_Edit(),
          AppBar_View(),
          AppBar_drill(),
          AppBar_simulate()
        ],
      ),
      body: Editor(),
    );
  }
}
