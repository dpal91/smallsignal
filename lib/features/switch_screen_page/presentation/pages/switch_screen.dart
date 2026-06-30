import 'package:flutter/material.dart';
import 'package:room_automation/features/switch_screen_page/data/bloc/bloc/switch_bloc.dart';
import 'package:room_automation/features/switch_screen_page/data/model/switch_model.dart';
import 'package:room_automation/features/switch_screen_page/presentation/widgets/smart_switch_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchScreen extends StatefulWidget {
  final String deviceId;
  final String deviceName;

  const SwitchScreen({
    super.key,
    required this.deviceId,
    required this.deviceName,
  });

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SwitchBloc>().add(StartListening(widget.deviceId));
  }

  Future<void> _refresh() async {
    context.read<SwitchBloc>().add(StartListening(widget.deviceId));
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.deviceName ?? "Device ")),

      body: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          if (state.status == DeviceStatus.loading && state.switches.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == DeviceStatus.error) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }

          final switchList = state.switches.entries.toList();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInstructionCard(),

                  const SizedBox(height: 16),

                  _buildVoltageCard(state.voltage),

                  const SizedBox(height: 24),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: switchList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: .72,
                        ),
                    itemBuilder: (_, index) {
                      final item = switchList[index];

                      return SmartSwitchCard(
                        name: item.key,
                        isOn: item.value,
                        onTap: () {
                          context.read<SwitchBloc>().add(
                            ToggleSwitchPressed(
                              switchId: item.key,
                              newState: !item.value,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  _buildBottomActions(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Long press to edit switch name",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Icon(Icons.info_outline, color: Colors.grey.shade700),
        ],
      ),
    );
  }

  Widget _buildVoltageCard(double voltage) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            const Icon(Icons.electric_bolt, color: Colors.orange, size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Current Voltage",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "${voltage.toStringAsFixed(1)} V",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(Icons.power_settings_new, "All On", () {}),
        _actionButton(Icons.timer_outlined, "Timer", () {}),
        _actionButton(Icons.settings_outlined, "Setting", () {}),
        _actionButton(Icons.power_off, "All Off", () {}),
      ],
    );
  }

  Widget _actionButton(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(radius: 28, child: Icon(icon)),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}
