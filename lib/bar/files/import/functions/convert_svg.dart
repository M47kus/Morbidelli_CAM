import 'dart:io';
import 'dart:math';
import 'package:morbidelli_cam/bar/files/import/functions/translate_svg.dart';
import 'package:xml/xml.dart';

import 'svg_lib.dart';

void convertSVG(filePath, ref) {
  File plainSVG = File(filePath);
  XmlDocument document = XmlDocument.parse(plainSVG.readAsStringSync());
  int pathLenght = document
      .findAllElements("g")
      .map((element) => element.findAllElements("path").length)
      .elementAt(0);
  for (int i = 0; i < pathLenght; i++) {
    List an = document
        .findAllElements("g")
        .map((element) =>
            element.findAllElements("path").elementAt(i).attributes)
        .toList()[0];
    for (int i = 0; i < an.length; i++) {
      if (an[i].name.toString() == "d") {
        String value = an[i].value;
        //single objects
        List splits = [];

        //split line in single entrys
        for (String data in value.split(" ")) {
          for (String value in data.split(",")) {
            splits.add(value);
          }
        }

        List svgData = [];

        String activeKey = "";
        int activeId = 0;
        Point lastPoint = const Point(0, 0);
        Point firstPoint = const Point(0, 0);
        // print(splits);
        for (int entryId = 0; entryId < splits.length; entryId++) {
          if (entryId == activeId) {
            if (double.tryParse(splits[entryId]) == null) {
              if (svGKeys
                  .containsKey(splits[entryId].toString().toUpperCase())) {
                activeKey = splits[entryId].toString().toUpperCase();
                int paramlenght =
                    svGParams[splits[entryId].toString().toUpperCase()];

                bool isRelative = false;
                if (splits[entryId] !=
                    splits[entryId].toString().toUpperCase()) {
                  isRelative = true;
                }

                svgData.add(addsvgData(
                    splits[entryId].toString().toUpperCase(),
                    splits,
                    entryId,
                    svgData,
                    lastPoint,
                    firstPoint,
                    true,
                    isRelative));
                activeId += paramlenght + 1;
                lastPoint = Point(svgData.last.x, svgData.last.y);

                //save to first point for z close
                if (splits[entryId].toString().toUpperCase() == "M") {
                  firstPoint = Point(svgData.last.x, svgData.last.y);
                }
              } else {}
            } else {
              int paramlenght = svGParams[activeKey];

              svgData.add(addsvgData(activeKey, splits, entryId, svgData,
                  lastPoint, firstPoint, false, false));
              activeId += paramlenght;
              lastPoint = Point(svgData.last.x, svgData.last.y);
            }
          }
        }

        translateSVG(svgData, ref);
      }
    }
  }
}

dynamic addsvgData(
    key, splits, entryId, svgData, lastPoint, firstPoint, isKey, isrelative) {
  int counter = 1;
  Point offset = const Point(0, 0);
  if (isKey == false) {
    counter = 0;
  }
  if (isrelative) {
    offset = lastPoint;
  }
  if (key == "Z") {
    return svGKeys[key](firstPoint.x, firstPoint.y);
  } else if (key == "H") {
    return svGKeys[key](
        double.parse(splits[entryId + counter]) + offset.x, lastPoint.y);
  } else if (key == "V") {
    return svGKeys[key](
        lastPoint.x, double.parse(splits[entryId + counter]) + offset.y);
  } else if (key == "M") {
    if (isKey == false) {
      key = "L";
    }
    return svGKeys[key](double.parse(splits[entryId + counter]) + offset.x,
        double.parse(splits[entryId + counter + 1]) + offset.y);
  } else if (key == "L") {
    return svGKeys[key](double.parse(splits[entryId + counter]) + offset.x,
        double.parse(splits[entryId + counter + 1]) + offset.y);
  } else if (key == "C") {
    return svGKeys[key](
        lastPoint.x,
        lastPoint.y,
        double.parse(splits[entryId + counter]) + offset.x,
        double.parse(splits[entryId + counter + 1]) + offset.y,
        double.parse(splits[entryId + counter + 2]) + offset.x,
        double.parse(splits[entryId + counter + 3]) + offset.y,
        double.parse(splits[entryId + counter + 4]) + offset.x,
        double.parse(splits[entryId + counter + 5]) + offset.y);
  } else if (key == "A") {
    return svGKeys[key](
      double.parse(splits[entryId + counter]),
      double.parse(splits[entryId + counter + 1]),
      double.parse(splits[entryId + counter + 2]),
      double.parse(splits[entryId + counter + 3]),
      double.parse(splits[entryId + counter + 4]),
      double.parse(splits[entryId + counter + 5]) + offset.x,
      double.parse(splits[entryId + counter + 6]) + offset.y,
    );
  }
}
