import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  ResultsPage({
    @required this.bmiResult,
    @required this.resultText,
    @required this.interpretation,
  });

  Color getColor() {
    if (resultText == 'Underweight') {
      return kUnderweightColor;
    } else if (resultText == 'Normal') {
      return kNormalColor;
    } else if (resultText == 'Overweight') {
      return kOverweightColor;
    } else {
      return kDefaultColor;
    }
  }

  Map<String, double> getChartData() {
    if (resultText == 'Underweight') {
      return {
        'Underweight': 100.0,
        'Normal': 0.0,
        'Overweight': 0.0,
      };
    } else if (resultText == 'Normal') {
      return {
        'Underweight': 0.0,
        'Normal': 100.0,
        'Overweight': 0.0,
      };
    } else if (resultText == 'Overweight') {
      return {
        'Underweight': 0.0,
        'Normal': 0.0,
        'Overweight': 100.0,
      };
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI ZAIFI'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Upshot',
                style: kTitleTextStyle,
              ),
            ),
            ReusableCard(
              colour: getColor(),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // Display the pie chart separately
            Center(
              child: PieChart(
                dataMap: getChartData(),
                colorList: [kUnderweightColor, kNormalColor, kOverweightColor],
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "BMI",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BottomButton(
              buttonTitle: 'DO IT AGAIN',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
