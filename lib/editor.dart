import 'dart:io';

import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider_lib.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'model.dart';

class Editor extends ConsumerStatefulWidget {
  Editor({super.key});

  @override
  ConsumerState<Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<Editor> {
  final _controller = DiTreDiController(
    rotationX: 30,
    rotationY: 30,
    light: vector.Vector3(-0.5, -0.5, 0.5),
    lightStrength: 1,
  );

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(modelContentProvider.notifier).readObject();
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String modelContents = ref.watch(modelContentProvider);
    if(modelContents.isEmpty) return CircularProgressIndicator();

    return SafeArea(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Expanded(
            child: DiTreDiDraggable(
              controller: _controller,
              child: FutureBuilder(
                future: ObjParser().parse(modelContents),
                builder: (context, snapshot) {
                   if (snapshot.hasData && snapshot.data != null) {
                    return DiTreDi(
                      figures: snapshot.data!,
                      controller: _controller,
                    );
                  } else {
                    return Expanded(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
