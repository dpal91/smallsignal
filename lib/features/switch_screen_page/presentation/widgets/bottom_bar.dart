import 'package:flutter/material.dart';

Widget buildBottomBar() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _bottomButton(Icons.power_settings_new, "All On"),
        _bottomButton(Icons.timer_outlined, "Timer"),
        _bottomButton(Icons.settings_outlined, "Setting"),
        _bottomButton(Icons.power_off, "All Off"),
      ],
    ),
  );
}

Widget _bottomButton(IconData icon, String title) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(radius: 32, child: Icon(icon)),
      const SizedBox(height: 8),
      Text(title, style: const TextStyle(color: Colors.white)),
    ],
  );
}
