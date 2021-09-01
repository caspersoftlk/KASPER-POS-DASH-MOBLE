import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kasper_dash/controllers/menu_controller.dart';
import 'package:kasper_dash/controllers/navigation_controller.dart';

MenuController menuController = MenuController.instance;
NavigationController navigationController = NavigationController.instance;

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore store = FirebaseFirestore.instance;