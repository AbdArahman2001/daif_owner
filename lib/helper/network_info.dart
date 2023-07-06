import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:flutter/material.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void checkConnectivity() {
    log("-------------------checking connectivity");
    bool firstTime = true;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!firstTime) {
        bool isNotConnected;
        if (result == ConnectivityResult.none) {
          isNotConnected = true;
        } else {
          isNotConnected = !await _updateConnectivityStatus();
        }
        isNotConnected
            ? CustomSnackBar.instance
                .showCustomSnackBar(title: "connected", message: "connected")
            : CustomSnackBar.instance.showCustomErrorSnackBar(
                title: "connectivity", message: "no_connection");
      }
      firstTime = false;
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }
}
