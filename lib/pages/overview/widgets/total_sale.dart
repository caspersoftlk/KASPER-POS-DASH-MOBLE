import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class TotalSales extends StatelessWidget {
  const TotalSales({Key? key, required this.snapshot}) : super(key: key);
  final List<dynamic> snapshot;

  List<FlSpot> _buildList(
      BuildContext context, List<dynamic> snapshot, String x, String y) {
    return snapshot.map((data) => _buildListItem(context, data, x, y)).toList();
  }

  FlSpot _buildListItem(
      BuildContext context, dynamic data, String x, String y) {
    final Map<String, dynamic> map = data;

    return FlSpot(
        double.parse(map[x].toString()), double.parse(map[y].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, top: 16),
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
            text: "Total Sale",
            weight: FontWeight.bold,
            color: lightGray,
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            height: 220,
            child: LineChart(
              LineChartData(

                maxX: getMaxXval(context, snapshot, "hour", "rew"),
                minX: 7,
                maxY: getMaxYval(context, snapshot, "hour", "rew") + 5000,
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                      dotData: FlDotData(show: false),
                      colors: chartColorizeColors,
                      barWidth: 2,
                      spots: _buildList(context, snapshot, "hour", "rew"))
                ],
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: lightGray, width: 1),
                ),
                gridData: FlGridData(
                  show: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}