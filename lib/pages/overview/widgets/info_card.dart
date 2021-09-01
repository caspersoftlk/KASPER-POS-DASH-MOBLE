import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasper_dash/constants/style.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? topColor;
  final bool isActive;
  final VoidCallback onTap;

  const InfoCard(
      {Key? key,
      required this.title,
      required this.value,
      this.topColor,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                color: lightGray.withOpacity(.1),
                blurRadius: 12,
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 6,
                      color: topColor ?? active,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "$title\n",
                      style: TextStyle(
                          fontSize: 16, color: isActive ? active : lightGray)),
                  TextSpan(
                      text: "$value",
                      style: TextStyle(
                          fontSize: 40, color: isActive ? active : dark))
                ]),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
