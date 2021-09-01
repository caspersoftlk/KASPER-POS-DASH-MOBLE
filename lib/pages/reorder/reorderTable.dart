import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class ReOrderItems extends StatelessWidget {
  const ReOrderItems({Key? key, required this.map}) : super(key: key);

  final List<dynamic> map;

  List<DataRow> _buildList(BuildContext context, List<dynamic> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, dynamic data) {
    final Map<String, dynamic> map = data;

    return DataRow(cells: [
      DataCell(CustomText(
        text: map['ITMDESCRIPTION'],
        color: dark,
        size: 10,
      )),
      DataCell(CustomText(
        text: f.format(map['IMLSHELF']),
        color: dark,
        size: 10,
      )),
      DataCell(CustomText(
        text: f.format(map['IMLREORDERLEVEL']),
        color: dark,
        size: 10,
      )),
      DataCell(CustomText(
        text: f.format(map['IMLREORDERQTY']),
        color: dark,
        size: 10,
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    int _currentSortColumn = 0;
    bool _isAscending = true;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          margin: EdgeInsets.only(bottom: 30, top: 20),
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGray.withOpacity(.1),
                    blurRadius: 12)
              ]),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.blue,
                    ),
                    CustomText(
                      text: "Re Order Items : " + map.length.toString(),
                      color: blue,
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn2(
                          label: CustomText(
                              text: "DESCRIPTION", color: dark, size: 11),
                        ),
                        DataColumn(
                          numeric: true,
                          label: CustomText(
                            text: "SIH",
                            size: 11,
                            color: dark,
                          ),
                        ),
                        DataColumn(
                          numeric: true,
                          label: CustomText(
                            text: "RO-LEVEL",
                            size: 11,
                            color: dark,
                          ),
                        ),
                        DataColumn(
                          numeric: true,
                          label: CustomText(
                            text: "RO-QTY",
                            size: 11,
                            color: dark,
                          ),
                        ),
                      ],
                      rows: _buildList(context, map),
                    ),
                  ),
                ),
              ])),
    );
  }
}
