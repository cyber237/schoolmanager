import 'package:connectivity/connectivity.dart';
import 'connectivity_status.dart';
import 'dart:async';

class NetworkConnectivity {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      new StreamController<ConnectivityStatus>();
  NetworkConnectivity() {
    // Subscribe to the connectivity Chanaged Steam
    new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t
      // if (connectionStatusController.isClosed) {
      //   connectionStatusController = new StreamController<ConnectivityStatus>();
      // }
      connectionStatusController.add(_getStatusFromResult(result));
    }).onDone(() {});
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<bool> checkOnlineStatus() async {
    ConnectivityStatus r;
    await new Connectivity().checkConnectivity().then((value) {
      r = _getStatusFromResult(value);
      return null;
    });
    return (r == ConnectivityStatus.Cellular || r == ConnectivityStatus.Wifi)
        ? true
        : false;
  }
}
