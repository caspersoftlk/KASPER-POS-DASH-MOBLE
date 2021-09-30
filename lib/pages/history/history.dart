import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/pages/overview/widgets/medile_smallScreen.dart';
import 'package:kasper_dash/pages/overview/widgets/overview_cards_small_screen.dart';
import 'package:kasper_dash/pages/overview/widgets/sub_deparment_sale.dart';
import 'package:kasper_dash/pages/overview/widgets/total_sale.dart';
import 'package:kasper_dash/pages/overview/widgets/weekly_sales.dart';
import 'package:kasper_dash/provider/server.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _from = TextEditingController();

  TextEditingController _to = TextEditingController();

  String status = "uninitialized";

  late Map<String, dynamic>? map = null;

  @override
  Widget build(BuildContext context) {
    ServerProvider provider = Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Expanded(
            child: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Select date period",
                          style: TextStyle(fontSize: 12, color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Date';
                          }
                          return null;
                        },
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010, 1),
                              lastDate: DateTime(2030, 12),
                              builder: (context, picker) {
                                return Theme(
                                  //TODO: change colors
                                  data: ThemeData.light(),
                                  child: picker!,
                                );
                              }).then((selectedDate) {
                            if (selectedDate != null) {
                              _from.text = dateformat.format(selectedDate);
                            }
                          });
                        },
                        readOnly: true,
                        controller: _from,
                        decoration: InputDecoration(
                            labelText: 'From :',
                            suffixIcon: Icon(
                              Icons.list_alt_sharp,
                              size: 19,
                            ),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Date';
                          }
                          return null;
                        },
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010, 1),
                              lastDate: DateTime(2030, 12),
                              builder: (context, picker) {
                                return Theme(
                                  //TODO: change colors
                                  data: ThemeData.light(),
                                  child: picker!,
                                );
                              }).then((selectedDate) {
                            if (selectedDate != null) {
                              _to.text = dateformat.format(selectedDate);
                            }
                          });
                        },
                        readOnly: true,
                        controller: _to,
                        decoration: InputDecoration(
                            labelText: 'To :',
                            suffixIcon: Icon(
                              Icons.list_alt_sharp,
                              size: 19,
                            ),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    map = null;
                                    status = "uninitialized";
                                    _from.text = "";
                                    _to.text = "";
                                  });
                                },
                                child: Text("Clear",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white))),
                            ElevatedButton.icon(
                              icon: Icon(Icons.search),
                              style: ElevatedButton.styleFrom(primary: green),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      map = null;
                                      status = "loading";
                                    });
                                    print("Request res");
                                    http.Response res = await http.get(
                                        Uri.parse(
                                            'http://${provider.serverip}/sales?did=123&fromDate=${_from.text}&toDate=${_to.text}'),
                                        headers: {
                                          "Accept": "application/json",
                                          "Content-Type":
                                              "application/x-www-form-urlencoded",
                                          "Access-Control-Allow-Origin": "*"
                                        });
                                    if (res.body.isEmpty) {
                                      print("Empty res");
                                    } else {
                                      print(res.body);
                                      setState(() {
                                        status = "success";
                                        map = jsonDecode(res.body);
                                      });
                                    }
                                  }
                                },
                                label: Text("Search",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white))),
                          ])
                    ]))),
            SizedBox(
              height: 16,
            ),
            if (status == "loading") LinearProgressIndicator(),
            if (map != null)
              OverViewCardSmallScreenSize(
                map: map!["salesSum"],
              ),
            SizedBox(
              height: 16,
            ),
            if (map != null)
              WeeklySales(snapshot: map!["lineChart2"]),
            SizedBox(
              height: 16,
            ),
            if (map != null)
            MidleWidgeSmallScreen(map: map!["lineChart"]),
            SizedBox(
              height: 16,
            ),
            if (map != null)
            SubDepartmentSales(map: map!["subCatSales"])
          ],
        ))
      ],
    );
  }
}
