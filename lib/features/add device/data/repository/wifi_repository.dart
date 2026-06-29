abstract class WifiRepository {
  Future<bool> isWifiEnabled();

  Future<void> enableWifi();

  Future<Map<String, dynamic>> scanDevices();
}
