import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasper_dash/constants/controllers.dart';
import 'package:platform_device_id/platform_device_id.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  InvalidDID,
}

String serveripx = "";

class ServerProvider with ChangeNotifier {
  late String? _serverIp;
  late String? _deviceid;
  Status _statusx = Status.Uninitialized;
  String? get serverip => _serverIp;
  String? get deviceid => _deviceid;
  Status get status => _statusx;

  final String collection = "kasper-dash-init";

  ServerProvider.init() {
    InitializeServer();
  }

  InitializeServer() async {
    print("init server");
    _statusx = Status.Authenticating;
    _deviceid = await PlatformDeviceId.getDeviceId;
    store.collection(collection).doc("checkfields").get().then((value) {
      if (!value.exists) {
        _statusx = Status.InvalidDID;
        print("document not exist");
        notifyListeners();
      } else {
        if (value.get("devices").toString().contains(_deviceid!)) {
          _statusx = Status.Authenticated;
          serveripx = value.get("server");
          _serverIp = value.get("server");
          print("Auth");
          notifyListeners();
        } else {
          _statusx = Status.InvalidDID;
          print("Invalid ID");
          notifyListeners();
        }
      }
    });
  }
}
