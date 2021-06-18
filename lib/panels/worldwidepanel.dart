import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {

  final Map? worldData;
  WorldWidePanel({this.worldData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: [
          StatusPanel(
            title: "CONFIRMED",
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: worldData!["cases"].toString(),
          ),
          StatusPanel(
            title: "ACTIVE",
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: worldData!["active"].toString(),
          ),
          StatusPanel(
            title: "RECOVERED",
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: worldData!["recovered"].toString(),
          ),
          StatusPanel(
            title: "DEATHS",
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldData!["deaths"].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color? panelColor;
  final Color? textColor;
  final String? title;
  final String? count;

  const StatusPanel(
      {this.panelColor,
      this.textColor,
      this.title,
      this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }
}
