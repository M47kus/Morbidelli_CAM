import 'package:flutter/material.dart';

class DrillCorrection extends StatefulWidget {
  final int? data;
  final Function returnvalue;
  const DrillCorrection({super.key, this.data, required this.returnvalue});
  static const IconData circleOutlined =
      IconData(0xef53, fontFamily: 'MaterialIcons');

  @override
  State<DrillCorrection> createState() => _DrillCorrectionState();
}

class _DrillCorrectionState extends State<DrillCorrection> {
  int correction = 0;
  void _init() {
    setState(() {
      correction = widget.data ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(DrillCorrection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Side:",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Stack(
            children: [
              const SizedBox(
                width: 100,
                height: 115,
                child: VerticalDivider(color: Colors.white),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton.outlined(
                        icon: correction == 1
                            ? const Icon(DrillCorrection.circleOutlined)
                            : const Text(""),
                        onPressed: () {
                          setState(() {
                            correction = 1;
                            widget.returnvalue(1);
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton.outlined(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Theme.of(context).colorScheme.background;
                        })),
                        icon: correction == 0
                            ? const Icon(DrillCorrection.circleOutlined)
                            : const Text(""),
                        onPressed: () {
                          setState(() {
                            correction = 0;
                            widget.returnvalue(0);
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton.outlined(
                        icon: correction == 2
                            ? const Icon(DrillCorrection.circleOutlined)
                            : const Text(""),
                        onPressed: () {
                          setState(() {
                            correction = 2;
                            widget.returnvalue(2);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
