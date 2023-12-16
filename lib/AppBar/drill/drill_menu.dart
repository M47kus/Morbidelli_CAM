import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:morbidelli_cam/AppBar/drill/save_drill.dart";
import "package:morbidelli_cam/helper/textinput.dart";
import "package:morbidelli_cam/provider_lib.dart";

//Menu, called from Drill class
class Drill_Menu extends ConsumerStatefulWidget {

  final String name;
  final double d;
  final double l;
  final String form;
  final double? dt;
  final double? a;

  Drill_Menu({required this.name, required this.d, required this.l, required this.form, this.dt, this.a});

  @override
  ConsumerState<Drill_Menu> createState() => _Drill_MenuState();
}

class _Drill_MenuState extends ConsumerState<Drill_Menu> {
  //create temporary TxtController for data editing
  TextEditingController d_txt = TextEditingController();

  TextEditingController l_txt = TextEditingController();

  TextEditingController form_txt = TextEditingController();

  TextEditingController dt_txt = TextEditingController();

  TextEditingController a_txt = TextEditingController();

  //declares if window is in view or edit mode
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    //fill textcontroller with data
    d_txt.text = widget.d.toString();
    l_txt.text = widget.l.toString();
    form_txt.text = widget.form.toString();
    dt_txt.text = widget.dt.toString();
    a_txt.text = widget.a.toString();

    //return edit or view
    if (edit == false) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                widget.name,
                style: const TextStyle(fontSize: 18),
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                //data on read mode
                Text("durchmesser: " + widget.d.toString()),
                Text("lenght: " + widget.l.toString()),
                Text("form: " + widget.form.toString()),
                Text("durchmesser spitze: " + widget.dt.toString()),
                Text("angle: " + widget.a.toString()),
                TextButton(onPressed: () {setState(() {
                  edit = true;
                });}, child: const Text("Edit"))
              ],
            ),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                widget.name,
                style: const TextStyle(fontSize: 18),
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                //data to be edited
                ConfigTextInput(label: "durchmesser", controller: d_txt),
                ConfigTextInput(label: "lenght", controller: l_txt),
                ConfigTextInput(label: "form", controller: form_txt),
                ConfigTextInput(label: "durchmesser spitze", controller: dt_txt),
                ConfigTextInput(label: "angle", controller: a_txt),
                TextButton(onPressed: () async {
                  //create new Drill Map and save Settings to file
                  Map drill_map = update_drill(drill_button_class: ref.read(Drill_class_Provider) , name: widget.name, d: d_txt.text, l: l_txt.text, form: form_txt.text, dt: dt_txt.text, a: a_txt.text);
                  //recreate all Drill classes
                  ref.read(Drill_class_Provider.notifier).refresh_drills(drill_map);
                  Navigator.of(context)..pop();
                }, child: const Text("Save"))
              ],
            ),
          ));
    }
  }
}

