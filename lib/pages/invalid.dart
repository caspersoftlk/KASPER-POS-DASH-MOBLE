import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/style.dart';
import 'package:kasper_dash/helpers/custom_text.dart';
import 'package:kasper_dash/provider/server.dart';
import 'package:provider/provider.dart';

class InvalidDevice extends StatelessWidget {
  const InvalidDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServerProvider provider = Provider.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            CustomText(text: "INVALID DEVICE",color: pink,weight: FontWeight.bold,),
            SizedBox(height: 10,),
            Flexible(child: CustomText(text: "Please contact system administrator to activate your new device",color: pink)),
            SizedBox(height: 10,),
            CustomText(text: "Your device id : ${provider.deviceid}",color: pink,weight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }
}
