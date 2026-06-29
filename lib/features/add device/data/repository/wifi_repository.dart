abstract class WifiRepository {
  Future<bool> isWifiEnabled();

  Future<void> openWifiSettings();

  Future<List<String>> scanDevices(bool searchAllWiFi);

  Future<bool> connectToDevice(String ssid);

  Future<List<String>> scanHomeWifiNetworks();

  Future<void> sendWifiCredentials(String ssid, String password);
}
