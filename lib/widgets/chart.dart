import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final Color barBackgroundColor = const Color(0xFFFFFFFF);
  final Duration animDuration = const Duration(milliseconds: 300);
  final List<int> numbers;
  final double chartWidth;
  final int activeL, activeR;

  const ChartWidget({
    Key? key,
    required this.numbers,
    required this.chartWidth,
    required this.activeL,
    required this.activeR,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BarChart(
        mainBarData(),
        swapAnimationDuration: animDuration,
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    int y, {
    Color barColor = Colors.white,
    double width = 10,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y.toDouble(),
          borderRadius: BorderRadius.circular(3.0),
          colors: [barColor],
          width: chartWidth,
          backDrawRodData: BackgroundBarChartRodData(
              show: true, y: 30, colors: [Colors.white]),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() {
    return numbers.map((f) {
      return makeGroupData(
        numbers.indexOf(f),
        f,
        barColor: numbers.indexOf(f) <= activeR && numbers.indexOf(f) >= activeL
            ? Colors.yellow
            : const Color(0xFF46ACFF),
      );
    }).toList();
  }

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,

          getTextStyles: (value) => TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: chartWidth * 0.9 > 16 ? 16 : chartWidth * 0.9,
          ),
          //margin: 20,
          getTitles: (double value) {
            return value.toInt() < numbers.length
                ? numbers[(value ~/ 1).toInt()].toString()
                : 'null';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
