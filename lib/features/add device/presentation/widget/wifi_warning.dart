import 'package:flutter/material.dart';

Widget WiFi_Warning() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xfff6f6f6),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Turn on Wi-Fi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                "Wi-Fi is required to search for devices.",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),

        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xffe5e5e5),
              child: Icon(Icons.wifi, color: Colors.grey),
            ),

            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    "!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
