import 'package:flutter/material.dart';

class G0_Mask extends StatelessWidget {
  const G0_Mask({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: Size(65, 65),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/icons/B.bmp",
                  ),
                  Text("G0"), // <-- Text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
