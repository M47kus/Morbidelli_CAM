import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/bar/custom_foot_bar.dart';
import 'package:morbidelli_cam/bar/custom_menu_bar.dart';
import 'package:morbidelli_cam/bar/files/settings/load_settings.dart';
import 'package:morbidelli_cam/editor/entity/function_mask.dart';
import 'package:morbidelli_cam/editor/model/main_window.dart';
import 'package:morbidelli_cam/editor/overlay/internal_var.dart';
import 'package:morbidelli_cam/editor/overlay/path_object.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';
import 'package:resizable_widget/resizable_widget.dart';

import 'editor/model/model_render.dart';

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
      body: ResizableWidget(
        isHorizontalSeparator: true,
        percentages: const [0.04, 0.96],
        children: [
          const CustomAppBar(),
          ResizableWidget(
            isHorizontalSeparator: false,
            percentages: const [0.2, 0.8],
            children: [
              ResizableWidget(isHorizontalSeparator: true, percentages: const [
                0.8,
                0.2
              ], children: [
                PathSubObject(),
                VarList(),
              ]),
              ResizableWidget(
                  isHorizontalSeparator: true,
                  percentages: const [0.1, 0.86, 0.04],
                  children: const [PathMask(), MainWindow(), CustomFootBar()]),
            ],
          ),
        ],
      ),
    );
  }
}
