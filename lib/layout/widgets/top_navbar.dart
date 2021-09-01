import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

import 'package:kasper_dash/helpers/responsiveness.dart';

AppBar topNavigationBar(
        BuildContext context, GlobalKey<ScaffoldState> refKey) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Image.asset(
                    'assets/icons/getpaidlogo.png',
                    width: 28,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                refKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          !ResponsiveWidget.isSmallScreen(context)
              ? Visibility(
                  child: CustomText(
                  text: "LiveAdmin",
                  color: Colors.white,
                  size: 20,
                  weight: FontWeight.w500,
                ))
              : Visibility(
                  child: CustomText(
                  text: "KS",
                  color: Colors.white,
                  size: 17,
                  weight: FontWeight.w500,
                )),
          Expanded(
            child: Container(),
          ),
          IconButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 1,
            height: 22,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          CustomText(
            text: "Admin",
            color: Colors.white,
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                    backgroundColor: green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ))),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: green,
    );
