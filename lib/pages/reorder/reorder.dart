import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kasper_dash/helpers/custom_text.dart';
import 'package:kasper_dash/pages/reorder/reorderTable.dart';
import 'package:kasper_dash/provider/server.dart';
import 'package:provider/provider.dart';

class ReOrder extends StatefulWidget {
  @override
  _ReOrderState createState() => _ReOrderState();
}

class _ReOrderState extends State<ReOrder> {
  Future<http.Response> getStream() async {
    return await http.get(
        Uri.parse(
            'http://$serveripx/FlexPosMobileAdminAPI/reorderitems?did=123'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Access-Control-Allow-Origin": "*"
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: getStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomText(text: snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomText(text: "Loading.."),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(),
            ],
          );
        } else {
          Map<String, dynamic> map = jsonDecode(snapshot.data!.body);
          return ReOrderItems(map: map["list"]);
        }
      },
    );
  }
}
