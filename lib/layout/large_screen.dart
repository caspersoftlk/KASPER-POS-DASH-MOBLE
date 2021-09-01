import 'package:flutter/material.dart';
import 'package:kasper_dash/helpers/local_navigator.dart';
import 'package:kasper_dash/layout/side_menu/side_menu.dart';

class LargerScreen extends StatelessWidget {
  const LargerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideMenu(),
        ),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: localNavigator(),
            ))
      ],
    );
  }
}
