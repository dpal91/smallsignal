class SavedDevices {
  final String deviecName;
  final String deviecID;

  SavedDevices({required this.deviecName, required this.deviecID});

  String getDeviceName() => deviecName;

  factory SavedDevices.fromJson(Map<String, dynamic> json) {
    return SavedDevices(
      deviecName: json['deviecName'] as String,
      deviecID: json['deviecID'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'deviecName': deviecName, 'deviecID': deviecID};
  }
}
