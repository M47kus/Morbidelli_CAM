import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/AppBar/drill/load_drill.dart';
import 'package:morbidelli_cam/provider_lib.dart';

import '../../helper/textinput.dart';
import '../../load_settings.dart';

class Drill_Config extends ConsumerWidget {
  const Drill_Config({super.key});


@override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Drill Config",
          style: TextStyle(fontSize: 18),
        )),
        body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 10,
            children: [
              for (int i = 0; i < ref.read(Drill_class_Provider).length; i++)
                ref.read(Drill_class_Provider)[i]

            ]));
  }
}


