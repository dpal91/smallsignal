import 'package:flutter/material.dart';

class WifiScannerScreen extends StatefulWidget {
  const WifiScannerScreen({super.key});

  @override
  State<WifiScannerScreen> createState() => _WifiScannerScreenState();
}

class _WifiScannerScreenState extends State<WifiScannerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF2196F3);

    return Container(
      width: double.maxFinite,
      child: SizedBox(
        width: 250,
        height: 250,
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Stack(
              alignment: Alignment.center,
              children: [
                _buildRipple(0.0, color),
                _buildRipple(0.3, color),
                _buildRipple(0.66, color),

                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.wifi, color: Colors.white, size: 40),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRipple(double delay, Color color) {
    double progress = (controller.value - delay) % 1.0;

    return Container(
      width: 80 + (progress * 140),
      height: 80 + (progress * 140),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(1 - progress), width: 2),
      ),
    );
  }
}
