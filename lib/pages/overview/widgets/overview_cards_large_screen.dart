import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:http/http.dart' as http;
import 'package:kasper_dash/helpers/custom_text.dart';
import 'info_card.dart';

class OverViewCardLargeScreen extends StatelessWidget {
  const OverViewCardLargeScreen({Key? key}) : super(key: key);

  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 5), (_) {
      return http.get(
          Uri.parse('http://220.247.201.146/posadminmobile/livesales'),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: green,
            );
          }
          if (snapshot.hasData) {
            var body = snapshot.data!.body;
            List<dynamic> list = jsonDecode(body);
            Map<String, dynamic> map = list[0];
            print(map);
            print(map['PAYTYPE']);
            double cash =
                list[0]["PAYTYPE"] == "Cash" ? list[0]["AMT"] : list[1]["AMT"];
            double card =
                list[0]["PAYTYPE"] == "Cash" ? list[1]["AMT"] : list[0]["AMT"];
            double total = cash + card;
            double numOfSales = list[2]["numofsales"];
            return Row(
              children: [
                InfoCard(
                  title: "TOTAL",
                  value: f.format(total),
                  isActive: false,
                  onTap: () {},
                  topColor: yellow,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "CASH",
                  value: f.format(cash),
                  isActive: false,
                  onTap: () {},
                  topColor: green,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "CARD",
                  value: f.format(card),
                  isActive: false,
                  onTap: () {},
                  topColor: pink,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "No. of Transactions",
                  value: numOfSales.toString(),
                  isActive: false,
                  onTap: () {},
                  topColor: blue,
                ),
              ],
            );
          }
          return Container(
            child: CustomText(
              text: "LOADING...",
              color: lightGray,
            ),
          );
        });
  }
}
