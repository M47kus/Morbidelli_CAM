import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import '../../load_settings.dart';
import '../../model_editor/model_render.dart';
import '../../provider_lib.dart';

//change base size from Textediting Controller
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
          title: const Text(
        "Base Plate",
        style: TextStyle(fontSize: 18),
      )),
      body: Column(
        children: [
          ConfigTextInput(label: "DX", controller: model_dx),
          ConfigTextInput(label: "DY", controller: model_dy),
          ConfigTextInput(label: "DZ", controller: model_dz),
          TextButton(
              onPressed: () {
                //get new obj file from txtcontroller
                String wavefront = model_base();
                //update model in provider
                ref.read(modelContentProvider.notifier).set(wavefront);
                Navigator.pop(context);
              },
              child: const Text("Update"))
        ],
      ),
    );
  }
}
