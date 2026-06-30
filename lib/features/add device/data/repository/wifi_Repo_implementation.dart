import 'package:flutter/services.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_repository.dart';
import 'package:app_settings/app_settings.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiRepositoryImpl implements WifiRepository {
  final LocalStorageService localStorageService;
  static const MethodChannel _channel = MethodChannel('wifi_state');

  WifiRepositoryImpl(this.localStorageService);

  @override
  Future<bool> isWifiEnabled() async {
    return await _channel.invokeMethod<bool>('isWifiEnabled') ?? false;
  }

  @override
  Future<void> openWifiSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.wifi);
  }

  @override
  Future<List<String>> scanDevices(searchAllWiFi) async {
    final canStartScan = await WiFiScan.instance.canStartScan();
    final bool allWifi = searchAllWiFi;

    if (canStartScan != CanStartScan.yes) {
      throw Exception("WiFi scan permission not granted");
    }

    await WiFiScan.instance.startScan();

    await Future.delayed(const Duration(seconds: 4));

    final results = await WiFiScan.instance.getScannedResults();

    return results
        .map((e) => e.ssid)
        // .where((e) => e.isNotEmpty)
        .where((ssid) {
          if (ssid.isEmpty) return false;
          return allWifi || ssid.toLowerCase().contains("home test");
        })
        .toSet()
        .toList();
  }

  @override
  Future<bool> connectToDevice(String ssid) async {
    try {
      return await WiFiForIoTPlugin.connect(
        ssid,
        security: NetworkSecurity.NONE,
        joinOnce: true,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> scanHomeWifiNetworks() async {
    return await scanDevices(true);
  }

  @override
  Future<void> sendWifiCredentials(String ssid, String password) async {
    // await http.post(
    //   Uri.parse(
    //     "http://192.168.4.1/configure",
    //   ),
    //   body: {
    //     "ssid": ssid,
    //     "password": password,
    //   },
    // );
    await Future.delayed(Duration(seconds: 1));
  }
}

// @override
// Future<void> sendWifiCredentials(String ssid, String password) async {
  // await http.post(
  //   Uri.parse(
  //     "http://192.168.4.1/configure",
  //   ),
  //   body: {
  //     "ssid": ssid,
  //     "password": password,
  //   },
  // );
  // await Future.delayed(Duration(seconds: 1));
// }

// Future<void> sendWifiCredentials(
//   String ssid,
//   String password,
// ) async {

//   final socket =
//       await Socket.connect(
//         "192.168.4.1",
//         5000,
//       );

//   socket.write(
//     jsonEncode({
//       "ssid": ssid,
//       "password": password,
//     }),
//   );

//   await socket.flush();
//   await socket.close();
// }
