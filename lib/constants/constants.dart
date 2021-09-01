import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String ip = '192.168.8.132';

final dateformat = new DateFormat('dd-MM-yyyy');
final dateTimeformat = new DateFormat('dd-MM-yyyy hh:mm:ss');
final key = '7Kdp5kcQqQ4E6iWoADde';
var f = NumberFormat("###,###.00", "en_US");
var df = new DateFormat('yyyy-MM-dd');
var tf = new DateFormat('hh:mm:ss');

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

//FIND MAX AND MIN IN MAP
double getMaxXval(
    BuildContext context, List<dynamic> snapshot, String x, String y) {
  List<Map<String, dynamic>> mapList =
      snapshot.map((data) => getMap(context, data, x, y)).toList();
  mapList.sort((a, b) => a[x].compareTo(b[x]));
  return double.parse(mapList.last[x].toString());
}

double getMaxYval(
    BuildContext context, List<dynamic> snapshot, String x, String y) {
  List<Map<String, dynamic>> mapList =
      snapshot.map((data) => getMap(context, data, x, y)).toList();
  mapList.sort((a, b) => a[y].compareTo(b[y]));
  return double.parse(mapList.last[y].toString());
}

Map<String, dynamic> getMap(
    BuildContext context, dynamic data, String x, String y) {
  final Map<String, dynamic> map = data;
  return map;
}
