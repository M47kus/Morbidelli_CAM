import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "drill_menu.dart";

//Drill class which inherits all data and button widget
class Drill extends ConsumerWidget {
  final String name;
  final double d;
  final double l;
  final String form;
  final double? dt;
  final double? a;

  Drill({required this.name, required this.d, required this.l, required this.form, this.dt, this.a});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: Text(name),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Drill_Menu(name: name, d: d, l: l, form:form, dt: dt, a: a)));
      },
    );
  }

  }



