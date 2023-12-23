import 'package:flutter/material.dart';

class G0_Data extends StatefulWidget {
  const G0_Data({super.key});

  @override
  State<G0_Data> createState() => _G0_DataState();
}

class _G0_DataState extends State<G0_Data> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: OutlinedButton(
          onPressed: () {

          },
          child: Text("G0")),
    );
  }
}


