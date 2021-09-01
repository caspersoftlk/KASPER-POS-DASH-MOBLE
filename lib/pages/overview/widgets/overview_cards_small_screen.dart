import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:http/http.dart' as http;

import 'info_card_small.dart';

class OverViewCardSmallScreenSize extends StatelessWidget {
  const OverViewCardSmallScreenSize({Key? key, required this.map}) : super(key: key);

  final Map<String,dynamic> map;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    double total = map["total"];
    double cash = map["cash"];
    double other = map["other"];
    double nooftrans = map["nooftrans"];

    return Container(
              height: 250,
              child: Column(
                children: [
                  InfoCardSmall(
                    title: "Total Sale",
                    value: f.format(total),
                    isActive: false,
                    icon: Icons.paid,
                    onTap: () {},
                    topColor: Colors.orange,
                  ),
                  SizedBox(
                    height: _width / 64,
                  ),
                  InfoCardSmall(
                    title: "Cash",
                    value: f.format(cash),
                    icon: Icons.money,
                    isActive: false,
                    onTap: () {},
                    topColor: green,
                  ),
                  SizedBox(
                    height: _width / 64,
                  ),
                  InfoCardSmall(
                    title: "Other/Card",
                    value: f.format(other),
                    icon: Icons.credit_card,
                    isActive: false,
                    onTap: () {},
                    topColor: green,
                  ),
                  SizedBox(
                    height: _width / 64,
                  ),
                  InfoCardSmall(
                    title: "No. of Transactions",
                    value: nooftrans.toString(),
                    icon: Icons.countertops,
                    isActive: false,
                    onTap: () {},
                    topColor: green,
                  ),
                ],
              ),
            );
  }
}
