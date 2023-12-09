import 'package:flutter/material.dart';
import 'AppBar/files.dart';
import 'AppBar/edit.dart';
import 'AppBar/mode.dart';
import 'AppBar/view.dart';
import 'AppBar/simulate.dart';
import 'AppBar/drill.dart';
import 'editor.dart';


void main() {
  runApp(const Morbidelli_CAM());
}

class Morbidelli_CAM extends StatelessWidget {
  const Morbidelli_CAM({super.key});

  @override
  Widget build(BuildContext context) {
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
