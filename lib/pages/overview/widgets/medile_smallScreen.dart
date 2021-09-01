import 'dart:convert';

import 'package:flutter/material.dart';

import 'medile_largeScreen.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:http/http.dart' as http;

class MidleWidgeSmallScreen extends StatelessWidget {
  const MidleWidgeSmallScreen({Key? key, required this.map}) : super(key: key);

  final List<dynamic> map;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child:
                      ValueBaseSales(snapshot: map),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TransactionViseSales(
                      snapshot: map),
                )
              ],
            ),
          );
  }
}
