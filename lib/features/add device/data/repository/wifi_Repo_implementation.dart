import 'package:flutter/services.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_repository.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:app_settings/app_settings.dart';

class WifiRepositoryImpl implements WifiRepository {
  static const MethodChannel _channel = MethodChannel('wifi_state');
  @override
  Future<bool> isWifiEnabled() async {
    // final result = await Connectivity().checkConnectivity();
    // print(result.toList());
    // return result.contains(ConnectivityResult.wifi);
     

 return await _channel.invokeMethod<bool>('isWifiEnabled') ?? false;
  }

  @override
  Future<void> enableWifi() async {
    await AppSettings.openAppSettings(type: AppSettingsType.wifi);
  }

  @override
  Future<Map<String, dynamic>> scanDevices() async {
    final canStartScan = await WiFiScan.instance.canStartScan();

    if (canStartScan != CanStartScan.yes) {
      return {"canScan": false, "devices": []};
    }

    await WiFiScan.instance.startScan();

    // Give Android a moment to complete the scan
    await Future.delayed(const Duration(seconds: 2));

    final results = await WiFiScan.instance.getScannedResults();

    var list = results
        .map((network) => network.ssid)
        .where((ssid) => ssid.isNotEmpty)
        .toList();
    return {"canScan": true, "devices": list};
  }
}
