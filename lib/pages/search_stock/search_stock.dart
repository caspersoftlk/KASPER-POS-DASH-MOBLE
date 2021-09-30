import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:kasper_dash/helpers/custom_text.dart';
import 'package:kasper_dash/pages/overview/widgets/info_card_small.dart';
import 'package:provider/provider.dart';

import 'package:kasper_dash/constants/constants.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/pages/overview/widgets/medile_smallScreen.dart';
import 'package:kasper_dash/pages/overview/widgets/overview_cards_small_screen.dart';
import 'package:kasper_dash/pages/overview/widgets/sub_deparment_sale.dart';
import 'package:kasper_dash/pages/overview/widgets/total_sale.dart';
import 'package:kasper_dash/pages/overview/widgets/weekly_sales.dart';
import 'package:kasper_dash/provider/server.dart';

class SearchStock extends StatefulWidget {
  SearchStock({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<SearchStock> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _from = TextEditingController();

  TextEditingController _to = TextEditingController();

  String status = "uninitialized";
  String barcodeScanRes = "";

  late ReorderItem? record = null;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    searchController.text = barcodeScanRes;
    _openDropDownProgKey.currentState?.openDropDownSearch();
  }

  final _openDropDownProgKey = GlobalKey<DropdownSearchState<ReorderItem>>();
  final TextEditingController searchController = TextEditingController();
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
                      DropdownSearch<ReorderItem>(
                        key: _openDropDownProgKey,
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        autoFocusSearchBox: true,
                        searchBoxController: searchController,
                        label: "Search Item",
                        onFind: (String filter) async {
                          http.Response res = await http.get(
                              Uri.parse(
                                  'http://${provider.serverip}/getitemstockusingbarcode?did=123&bc=$filter'),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type":
                                    "application/x-www-form-urlencoded",
                                "Access-Control-Allow-Origin": "*"
                              });
                          //print(res.body);
                          var models = ReorderItem.fromJsonList(
                              jsonDecode(res.body)["list"]);
                          return models!;
                        },
                        onChanged: (ReorderItem? data) {
                          setState(() {
                            record = data;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary: pink),
                            label: CustomText(
                              text: "Scan Barcode",
                              color: Colors.white,
                            ),
                            onPressed: () => scanBarcodeNormal(),
                            icon: Icon(Icons.camera)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]))),
            SizedBox(
              height: 16,
            ),
            if (record != null)
              Container(
                  height: 300,
                  child: Column(
                    children: [
                      InfoCardSmall(
                          title: "BarCode",
                          value: record!.ITMBARCODE,
                          topColor: green,
                          isActive: false,
                          onTap: () {},
                          icon: Icons.tag),
                      SizedBox(
                        height: 10,
                      ),
                      InfoCardSmall(
                          title: "Selling Price",
                          value: f.format(record!.IMLREORDERQTY),
                          topColor: green,
                          isActive: false,
                          onTap: () {},
                          icon: Icons.money),
                      SizedBox(
                        height: 10,
                      ),
                      InfoCardSmall(
                          title: "SIH",
                          value: f.format(record!.IMLSHELF),
                          topColor: green,
                          isActive: false,
                          onTap: () {},
                          icon: Icons.event_available),
                      SizedBox(
                        height: 10,
                      ),
                      InfoCardSmall(
                          title: "Status",
                          value: record!.IMLREORDERLEVEL == 1
                              ? "Active"
                              : "Deactive",
                          topColor: record!.IMLREORDERLEVEL == 1 ? green : pink,
                          isActive: false,
                          onTap: () {},
                          icon: Icons.check),
                    ],
                  ))
          ],
        ))
      ],
    );
  }
}

class ReorderItem {
  final String ITMCODE;
  final String ITMDESCRIPTION;
  final String ITMBARCODE;
  final double IMLSHELF;
  final double IMLREORDERLEVEL;
  final double IMLREORDERQTY;
  ReorderItem({
    required this.ITMCODE,
    required this.ITMDESCRIPTION,
    required this.ITMBARCODE,
    required this.IMLSHELF,
    required this.IMLREORDERLEVEL,
    required this.IMLREORDERQTY,
  });

  static List<ReorderItem>? fromJsonList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((item) => ReorderItem.fromMap(item)).toList();
  }

  ReorderItem copyWith({
    String? ITMCODE,
    String? ITMDESCRIPTION,
    String? ITMBARCODE,
    double? IMLSHELF,
    double? IMLREORDERLEVEL,
    double? IMLREORDERQTY,
  }) {
    return ReorderItem(
      ITMCODE: ITMCODE ?? this.ITMCODE,
      ITMDESCRIPTION: ITMDESCRIPTION ?? this.ITMDESCRIPTION,
      ITMBARCODE: ITMBARCODE ?? this.ITMBARCODE,
      IMLSHELF: IMLSHELF ?? this.IMLSHELF,
      IMLREORDERLEVEL: IMLREORDERLEVEL ?? this.IMLREORDERLEVEL,
      IMLREORDERQTY: IMLREORDERQTY ?? this.IMLREORDERQTY,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ITMCODE': ITMCODE,
      'ITMDESCRIPTION': ITMDESCRIPTION,
      'ITMBARCODE': ITMBARCODE,
      'IMLSHELF': IMLSHELF,
      'IMLREORDERLEVEL': IMLREORDERLEVEL,
      'IMLREORDERQTY': IMLREORDERQTY,
    };
  }

  factory ReorderItem.fromMap(Map<String, dynamic> map) {
    return ReorderItem(
      ITMCODE: map['ITMCODE'],
      ITMDESCRIPTION: map['ITMDESCRIPTION'],
      ITMBARCODE: map['ITMBARCODE'],
      IMLSHELF: map['IMLSHELF'],
      IMLREORDERLEVEL: map['IMLREORDERLEVEL'],
      IMLREORDERQTY: map['IMLREORDERQTY'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReorderItem.fromJson(String source) =>
      ReorderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return '$ITMDESCRIPTION $ITMBARCODE';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReorderItem &&
        other.ITMCODE == ITMCODE &&
        other.ITMDESCRIPTION == ITMDESCRIPTION &&
        other.ITMBARCODE == ITMBARCODE &&
        other.IMLSHELF == IMLSHELF &&
        other.IMLREORDERLEVEL == IMLREORDERLEVEL &&
        other.IMLREORDERQTY == IMLREORDERQTY;
  }

  @override
  int get hashCode {
    return ITMCODE.hashCode ^
        ITMDESCRIPTION.hashCode ^
        ITMBARCODE.hashCode ^
        IMLSHELF.hashCode ^
        IMLREORDERLEVEL.hashCode ^
        IMLREORDERQTY.hashCode;
  }
}
