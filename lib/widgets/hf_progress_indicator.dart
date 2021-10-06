import 'package:flutter/material.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';
import 'package:hacktoberfest_checker/models/user.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HacktoberfestProgressIndicator extends StatelessWidget {
  User user;
  List<PullRequest> pull_requests;

  Widget _makeProgressBar() {
    int currentPR = this.pull_requests.length;
    currentPR = currentPR > 4 ? 4 : currentPR;
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: 4,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: Color.fromRGBO(43, 53, 49, 1),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                color: currentPR < 4 ? Color.fromRGBO(103, 118, 98, 1) :
                  Color.fromRGBO(247, 71, 0, 1),
                value: currentPR.toDouble(),
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0,
                angle: 90,
                widget: Text(
                  currentPR.toStringAsFixed(0) +
                  '/4',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ])
      ],
    );
  }

  HacktoberfestProgressIndicator(
      {@required this.user, @required this.pull_requests});

  @override
  Widget build(BuildContext context) {
    final int completedPRs = this.pull_requests.length;
    // final int completedPRs = 3;
    String completedPRsText;
    switch (completedPRs) {
      case 0:
        completedPRsText = "Start Hacking! 0/4 Completed!";
        break;
      case 1:
        completedPRsText = "Well done! 1/4 Completed!";
        break;
      case 2:
        completedPRsText = "Halfway done! 2/4 Completed!";
        break;
      case 3:
        completedPRsText = "Almost There! 3/4 Completed!";
        break;
      case 4:
        completedPRsText = "You have completed the Hacktoberfest !";
        break;
    }
    int indicatedPRs;
    if (completedPRs > 4) {
      indicatedPRs = 4;
    } else
      indicatedPRs = completedPRs;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        // height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.65,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.1),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple[50]),
            color: Color.fromRGBO(219, 232, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: _makeProgressBar())),
          Align(
              alignment: Alignment.bottomCenter,
              child: AutoSizeText(
                completedPRsText,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
                maxLines: 2,
              ))
        ]));
  }
}
