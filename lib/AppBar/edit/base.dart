import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/editor/model_render.dart';
import 'package:morbidelli_cam/helper/textinput.dart';

import '../../load_settings.dart';
import '../../provider_lib.dart';

class Edit_Base extends ConsumerStatefulWidget {
  const Edit_Base({super.key});

  @override
  ConsumerState<Edit_Base> createState() => _Edit_BaseState();
}

class _Edit_BaseState extends ConsumerState<Edit_Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Base Plate",
        style: TextStyle(fontSize: 18),
      )),
      body: Column(
        children: [ConfigTextInput(label: "DX", controller: model_dx),
          ConfigTextInput(label: "DY", controller: model_dy),
          ConfigTextInput(label: "DZ", controller: model_dz),
        TextButton(onPressed: () {
          String wavefront = model_base();
          ref.read(modelContentProvider.notifier).set(wavefront);
          Navigator.pop(context);
          }, child: Text("Update"))],

      ),
    );
  }
}
