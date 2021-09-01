import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class MidleWidgetLargeScreen extends StatelessWidget {
  const MidleWidgetLargeScreen({Key? key}) : super(key: key);

  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 2), (_) {
      return http.get(
          Uri.parse(
              'http://220.247.201.146/posadminmobile/livesalescharts'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*"
          });
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return StreamBuilder<http.Response>(
        stream: getRandomNumberFact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong');
          }
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child:
                      ValueBaseSales(snapshot: jsonDecode(snapshot.data!.body)),
                ),
                SizedBox(
                  width: _width / 64,
                ),
                Expanded(
                  child: TransactionViseSales(
                      snapshot: jsonDecode(snapshot.data!.body)),
                )
              ],
            ),
          );
        });
  }
}

class TransactionViseSales extends StatelessWidget {
  const TransactionViseSales({Key? key, required this.snapshot})
      : super(key: key);
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
            text: "Number of Customers",
            weight: FontWeight.bold,
            color: lightGray,
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: BarChart(BarChartData(
                borderData: FlBorderData(
                    border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                    )),
                groupsSpace: 10,
                barGroups: _buildList(context, snapshot, "hour", "count")))
          ),
        ],
      ),
    );
  }
}

class ValueBaseSales extends StatelessWidget {
  const ValueBaseSales({Key? key, required this.snapshot}) : super(key: key);
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
          width: 12, colors: [pink.withOpacity(0.6),blue,green],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(3),topRight: Radius.circular(3))),
    ]);
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
            text: "Hourly Revenue Breakdown",
            weight: FontWeight.bold,
            color: lightGray,
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            height: 300,
            child: BarChart(BarChartData(
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
