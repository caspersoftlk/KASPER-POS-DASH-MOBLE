import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class WeeklySales extends StatelessWidget {
  const WeeklySales({Key? key, required this.snapshot}) : super(key: key);
  final List<dynamic> snapshot;

  List<BarChartGroupData> _buildList(
      BuildContext context, List<dynamic> snapshot, String x, String y) {
    return snapshot.map((data) => _buildListItem(context, data, x, y)).toList();
  }

  BarChartGroupData _buildListItem(
      BuildContext context, dynamic data, String x, String y) {
    final Map<String, dynamic> map = data;

    // return BarChartGroupData(
    //     double.parse(map[x].toString()), double.parse(map[y].toString()));
    double xa = map[x];
    return BarChartGroupData(x: xa.toInt(), barRods: [
      BarChartRodData(y: double.parse(map[y].toString()),

          width: 12, colors: [blue.withOpacity(0.6), green, yellow],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3))),
    ]);
  }
  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      margin: 20,
      getTitles: (double value) {
        switch (value.toInt()) {
          case 1:
            return 'Sn';
          case 2:
            return 'Mn';
          case 3:
            return 'Te';
          case 4:
            return 'Wd';
          case 5:
            return 'Tu';
          case 6:
            return 'Fr';
          default:
            return 'St';
        }
      },
    ),
    leftTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGray.withOpacity(0.1),
                blurRadius: 12)
          ]),
      child: Column(
        children: [
          CustomText(
            text: "Week Breakdown",
            weight: FontWeight.bold,
            color: lightGray,
          ),
          SizedBox(height: 20),
          Container(
              height: 300,
              child: BarChart(BarChartData(
                titlesData: titlesData,
                  borderData: FlBorderData(
                      border: Border(
                        top: BorderSide.none,
                        right: BorderSide.none,
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1),
                      )),
                  groupsSpace: 10,
                  barGroups: _buildList(context, snapshot, "hour", "rew")))
          ),
        ],
      ),
    );
  }
}