import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class SubDepartmentSales extends StatelessWidget {
  const SubDepartmentSales({Key? key, required this.map}) : super(key: key);

  final List<dynamic> map;

  List<DataRow> _buildList(BuildContext context, List<dynamic> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, dynamic data) {
    final Map<String, dynamic> map = data;

    return DataRow(cells: [
      DataCell(CustomText(
        text: map['cat'],
        color: dark,
        size: 10,
      )),
      DataCell(CustomText(
        text: map['noOfItems'].toString(),
        color: dark,
        size: 10,
      )),
      DataCell(CustomText(
        text: f.format(map['saleValue']),
        color: dark,
        size: 10,
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 30),
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
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: "Category wise ",
                    color: lightGray,
                    weight: FontWeight.bold,
                    size: 12,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns: [
                        DataColumn(
                          label: CustomText(
                              text: "SUB Department", color: dark, size: 11),
                        ),
                        DataColumn(
                          numeric: true,
                          label: CustomText(
                            text: "No. Of Items",
                            size: 11,
                            color: dark,
                          ),
                        ),
                        DataColumn(
                          numeric: true,
                          label: CustomText(
                            text: "Value",
                            size: 11,
                            color: dark,
                          ),
                        ),
                      ],
                      rows: _buildList(context, map),
              ),
                ),
          ),
        ]));
  }
}
