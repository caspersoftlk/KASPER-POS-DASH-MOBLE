import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';
import 'package:kasper_dash/helpers/responsiveness.dart';
import 'package:kasper_dash/pages/overview/widgets/overview_cards_large_screen.dart';
import 'package:kasper_dash/pages/overview/widgets/overview_cards_small_screen.dart';
import 'package:kasper_dash/pages/overview/widgets/sub_deparment_sale.dart';
import 'package:kasper_dash/pages/overview/widgets/total_sale.dart';
import 'package:kasper_dash/provider/server.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

import 'widgets/medile_largeScreen.dart';
import 'widgets/medile_smallScreen.dart';
import 'widgets/overview_cards_medium_screen.dart';
import 'package:http/http.dart' as http;

class OverViewPage extends StatelessWidget {
  OverViewPage({Key? key}) : super(key: key);

  late int s = 1;

  Stream<http.Response> productsStream(String serverip) async* {
    while (true) {
      await Future.delayed(Duration(seconds: s));
      s = 15;
      http.Response res = await http.get(
          Uri.parse('http://${serverip}/FlexPosMobileAdminAPI/livesales?did=123'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*"
          });
      yield res;
    }
  }



  @override
  Widget build(BuildContext context) {
    ServerProvider provider = Provider.of(context);
    return StreamBuilder<http.Response>(
        stream: productsStream(provider.serverip!),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return CustomText(text: snapshot.error.toString());
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return  Column(
              children: [
                SizedBox(height: 20,),
                CustomText(text: "Loading.."),
                SizedBox(height: 10,),
                LinearProgressIndicator(),
              ],
            );
          }else if(snapshot.connectionState == ConnectionState.active){
          print("call");
          Map<String,dynamic> map = jsonDecode(snapshot.data!.body);
          return Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView(
                    children: [
                        OverViewCardSmallScreenSize(map: map["salesSum"],),
                      SizedBox(
                        height: 16,
                      ),
                      TotalSales(snapshot: map["lineChart2"]),
                      SizedBox(
                        height: 16,
                      ),
                        MidleWidgeSmallScreen(map: map["lineChart"]),
                      SizedBox(
                        height: 16,
                      ),
                      SubDepartmentSales(map: map["subCatSales"])
                    ],
                  ))
            ],
          );
        }else{
            return Container(

            );
          }});
  }
}
