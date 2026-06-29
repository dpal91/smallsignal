import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/add%20device/data/bloc/add_device_bloc.dart';
import 'package:room_automation/features/add%20device/presentation/widget/device_found.dart';
import 'package:room_automation/features/add%20device/presentation/widget/wifi_scanner.dart';
import 'package:room_automation/features/device_home_page/presentation/device_home_screen.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _refreshDevices() async {
    final bloc = context.read<AddDeviceBloc>();

    if (bloc.state.status == WifiStatus.disabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enable WiFi first")));
      return;
    }
    bloc.add(ClearDevices());
    bloc.add(StartWifiScan(false));

    // Keep refresh indicator visible briefly
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _showWifiSelectionBottomSheet(BuildContext context) async {
    final wifiList = await context.read<AddDeviceBloc>().repository.scanDevices(
      true,
    );

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                const SizedBox(height: 16),

                const Text(
                  "Select WiFi Network",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const Divider(),

                Expanded(
                  child: ListView.builder(
                    itemCount: wifiList.length,
                    itemBuilder: (_, index) {
                      final ssid = wifiList[index];

                      return ListTile(
                        leading: const Icon(Icons.wifi),
                        title: Text(ssid),

                        onTap: () {
                          Navigator.pop(context);

                          _showPasswordBottomSheet(context, ssid);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPasswordBottomSheet(
    BuildContext context,
    String ssid,
  ) async {
    final controller = TextEditingController();

    bool obscureText = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    ssid,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextField(
                    controller: controller,

                    obscureText: obscureText,

                    decoration: InputDecoration(
                      labelText: "Password",

                      border: const OutlineInputBorder(),

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),

                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                        context.read<AddDeviceBloc>().add(
                          ConfigureDeviceWifi(
                            ssid: ssid,
                            password: controller.text,
                          ),
                        );
                      },

                      child: const Text("Connect"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (_) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),

              SizedBox(width: 20),

              Expanded(child: Text("Configuring device...")),
            ],
          ),
        );
      },
    );
  }

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
          onPressed: () => Navigator.pop(context),
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

      body: BlocConsumer<AddDeviceBloc, AddDeviceState>(
        listener: (context, state) {
          if (state.status == WifiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Something went wrong"),
              ),
            );
          }
          if (state.status == WifiStatus.connected) {
            _showWifiSelectionBottomSheet(context);
          }

          if (state.status == WifiStatus.configuring) {
            _showLoadingDialog(context);
          }

          if (state.status == WifiStatus.configured) {
            Navigator.pop(context); // close loading dialog

            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeviceHomeScreen()),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _refreshDevices,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      const Text(
                        "Searching for nearby devices...",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Make sure the device is powered on and in pairing mode",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),

                      const SizedBox(height: 40),

                      if (state.status == WifiStatus.disabled ||
                          state.status == WifiStatus.enabling ||
                          state.status == WifiStatus.enabled ||
                          state.status == WifiStatus.scanning)
                        Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: state.status == WifiStatus.disabled
                                    ? () {
                                        context.read<AddDeviceBloc>().add(
                                          EnableWifiPressed(),
                                        );
                                      }
                                    : null,
                                child: WifiScannerScreen(
                                  iswifiEnabled:
                                      state.status != WifiStatus.disabled,
                                  isScanning:
                                      state.status == WifiStatus.scanning,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Center(
                              child: Text(
                                _statusText(state.status),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),

                      if (state.devices.isNotEmpty)
                        Column(
                          children: [
                            Center(
                              child: Text(
                                "Pull down to scan again",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.devices.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .8,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemBuilder: (context, index) {
                                return DeviceCard(
                                  deviceName: state.devices[index],
                                  onTap: () {
                                    context.read<AddDeviceBloc>().add(
                                      ConnectToDevice(state.devices[index]),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                      if (state.devices.isEmpty &&
                          state.status == WifiStatus.devicesFound)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              "No devices found.\nPull down to scan again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Text(
          "Devices will be added automatically.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }

  String _statusText(WifiStatus status) {
    switch (status) {
      case WifiStatus.disabled:
        return "Tap WiFi icon to enable WiFi";
      case WifiStatus.enabling:
        return "Waiting for WiFi to be enabled";
      case WifiStatus.enabled:
        return "WiFi Enabled";
      case WifiStatus.scanning:
        return "Scanning nearby devices...";
      case WifiStatus.devicesFound:
        return "Devices Found";
      case WifiStatus.error:
        return "Failed to scan";
      case WifiStatus.connecting:
        return "Device Connecting";
      case WifiStatus.connected:
        return "Device Connected";
      case WifiStatus.configuring:
        return "Device Configuring";
      case WifiStatus.configured:
        return "Device Provisioned";
    }
  }
}
