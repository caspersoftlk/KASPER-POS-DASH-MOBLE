import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';

class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;
  final IconData icon;
  const InfoCardSmall(
      {Key? key,
      required this.title,
      required this.value,
      required this.topColor,
      required this.isActive,
      required this.onTap,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(16),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: isActive ? active : lightGray),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: title,
                    size: 16,
                    weight: FontWeight.w300,
                    color: isActive ? active : lightGray,
                  ),
                ],
              ),
              CustomText(
                text: value,
                size: 16,
                weight: FontWeight.bold,
                color: topColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
