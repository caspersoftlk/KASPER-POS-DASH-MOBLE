import 'package:flutter/material.dart';
import 'package:kasper_dash/pages/history/history.dart';
import 'package:kasper_dash/pages/overview/overview.dart';
import 'package:kasper_dash/pages/reorder/reorder.dart';
import 'package:kasper_dash/pages/search_stock/search_stock.dart';
import 'package:kasper_dash/routing/route.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  switch (setting.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverViewPage());
    case ReorderPageRoute:
      return _getPageRoute(ReOrder());
    case SalesDetailPageRoute:
      return _getPageRoute(HistoryPage());
    case SearchItemPageRoute:
      return _getPageRoute(SearchStock());
    default:
      return _getPageRoute(OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
