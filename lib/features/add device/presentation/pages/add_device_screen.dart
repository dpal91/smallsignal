import 'package:flutter/material.dart';
import 'package:room_automation/features/add%20device/presentation/widget/device_found.dart';
import 'package:room_automation/features/add%20device/presentation/widget/wifi_scanner.dart';
import 'package:room_automation/features/add%20device/presentation/widget/wifi_warning.dart';

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Add Device",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              const Text(
                "Searching for nearby devices...",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 10),

              const Text(
                "Make sure the device is powered on and in pairing mode",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 30),

              // WiFi Warning Card
              WiFi_Warning(),

              const SizedBox(height: 40),

              WifiScannerScreen(),
              const SizedBox(height: 40),

              // Device Found
              DeviceCard(),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(text: "Devices will be added automatically. "),
                      // TextSpan(
                      //   text: "Cancel (18)",
                      //   style: TextStyle(color: Colors.red),
                      // ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Divider(color: Colors.grey.shade300),

              // const SizedBox(height: 20),

              // Row(
              //   children: [
              //     const Expanded(
              //       child: Text(
              //         "Add Manually",
              //         style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),

              //     Container(
              //       width: 180,
              //       height: 50,
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       decoration: BoxDecoration(
              //         color: const Color(0xfff5f5f5),
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       child: Row(
              //         children: const [
              //           Icon(Icons.search, color: Colors.grey),
              //           SizedBox(width: 10),
              //           Text(
              //             "Search for a category",
              //             style: TextStyle(color: Colors.black87),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 35),

              // const Text(
              //   "Electrical",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              // ),

              // const SizedBox(height: 20),

              // Wrap(
              //   spacing: 20,
              //   runSpacing: 20,
              //   children: [
              //     _categoryTile(Icons.power, "Socket"),
              //     _categoryTile(Icons.lightbulb_outline, "Light"),
              //     _categoryTile(Icons.toggle_on, "Switch"),
              //     _categoryTile(Icons.electrical_services, "Breaker"),
              //   ],
              // ),

              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(color: Colors.grey, fontSize: 16),
            children: [TextSpan(text: "Devices will be added automatically.")],
          ),
        ),
      ),
    );
  }

  Widget _categoryTile(IconData icon, String title) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xfff5f5f5),
            child: Icon(icon, size: 30, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}
