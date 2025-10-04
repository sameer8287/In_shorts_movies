import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityProvider extends ChangeNotifier {
  /// Indicates whether the device has an active internet connection
  bool _isInternetAvailable = false;

  /// Getter to check if the internet is available
  bool get isInternetAvailable => _isInternetAvailable;

  /// Subscription for connectivity status changes
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  /// List maintaining the current connectivity status
  List<ConnectivityResult> _connectionStatusList = [];

  /// Instance of Connectivity to check network status
  late Connectivity _connectivity;

  /// Constructor initializes connectivity monitoring
  InternetConnectivityProvider() {
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initConnectivity();
  }

  /// Updates the internet connection status based on network changes
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // Maintain the list of connectivity results
    _connectionStatusList = result;

    // Check if there is any active connection
    bool isConnected = result.any((e) => e != ConnectivityResult.none);

    // Perform an actual internet check
    if (isConnected) {
      isConnected = await _checkInternetConnection();
    }

    // Update the internet status
    _updateInternetStatus(isConnected);
  }

  /// Initializes connectivity status on startup
  Future<void> _initConnectivity() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      await _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      debugPrint("Couldn't check connectivity status: $e");
    }
  }

  /// Checks if the device can access the internet
  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Updates the internet status and notifies listeners
  void _updateInternetStatus(bool status) {
    if (_isInternetAvailable != status) {
      _isInternetAvailable = status;
      notifyListeners();
    }
  }

  /// Getter for the list of connectivity results (read-only)
  List<ConnectivityResult> get connectionStatusList => List.unmodifiable(_connectionStatusList);

  /// Cancels connectivity subscription on dispose
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
