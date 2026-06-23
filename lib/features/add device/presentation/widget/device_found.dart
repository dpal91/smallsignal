import 'package:flutter/material.dart';

Widget DeviceCard() {
  return Column(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.toggle_on, size: 40, color: Colors.grey),
          ),
        ),
      ),

      const SizedBox(height: 16),

      const Text(
        "4Node Smart\nSwitch",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black87),
      ),
    ],
  );
}
