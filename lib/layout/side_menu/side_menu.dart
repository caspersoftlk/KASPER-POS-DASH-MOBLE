import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasper_dash/constants/controllers.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';
import 'package:kasper_dash/helpers/responsiveness.dart';
import 'package:kasper_dash/layout/side_menu/side_menu_item.dart';
import 'package:kasper_dash/routing/route.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
        color: light,
        child: Column(children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _width / 48,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CustomText(text: "#betaWolf",),
                  ),
                  SizedBox(
                    width: _width / 48,
                  )
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Divider(color: lightGray.withOpacity(.1)),
            ]),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) {
                         // Get.back();
                          Navigator.of(context).pop();
                        }
                        navigationController.navigateTo(item.route);
                      }
                    }))
                .toList(),
          ),
        ]));
  }
}
