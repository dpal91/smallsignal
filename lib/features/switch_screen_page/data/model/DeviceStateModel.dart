class DeviceStateModel {
  final double voltage;
  final Map<String, bool> switches;

  DeviceStateModel({required this.voltage, required this.switches});

  factory DeviceStateModel.fromJson(Map<dynamic, dynamic> json) {
    return DeviceStateModel(
      voltage: (json["voltage"] ?? 0).toDouble(),
      switches: Map<String, bool>.from(json["switches"] ?? {}),
    );
  }
}
