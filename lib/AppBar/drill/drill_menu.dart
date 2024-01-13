import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:morbidelli_cam/AppBar/drill/save_drill.dart";
import "package:morbidelli_cam/helper/textinput.dart";
import "package:morbidelli_cam/provider_lib.dart";

//Menu, called from Drill class
class DrillMenu extends ConsumerStatefulWidget {
  final String name;
  final double d;
  final double l;
  final String form;
  final double? dt;
  final double? a;

  const DrillMenu(
      {super.key,
      required this.name,
      required this.d,
      required this.l,
      required this.form,
      this.dt,
      this.a});

  @override
  ConsumerState<DrillMenu> createState() => _DrillMenuState();
}

class _DrillMenuState extends ConsumerState<DrillMenu> {
  //create temporary TxtController for data editing
  TextEditingController dtxt = TextEditingController();

  TextEditingController ltxt = TextEditingController();

  TextEditingController formtxt = TextEditingController();

  TextEditingController dttxt = TextEditingController();

  TextEditingController atxt = TextEditingController();

  //declares if window is in view or edit mode
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    //fill textcontroller with data
    dtxt.text = widget.d.toString();
    ltxt.text = widget.l.toString();
    formtxt.text = widget.form.toString();
    dttxt.text = widget.dt.toString();
    atxt.text = widget.a.toString();

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
                Text("durchmesser: ${widget.d}"),
                Text("lenght: ${widget.l}"),
                Text("form: ${widget.form}"),
                Text("durchmesser spitze: ${widget.dt}"),
                Text("angle: ${widget.a}"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        edit = true;
                      });
                    },
                    child: const Text("Edit"))
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
                ConfigTextInput(label: "durchmesser", controller: dtxt),
                ConfigTextInput(label: "lenght", controller: ltxt),
                ConfigTextInput(label: "form", controller: formtxt),
                ConfigTextInput(label: "durchmesser spitze", controller: dttxt),
                ConfigTextInput(label: "angle", controller: atxt),
                TextButton(
                    onPressed: () async {
                      //create new Drill Map and save Settings to file
                      Map drillMap = updateDrill(
                          drillbuttonClass: ref.read(drillclassprovider),
                          name: widget.name,
                          d: dtxt.text,
                          l: ltxt.text,
                          form: formtxt.text,
                          dt: dttxt.text,
                          a: atxt.text);
                      //recreate all Drill classes
                      ref
                          .read(drillclassprovider.notifier)
                          .refreshDrills(drillMap);
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child: const Text("Save"))
              ],
            ),
          ));
    }
  }
}
