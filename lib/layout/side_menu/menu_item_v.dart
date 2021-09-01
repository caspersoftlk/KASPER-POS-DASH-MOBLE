import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kasper_dash/constants/controllers.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class VerticleMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const VerticleMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHover(itemName)
                ? lightGray.withOpacity(.1)
                : Colors.transparent,
            child: Row(children: [
              Visibility(
                visible: menuController.isHover(itemName) ||
                    menuController.isActive(itemName),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  width: 3,
                  height: 72,
                  color: dark,
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: menuController.returnIconFor(itemName),
                  ),
                  if (!menuController.isActive(itemName))
                    Flexible(
                        child: CustomText(
                      text: itemName,
                      color:
                          menuController.isHover(itemName) ? dark : lightGray,
                    ))
                  else
                    Flexible(
                        child: CustomText(
                      text: itemName,
                      color: dark,
                      size: 14,
                      weight: FontWeight.bold,
                    ))
                ],
              ))
            ]),
          )),
    );
  }
}
