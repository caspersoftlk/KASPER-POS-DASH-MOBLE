import 'package:flutter/material.dart';
import 'package:kasper_dash/helpers/responsiveness.dart';
import 'package:kasper_dash/layout/side_menu/side_menu.dart';
import 'package:kasper_dash/layout/small_screen.dart';
import 'package:kasper_dash/layout/widgets/top_navbar.dart';

import 'large_screen.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> refKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: refKey,
      appBar: topNavigationBar(context, refKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargerScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
