import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider/provider_lib.dart';

//Config Window for all imported drills
class DrillConfig extends ConsumerWidget {
  const DrillConfig({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
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
              //import all drills from global drill class Provider
              for (int i = 0; i < ref.read(drillclassprovider).length; i++)
                ref.read(drillclassprovider)[i]
            ]));
  }
}
