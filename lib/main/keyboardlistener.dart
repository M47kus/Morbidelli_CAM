import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/model/editor.dart';
import '../provider/provider_lib.dart';


class KeyBoardListenerGlobal extends ConsumerStatefulWidget {
  const KeyBoardListenerGlobal({super.key});

  @override
  ConsumerState<KeyBoardListenerGlobal> createState() => _KeyBoardListenerGlobalState();
}

class _KeyBoardListenerGlobalState extends ConsumerState<KeyBoardListenerGlobal> {
  KeyEventResult keyBoardHandler(FocusNode node, RawKeyEvent event) {

    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        ref.read(modelViewProvider.notifier).setFree();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  final FocusNode _focusNode = FocusNode();
  late FocusAttachment _focusAttach;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusAttach = _focusNode.attach(context, onKey: keyBoardHandler);
  }

  @override
  Widget build(BuildContext context) {
    _focusAttach.reparent();
    return const Editor();
  }
}
