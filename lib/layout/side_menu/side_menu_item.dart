import 'package:flutter/material.dart';
import 'package:kasper_dash/helpers/responsiveness.dart';

import 'menu_item_h.dart';
import 'menu_item_v.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.osCustomeScreen(context))
      return VerticleMenuItem(itemName: itemName, onTap: onTap);

    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
