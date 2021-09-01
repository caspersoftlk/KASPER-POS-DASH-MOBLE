import 'package:flutter/cupertino.dart';
import 'package:kasper_dash/constants/controllers.dart';
import 'package:kasper_dash/routing/route.dart';
import 'package:kasper_dash/routing/router.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: OverViewPageRoute,
      onGenerateRoute: generateRoute,
    );
