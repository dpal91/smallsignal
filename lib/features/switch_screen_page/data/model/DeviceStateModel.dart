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

  factory DeviceStateModel.defaultState() {
    return DeviceStateModel(
      voltage: 0,
      switches: {
        "Switch 1": false,
        "Switch 2": false,
        "Switch 3": false,
        "Switch 4": false,
      },
    );
  }
}
