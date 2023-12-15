import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:morbidelli_cam/helper/textinput.dart";
import "package:morbidelli_cam/provider_lib.dart";
import "package:yaml/yaml.dart";

import "drill_menu.dart";

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
    print(name);
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



