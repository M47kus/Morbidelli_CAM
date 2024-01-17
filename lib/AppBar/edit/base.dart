import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/helper/textinput.dart';
import '../../main/load_settings.dart';
import '../../model_editor/model_render.dart';
import '../../provider/provider_lib.dart';

//change base size from Textediting Controller
class EditBase extends ConsumerStatefulWidget {
  const EditBase({super.key});

  @override
  ConsumerState<EditBase> createState() => _EditBaseState();
}

class _EditBaseState extends ConsumerState<EditBase> {
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
          ConfigTextInput(label: "DX", controller: modelDX),
          ConfigTextInput(label: "DY", controller: modelDY),
          ConfigTextInput(label: "DZ", controller: modelDZ),
          TextButton(
              onPressed: () {
                //get new obj file from txtcontroller
                String wavefront = modelBase();
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
