import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morbidelli_cam/provider/global.dart';

import '../../provider/provider_lib.dart';


class VarEntity extends StatefulWidget {
  String keyid;
  Function selectFunction;
  Function updateFunction;
  VarEntity({super.key, required this.keyid, required this.selectFunction, required this.updateFunction});

  @override
  State<VarEntity> createState() => _VarEntityState();
}

class _VarEntityState extends State<VarEntity> {
  TextEditingController keyTxt = TextEditingController();
  TextEditingController valueTxt = TextEditingController();

  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');
  static const IconData check = IconData(0xef49, fontFamily: 'MaterialIcons');

  bool editData = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.black12,
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      dense: true,
      onTap: () {
        if (selected) {
          setState(() {
            selected = false;
            widget.selectFunction(widget.keyid, false);
          });
        } else {
          setState(() {
            selected = true;
            widget.selectFunction(widget.keyid, true);
          });
        }
      },
        selected: selected,
        selectedColor: Colors.lightGreen,
      leading: Visibility(
        visible: !editData,
        replacement: IconButton(
        icon: const Icon(check),
        onPressed: () {
          setState(() {
            globalVar.update(widget.keyid, keyTxt.text, double.parse(valueTxt.text));
            editData = false;
            widget.updateFunction();
          });
        },
        visualDensity: const VisualDensity(horizontal: -4, vertical: -3),
      ),child: IconButton(
        icon: const Icon(edit),
        onPressed: () {
          setState(() {
            editData = true;
            keyTxt.text = widget.keyid;
            valueTxt.text = globalVar.state[widget.keyid].toString();
          });
        },
        visualDensity: const VisualDensity(horizontal: -4, vertical: -3),
      ),),
      title: Visibility(
        visible: !editData,
        replacement: SizedBox(
          height: 25,
          width: 50,
          child: TextField(
            controller: keyTxt,
            cursorHeight: 20,
            style: const TextStyle(fontSize: 12.0, height: 1.5),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 8),
              hintText: 'Name',
            ),
          ),
        ),
        child: Text(widget.keyid.toString(), style: TextStyle(fontSize: 12),),
      ),
      trailing: Visibility(
        visible: !editData,
        replacement: SizedBox(
          height: 25,
          width: 50,
          child: TextField(
            controller: valueTxt,
            cursorHeight: 20,
            style: const TextStyle(fontSize: 12.0, height: 1.5),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 8),
              hintText: 'var',
            ),
          ),
        ),
        child: Text(globalVar.state[widget.keyid].toString()),
      )
    );
  }
}
