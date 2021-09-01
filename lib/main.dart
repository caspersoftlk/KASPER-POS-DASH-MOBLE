import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasper_dash/layout/layout.dart';
import 'package:kasper_dash/pages/invalid.dart';
import 'package:kasper_dash/provider/server.dart';
import 'package:provider/provider.dart';

import 'constants/controllers.dart';
import 'constants/style.dart';
import 'controllers/menu_controller.dart';
import 'controllers/navigation_controller.dart';
import 'helpers/custom_text.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  Get.put(MenuController());
  Get.put(NavigationController());
 // runApp(Phoenix(child: MyApp()));
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: ServerProvider.init())],
    child: Phoenix(child: MyApp()),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          primaryColor: green),
      home: SiteController(),
    );
  }
}

class SiteController extends StatelessWidget {
  const SiteController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServerProvider provider = Provider.of(context);
    try{
      switch (provider.status){
        case Status.Uninitialized:
          return Loading();
        case Status.Authenticated:
          return SiteLayout();
        case Status.InvalidDID:
          return InvalidDevice();
        default:
          return Loading();
      }
    }catch (e){
      return Loading();
    }
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: 'Loading..'),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(16),
                  child: LinearProgressIndicator(
                    color: green,
                    backgroundColor: green.withOpacity(0.2),
                  ))
            ],
          ),
        ));
  }
}

