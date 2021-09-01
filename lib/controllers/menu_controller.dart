import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/routing/route.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = OverViewDisplyName.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHover(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case OverViewDisplyName:
        return _customIcon(itemName, Icons.trending_up);
      case ReorderDisplyName:
        return _customIcon(itemName, Icons.add_shopping_cart);
      case SalesDetailDisplayName:
        return _customIcon(itemName, Icons.history);
      case SearchItemDisplayName:
        return _customIcon(itemName, Icons.search);
      default:
        return _customIcon(itemName, Icons.exit_to_app);
    }
  }

  Widget _customIcon(String itemName, IconData icon) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    return Icon(icon, color: isHover(itemName) ? dark : lightGray);
  }
}
